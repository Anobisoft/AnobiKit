//
//  InterfaceController.m
//  Example_watchOS Extension
//
//  Created by Stanislav Pletnev on 09/04/2019.
//  Copyright © 2019 anobisoft. All rights reserved.
//

#import "InterfaceController.h"
#import <AnobiKit/AnobiKit.h>
#import <AnobiKit/NSBundle+UIKit.h>
#import <AnobiKit/UIColor+Hex.h>


@interface InterfaceController ()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



