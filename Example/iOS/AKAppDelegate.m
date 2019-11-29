//
//  AKAppDelegate.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-02-08.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKAppDelegate.h"
#import "AKExample.h"

@implementation AKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [AKExample.shared listExample];
    
    return YES;
}

@end
