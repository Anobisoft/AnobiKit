//
//  AKReachability.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 24.10.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <CoreFoundation/CoreFoundation.h>

#import "AKReachability.h"

@implementation AKReachability {
    SCNetworkReachabilityRef _reachabilityRef;
    NSString *_host;
    AKReachabilityStatus _currentStatus;
}

+ (instancetype)new {
    return self.reachabilityForInternetConnection;
}

+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress {
    SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, hostAddress);
    if (!reachabilityRef) {
        return nil;
    }
    return [[self alloc] initWithNetworkReachabilityRef:reachabilityRef];
}

- (instancetype)initWithNetworkReachabilityRef:(SCNetworkReachabilityRef)reachabilityRef {
    if (self = [super init]) {
        _reachabilityRef = reachabilityRef;
    } else {
        CFRelease(reachabilityRef);
    }
    return self;
}

+ (instancetype)reachabilityForInternetConnection {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    return [self reachabilityWithAddress:(const struct sockaddr *)&zeroAddress];
}

static NSMutableDictionary<NSString *, AKReachability *> *_rechabilityByHostname;

+ (instancetype)reachabilityWithHostname:(NSString *)hostname {
    if (!_rechabilityByHostname) {
        _rechabilityByHostname = [NSMutableDictionary new];
    }
    id cachedInstance = _rechabilityByHostname[hostname];
    if (cachedInstance) return cachedInstance;
    
    SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithName(NULL, [hostname UTF8String]);
    if (!reachabilityRef) {
        return nil;
    }
    return [[self alloc] initWithNetworkReachabilityRef:reachabilityRef host:hostname];
}

- (instancetype)initWithNetworkReachabilityRef:(SCNetworkReachabilityRef)reachabilityRef host:(NSString *)host {
    if (self = [self initWithNetworkReachabilityRef:reachabilityRef]) {
        _host = host;
        _currentStatus = AKRStatusInvalid;
    }
    return self;
}




- (void)dealloc {
    self.delegate = nil;
    if (_reachabilityRef) {
        CFRelease(_reachabilityRef);
    }
}

static AKReachability *_holdedInstance;

- (void)hold {
    if (_host) {
        _rechabilityByHostname[_host] = self;
    } else {
        _holdedInstance = self;
    }
}

- (void)free {
    if (_host && self == _rechabilityByHostname[_host]) {
        [_rechabilityByHostname removeObjectForKey:_host];
    } else {
        if (_holdedInstance == self) _holdedInstance = nil;
    }
}

AKReachabilityStatus AKReachabilityStatusForFlags(SCNetworkReachabilityFlags flags) {
    if (!(flags & kSCNetworkReachabilityFlagsReachable)) {
        return AKRStatusNotReachable;
    }
    
    AKReachabilityStatus result = (flags & kSCNetworkReachabilityFlagsConnectionRequired) ? AKRStatusNotReachable : AKRStatusConnectionNotRequired;
    
    if ( ((flags & kSCNetworkReachabilityFlagsConnectionOnDemand) || (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic))
        && !(flags & kSCNetworkReachabilityFlagsInterventionRequired)) {
        return AKRStatusReachableViaWiFi;
    }
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN) {
        return AKRStatusReachableViaWWAN;
    }
    
    return result;
}


- (AKReachabilityStatus)currentStatus {
    if (_currentStatus == AKRStatusInvalid || !_delegate) {
        _currentStatus = AKRStatusNotReachable;
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(_reachabilityRef, &flags)) {
            _currentStatus = AKReachabilityStatusForFlags(flags);
        }
    }
    return _currentStatus;
}



@synthesize delegate = _delegate;

- (void)setDelegate:(id<AKReachabilityDelegate>)delegate {
    if (delegate) {
        if (!_delegate) {
            SCNetworkReachabilityContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
            if (SCNetworkReachabilitySetCallback(_reachabilityRef, AKReachabilityCallback, &context)) {
                if (SCNetworkReachabilityScheduleWithRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode)) {
                    _delegate = delegate;
                }
            }
        } else {
            _delegate = delegate;
        }
    } else {
        _delegate = delegate;
        if (_reachabilityRef) {
            SCNetworkReachabilityUnscheduleFromRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
        }
    }
}

static void AKReachabilityCallback(__unused SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void *info) {
    NSCAssert(info != NULL, @"info was NULL in AKReachabilityCallback");
    if (![(__bridge NSObject *)info isKindOfClass:AKReachability.class]) {
        NSLog(@"[ERROR] info was wrong class in AKReachabilityCallback");
        return ;
    }
    AKReachability *reachability = (__bridge AKReachability *)info;
    if (reachability.delegate) {
        AKReachabilityStatus status = AKReachabilityStatusForFlags(flags);
        reachability->_currentStatus = status;
        [reachability.delegate reachability:reachability didChangeStatus:status];
    }
}


@end

