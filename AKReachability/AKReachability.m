//
//  AKReachability.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 24.10.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#if TARGET_OS_IOS

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

static AKReachability *_cachedInstance;
static NSMutableDictionary<NSString *, AKReachability *> *_hostRechabilityInstanceCache;

#pragma mark - instantiate

+ (instancetype)new {
    return _cachedInstance ?: self.reachabilityForInternetConnection;
}

+ (instancetype)reachabilityWithSocketAddress:(const struct sockaddr *)socketAddress {
    SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, socketAddress);
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
    return [self reachabilityWithSocketAddress:(const struct sockaddr *)&zeroAddress];
}



+ (instancetype)reachabilityWithHostname:(NSString *)hostname {
    if (!_hostRechabilityInstanceCache) {
        _hostRechabilityInstanceCache = [NSMutableDictionary new];
    }
    id cachedInstance = _hostRechabilityInstanceCache[hostname];
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

#pragma mark - dealloc

- (void)dealloc {
    self.delegate = nil;
    if (_reachabilityRef) {
        CFRelease(_reachabilityRef);
    }
}

#pragma mark - holding instances

- (void)hold {
    if (_host) {
        _hostRechabilityInstanceCache[_host] = self;
    } else {
        _cachedInstance = self;
    }
}

- (void)free {
    if (_host && self == _hostRechabilityInstanceCache[_host]) {
        [_hostRechabilityInstanceCache removeObjectForKey:_host];
    } else {
        if (_cachedInstance == self) _cachedInstance = nil;
    }
}

#pragma mark - status

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

#pragma mark - delegate

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

#endif
