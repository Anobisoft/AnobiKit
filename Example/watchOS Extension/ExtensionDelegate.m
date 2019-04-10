//
//  ExtensionDelegate.m
//  Example_watchOS Extension
//
//  Created by Stanislav Pletnev on 09/04/2019.
//  Copyright © 2019 anobisoft. All rights reserved.
//

#import "ExtensionDelegate.h"
#import "AKExample.h"

@implementation ExtensionDelegate

- (void)applicationDidFinishLaunching {
    [AKExample.shared locationManagerExample];
}

@end
