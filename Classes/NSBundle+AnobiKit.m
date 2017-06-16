//
//  NSBundle+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 13.05.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "NSBundle+AnobiKit.h"

@implementation NSBundle (AnobiKit)

+ (NSString *)appVersion {
    return [NSString stringWithFormat:@"%@b%@", [self appShortVersion], [self appBuildVersion]];
}

+ (NSString *)appShortVersion {
    return [[[self mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildVersion {
    return [[[self mainBundle] infoDictionary] objectForKey:(id)kCFBundleVersionKey];
}

+ (NSString *)appName {
    return [NSBundle mainBundle].infoDictionary[(NSString*)kCFBundleNameKey];
}

+ (NSString *)appDisplayName {
    return [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"] ?: [self appName];
}





@end
