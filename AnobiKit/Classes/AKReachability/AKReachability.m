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
}

- (instancetype)initWithNetworkReachabilityRef:(SCNetworkReachabilityRef)reachabilityRef {
    if (self = [super init]) {
        _reachabilityRef = reachabilityRef;
    } else {
        CFRelease(reachabilityRef);
    }
    return self;
}

+ (instancetype)reachabilityWithHostname:(NSString *)hostname {
    static NSMutableDictionary<NSString *, AKReachability *> *rechabilityByHostname;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rechabilityByHostname = [NSMutableDictionary new];
    });
    AKReachability *instance = rechabilityByHostname[hostname];
    if (instance) return instance;
    SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithName(NULL, [hostname UTF8String]);
    instance = reachabilityRef ? [[self alloc] initWithNetworkReachabilityRef:reachabilityRef] : nil;
    if (instance) rechabilityByHostname[hostname] = instance;
    return instance;
}

+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress {
    SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, hostAddress);
    return reachabilityRef ? [[self alloc] initWithNetworkReachabilityRef:reachabilityRef] : nil;
}

+ (instancetype)reachabilityForInternetConnection {
    static AKReachability *singleInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        struct sockaddr_in zeroAddress;
        bzero(&zeroAddress, sizeof(zeroAddress));
        zeroAddress.sin_len = sizeof(zeroAddress);
        zeroAddress.sin_family = AF_INET;
        singleInstance = [self reachabilityWithAddress:(const struct sockaddr *)&zeroAddress];
    });
    return singleInstance;
}

- (void)dealloc {
    self.delegate = nil;
    if (_reachabilityRef) {
        CFRelease(_reachabilityRef);
    }
}


+ (AKReachabilityStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags {
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
    AKReachabilityStatus status = AKRStatusNotReachable;
    SCNetworkReachabilityFlags flags;
    if (SCNetworkReachabilityGetFlags(_reachabilityRef, &flags)) {
        status = [AKReachability networkStatusForFlags:flags];
    }    
    return status;
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
        if (_reachabilityRef) SCNetworkReachabilityUnscheduleFromRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    }

}

static void AKReachabilityCallback(__unused SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info) {
    NSCAssert(info != NULL, @"info was NULL in AKReachabilityCallback");
    if ([(__bridge NSObject *)info isKindOfClass:[AKReachability class]]) {
        AKReachability *reachability = (__bridge AKReachability *)info;
        if (reachability.delegate) {
            [reachability.delegate reachability:reachability didChangeStatus:[AKReachability networkStatusForFlags:flags]];
        }
    } else {
        NSLog(@"[ERROR] info was wrong class in AKReachabilityCallback");
    }
}


@end

