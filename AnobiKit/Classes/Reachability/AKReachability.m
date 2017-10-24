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

+ (instancetype)reachabilityWithHostName:(NSString *)hostName {
    SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithName(NULL, [hostName UTF8String]);
    return reachabilityRef ? [[self alloc] initWithNetworkReachabilityRef:reachabilityRef] : nil;
}

+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress {
    SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, hostAddress);
    return reachabilityRef ? [[self alloc] initWithNetworkReachabilityRef:reachabilityRef] : nil;
}

+ (instancetype)reachabilityForInternetConnection {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    return [self reachabilityWithAddress:(const struct sockaddr *)&zeroAddress];
}

- (void)dealloc {
    if (_reachabilityRef) {
        CFRelease(_reachabilityRef);
    }
}


- (AKReachabilityStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags {
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
        status = [self networkStatusForFlags:flags];
    }    
    return status;
}


@end

