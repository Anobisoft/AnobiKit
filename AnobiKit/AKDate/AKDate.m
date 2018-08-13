//
//  AKDate.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2016-10-04
//  Copyright © 2016 Anobisoft. All rights reserved.
//

#import "AKDate.h"

#pragma mark -

@implementation NSDate (CurrentCalendar)

+ (NSCalendar *)cachedCurrentCalendar {
    static NSCalendar *_cachedCurrentCalendar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cachedCurrentCalendar = [NSCalendar currentCalendar]; //static local copy
    });
    return _cachedCurrentCalendar;
}

- (NSDate *)CCStartOfDay {
    return [[NSDate cachedCurrentCalendar] startOfDayForDate:self];
}

- (NSDate *)CCNextDay {
    return [[NSDate cachedCurrentCalendar] dateByAddingUnit:NSCalendarUnitDay value:1 toDate:self options:0];
}

- (NSDate *)CCNextDayStart {
    return [[self CCNextDay] CCStartOfDay];
}

- (NSDate *)CCPreviousDay {
    return [[NSDate cachedCurrentCalendar] dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:self options:0];
}

- (NSDate *)CCPreviousDayStart {
    return [[self CCPreviousDay] CCStartOfDay];
}

- (NSDate *)CCdateWithTime:(NSDate *)time {
    return [[self CCStartOfDay] dateByAddingTimeInterval:[time CCTimeIntervalSinceDayStart]];
}

- (NSTimeInterval)CCTimeIntervalSinceDayStart {
    return [self timeIntervalSinceDate:[self CCStartOfDay]];
}

- (NSDate *)CCDayStartWithTimeZone:(NSTimeZone *)timeZone {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = timeZone;
    return [calendar startOfDayForDate:self];
}

@end



#pragma mark -

@implementation NSDate (DateFormatter)

- (NSString *)localizedStringWithDateStyle:(NSDateFormatterStyle)dstyle
                                 timeStyle:(NSDateFormatterStyle)tstyle {
    return [NSDateFormatter localizedStringFromDate:self dateStyle:dstyle timeStyle:tstyle];
}

- (NSString *)localizedStringWithDateStyle:(NSDateFormatterStyle)dstyle
                                 timeStyle:(NSDateFormatterStyle)tstyle
                                  timeZone:(NSTimeZone *)timeZone {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dstyle;
    formatter.timeStyle = tstyle;
    formatter.timeZone = timeZone;
    return [formatter stringFromDate:self];
}

@end
