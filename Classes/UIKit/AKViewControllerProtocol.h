//
//  AKViewControllerProtocol.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 16.06.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AKDismissReason) {
    AKDismissReasonUserInteract,
    AKDismissReasonProcessCompletion,
    AKDismissReasonMemoryWarning,
};

@protocol AKViewControllerDelegate <NSObject>

@required
- (void)viewController:(UIViewController *)vc shouldDismiss:(AKDismissReason)reason;
@optional
- (void)viewController:(UIViewController *)vc willDisappear:(BOOL)animated;
- (void)viewController:(UIViewController *)vc didDisappear:(BOOL)animated;
@end

@protocol AKViewController <NSObject>
@required
@property (weak) id<AKViewControllerDelegate> delegate;
- (void)shouldDismissDelegated:(AKDismissReason)reason;
@optional
- (void)reloadData;

@end
