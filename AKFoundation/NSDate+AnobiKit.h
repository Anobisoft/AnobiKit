//
//  NSDate+AnobiKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2016-10-04
//  Copyright © 2016 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CurrentCalendar)
- (NSDate *)ccStartOfDay;
- (NSDate *)ccNextDay;
- (NSDate *)ccNextDayStart;
- (NSDate *)ccPreviousDay;
- (NSDate *)ccPreviousDayStart;
- (NSDate *)ccdateWithTime:(NSDate *)time;
- (NSTimeInterval)ccTimeIntervalSinceDayStart;
- (NSDate *)ccDayStartWithTimeZone:(NSTimeZone *)timeZone;
- (NSDate *)ccAddUnit:(NSCalendarUnit)unit value:(NSInteger)value;
@end

@interface NSDate (DateFormatter)

- (NSString *)localizedStringWithDateStyle:(NSDateFormatterStyle)dstyle timeStyle:(NSDateFormatterStyle)tstyle;
- (NSString *)localizedStringWithDateStyle:(NSDateFormatterStyle)dstyle timeStyle:(NSDateFormatterStyle)tstyle timeZone:(NSTimeZone *)timeZone;

@end

@interface NSDate (Comparison)

- (BOOL)earlierStricly:(NSDate *)date;
- (BOOL)earlierInclusively:(NSDate *)date;
- (BOOL)laterStricly:(NSDate *)date;
- (BOOL)laterInclusively:(NSDate *)date;

@end
