//
//  AKMainViewController.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 08/02/2017.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKMainViewController.h"
#import <AnobiKit/AnobiKit.h>

@interface AKMainViewController()

@end

@implementation AKMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIAlertAction *imageAction = UIAlertActionDefaultStyleMake(@"", ^{
        NSLog(@"Close alert");
    });
    imageAction.image = [UIImage imageNamed:@"checkmark"];
    [self showAlert:nil actions:@[imageAction]];
}

- (UIAlertControllerStyle)alertControllerPreferredStyle {
    return UIAlertControllerStyleAlert;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
