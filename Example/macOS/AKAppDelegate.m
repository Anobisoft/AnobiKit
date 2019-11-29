//
//  AKAppDelegate.m
//  Example_macOS
//
//  Created by Stanislav Pletnev on 2019-04-09.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import "AKAppDelegate.h"
#import "AKExample.h"

@interface AKAppDelegate ()

@end

@implementation AKAppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [AKExample.shared locationManagerExample];
}

@end
