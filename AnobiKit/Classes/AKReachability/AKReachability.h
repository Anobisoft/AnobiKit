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
#import <AnobiKit/AKInterfaces.h>

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

@interface AKReachability : NSObject <DisableNSInit>

+ (instancetype)reachabilityWithHostname:(NSString *)hostname;
+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;
+ (instancetype)reachabilityForInternetConnection;

- (void)hold;
- (void)free;

@property (readonly) AKReachabilityStatus currentStatus;
@property (weak, nonatomic) id<AKReachabilityDelegate> delegate;

@end


