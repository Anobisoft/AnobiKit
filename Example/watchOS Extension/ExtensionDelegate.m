//
//  ExtensionDelegate.m
//  Example_watchOS Extension
//
//  Created by Stanislav Pletnev on 2019-04-09.
//  Copyright © 2019 anobisoft. All rights reserved.
//

#import "ExtensionDelegate.h"
#import "AKExample.h"

@implementation ExtensionDelegate

- (void)applicationDidFinishLaunching {
    [AKExample.shared locationManagerExample];
}

@end
