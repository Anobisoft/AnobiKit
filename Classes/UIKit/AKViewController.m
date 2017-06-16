//
//  AKViewController.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 16.06.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKViewController.h"

@interface AKViewController ()

@end

@implementation AKViewController

@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self shouldDismissDelegated:AKDismissReasonMemoryWarning];
}

- (void)shouldDismissDelegated:(AKDismissReason)reason {
    if (self.delegate) {
        [self.delegate viewController:self shouldDismiss:reason];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewController:willDisappear:)]) {
        [self.delegate viewController:self willDisappear:animated];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewController:didDisappear:)]) {
        [self.delegate viewController:self didDisappear:animated];
    }
}

@end
