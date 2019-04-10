//
//  AKAppDelegate.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 08/02/2017.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKAppDelegate.h"
#import "AKExample.h"

@implementation AKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [AKExample.shared locationManagerExample];
    
    return YES;
}

@end
