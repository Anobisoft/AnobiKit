//
//  AKDate.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2016-10-04
//  Copyright © 2016 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CurrentCalendar)
- (NSDate *)CCStartOfDay;
- (NSDate *)CCNextDay;
- (NSDate *)CCNextDayStart;
- (NSDate *)CCPreviousDay;
- (NSDate *)CCPreviousDayStart;
- (NSDate *)CCdateWithTime:(NSDate *)time;
- (NSTimeInterval)CCTimeIntervalSinceDayStart;
- (NSDate *)CCDayStartWithTimeZone:(NSTimeZone *)timeZone;
- (NSDate *)CCAddUnit:(NSCalendarUnit)unit value:(NSInteger)value;
@end

@interface NSDate (DateFormatter)

- (NSString *)localizedStringWithDateStyle:(NSDateFormatterStyle)dstyle timeStyle:(NSDateFormatterStyle)tstyle;
- (NSString *)localizedStringWithDateStyle:(NSDateFormatterStyle)dstyle timeStyle:(NSDateFormatterStyle)tstyle timeZone:(NSTimeZone *)timeZone;

@end

@interface NSDate (Comparison)

- (BOOL)earlyStricly:(NSDate *)date;
- (BOOL)earlyInclusively:(NSDate *)date;
- (BOOL)laterStricly:(NSDate *)date;
- (BOOL)laterInclusively:(NSDate *)date;

@end
