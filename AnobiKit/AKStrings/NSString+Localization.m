//
//  NSString+Localization.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2018-11-11.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import "NSString+Localization.h"
#import <AnobiKit/AKFoundation.h>

@implementation NSString (Localization)

- (NSString *)localized {
    return [NSBundle.mainBundle localizedStringForKey:self];
}

@end
