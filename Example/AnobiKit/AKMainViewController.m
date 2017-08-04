//
//  AKMainViewController.m
//  AnobiKit
//
//  Created by anobisoft on 08/02/2017.
//  Copyright (c) 2017 anobisoft. All rights reserved.
//

#import "AKMainViewController.h"
#import "AKTheme.h"
#import "CALayer+AKFlipAnimation.h"

@interface AKMainViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AKMainViewController {
    __weak IBOutlet UILabel *themeNameLabel;
    __weak IBOutlet UIView *gridView;
    AKTheme *currentTheme;
    CAAnimation *flipAnimation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    [self updateUIWithCurrentTheme];
    
    flipAnimation = [CALayer flipAnimationWithPiСoef:2.0 rotationVector:AK3DVectorMake(0.3, 0.5, 0)];
    
}

- (IBAction)nextThemeTap:(id)sender {
    NSUInteger newIndex = [[AKTheme allNames] indexOfObject:currentTheme.name];
    newIndex++;
    newIndex %= [AKTheme allNames].count;
    [AKTheme setCurrentThemeNamed:[AKTheme allNames][newIndex]];
    [self updateUIWithCurrentTheme];
}

- (IBAction)flipTap:(id)sender {
    [gridView.layer addFlipAnimation:flipAnimation];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return (UIStatusBarStyle)currentTheme.barStyle;
}

- (void)updateUIWithCurrentTheme {
    if (currentTheme != [AKTheme currentTheme]) {
        currentTheme = [AKTheme currentTheme];
        [self setNeedsStatusBarAppearanceUpdate];
        
        self.navigationController.navigationBar.barStyle =
        self.navigationController.toolbar.barStyle = currentTheme.barStyle;
        
        self.navigationController.navigationBar.barTintColor =
        self.navigationController.toolbar.barTintColor = currentTheme[AKThemeColorKey_navibar];
        self.navigationController.toolbar.translucent = false;
        self.navigationController.toolbar.clipsToBounds = false;
        
        self.navigationController.navigationBar.tintColor =
        self.navigationController.toolbar.tintColor = currentTheme[AKThemeColorKey_navibarTint];
        
        NSMutableDictionary *titleTextAttributes = self.navigationController.navigationBar.titleTextAttributes.mutableCopy;
        titleTextAttributes[NSForegroundColorAttributeName] = currentTheme[AKThemeColorKey_navibarTitle];
        self.navigationController.navigationBar.titleTextAttributes = titleTextAttributes;
        
        self.view.backgroundColor = currentTheme[AKThemeColorKey_mainBackground];
        
        themeNameLabel.textColor = currentTheme[AKThemeColorKey_mainText];
        themeNameLabel.text = [NSString stringWithFormat:@"Current Theme name: %@", currentTheme.name];
        
        self.tableView.tableFooterView.backgroundColor = self.tableView.backgroundColor = currentTheme[AKThemeColorKey_tableBackground];
        self.tableView.separatorColor = currentTheme[AKThemeColorKey_tableSeparator];
        self.tableView.tintColor = currentTheme[AKThemeColorKey_mainTint];
        [self.tableView reloadData];
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [AKTheme allNames].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = currentTheme[indexPath.row % 2 ? AKThemeColorKey_tableCellBackground : AKThemeColorKey_tableSecondaryCellBackground];
    cell.textLabel.textColor = currentTheme[indexPath.row % 2 ? AKThemeColorKey_mainText : AKThemeColorKey_mainSubtext ];
    cell.textLabel.text = [AKTheme allNames][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [AKTheme setCurrentThemeNamed:[AKTheme allNames][indexPath.row]];
    [self updateUIWithCurrentTheme];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
