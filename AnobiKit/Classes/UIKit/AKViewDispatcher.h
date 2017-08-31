//
//  AKViewDispatcher.h
//  ASUtilities
//
//  Created by Stanislav Pletnev on 2017-03-04
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AKViewObserver <NSObject>
@optional
- (void)viewDidLoadViewController:(UIViewController *)viewController;
- (void)viewWillAppear:(BOOL)animated viewController:(UIViewController *)viewController;
- (void)viewDidAppear:(BOOL)animated viewController:(UIViewController *)viewController;
- (void)viewWillDisappear:(BOOL)animated viewController:(UIViewController *)viewController;
- (void)viewDidDisappear:(BOOL)animated viewController:(UIViewController *)viewController;

@end

@interface AKViewDispatcher : NSObject

+ (UIViewController *)visibleViewController;
+ (UIViewController *)visibleViewControllerFrom:(UIViewController *)vc;

+ (void)addVCObserver:(id <AKViewObserver>)vcObserver;
+ (void)removeVCObserver:(id <AKViewObserver>)vcObserver;

//Abstract class
+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)alloc NS_UNAVAILABLE;


@end
