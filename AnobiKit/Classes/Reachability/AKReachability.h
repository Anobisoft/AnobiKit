//
//  AKReachability.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 24.10.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import "AKTypes.h"

typedef enum : NSInteger {
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

@interface AKReachability : NSObject <DisableStdInstantiating>

+ (instancetype)reachabilityWithHostname:(NSString *)hostname;
+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;
+ (instancetype)reachabilityForInternetConnection;

@property (readonly) AKReachabilityStatus currentStatus;
@property (weak, nonatomic) id<AKReachabilityDelegate> delegate;

@end


