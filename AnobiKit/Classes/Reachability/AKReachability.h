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

@interface AKReachability : NSObject <DisableStdInstantiating>

+ (instancetype)reachabilityWithHostName:(NSString *)hostName;
+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;
+ (instancetype)reachabilityForInternetConnection;

@property (readonly) AKReachabilityStatus currentStatus;

@end


