//
//  AKReachability.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 24.10.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#if TARGET_OS_IOS

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

typedef enum : NSInteger {
    AKRStatusInvalid = -1,
	AKRStatusNotReachable = 0,
	AKRStatusConnectionNotRequired,
	AKRStatusReachableViaWiFi,
	AKRStatusReachableViaWWAN
} AKReachabilityStatus;

@class AKReachability;

@protocol AKReachabilityDelegate
@required
- (void)reachability:(AKReachability *)reachability didChangeStatus:(AKReachabilityStatus)status;
@end

@interface AKReachability : NSObject

+ (instancetype)reachabilityForInternetConnection;
+ (instancetype)reachabilityWithHostname:(NSString *)hostname;
+ (instancetype)reachabilityWithSocketAddress:(const struct sockaddr *)socketAddress;

- (instancetype)init NS_UNAVAILABLE;

- (void)hold;
- (void)free;

@property (readonly) AKReachabilityStatus currentStatus;
@property (nonatomic, weak) id<AKReachabilityDelegate> delegate;

@end

#endif
