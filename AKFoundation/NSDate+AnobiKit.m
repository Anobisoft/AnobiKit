//
//  NSDate+AnobiKit.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2016-10-04
//  Copyright © 2016 Anobisoft. All rights reserved.
//

#import "NSDate+AnobiKit.h"

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

- (NSDate *)ccStartOfDay {
    return [[NSDate cachedCurrentCalendar] startOfDayForDate:self];
}

- (NSDate *)ccNextDay {
    return [self ccAddUnit:NSCalendarUnitDay value:1];
}

- (NSDate *)ccNextDayStart {
    return [[self ccNextDay] ccStartOfDay];
}

- (NSDate *)ccPreviousDay {
    return [self ccAddUnit:NSCalendarUnitDay value:-1];
}

- (NSDate *)ccPreviousDayStart {
    return [[self ccPreviousDay] ccStartOfDay];
}

- (NSDate *)ccdateWithTime:(NSDate *)time {
    return [[self ccStartOfDay] dateByAddingTimeInterval:[time ccTimeIntervalSinceDayStart]];
}

- (NSTimeInterval)ccTimeIntervalSinceDayStart {
    return [self timeIntervalSinceDate:[self ccStartOfDay]];
}

- (NSDate *)ccDayStartWithTimeZone:(NSTimeZone *)timeZone {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = timeZone;
    return [calendar startOfDayForDate:self];
}

- (NSDate *)ccAddUnit:(NSCalendarUnit)unit value:(NSInteger)value {
    return [[NSDate cachedCurrentCalendar] dateByAddingUnit:unit value:value toDate:self options:0];
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

@implementation NSDate (Comparison)

- (BOOL)earlierStricly:(NSDate *)date {
    return [self compare:date] == NSOrderedAscending;
}

- (BOOL)earlierInclusively:(NSDate *)date {
    return [self compare:date] != NSOrderedDescending;
}

- (BOOL)laterStricly:(NSDate *)date {
    return [self compare:date] == NSOrderedDescending;
}

- (BOOL)laterInclusively:(NSDate *)date {
    return [self compare:date] != NSOrderedAscending;
}

@end
