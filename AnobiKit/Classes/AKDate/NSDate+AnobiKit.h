//
//  NSDate+AnobiKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2016-10-04
//  Copyright © 2016 Anobisoft. All rights reserved.
//

#ifndef NSDate_AnobiKit_h
#define NSDate_AnobiKit_h

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
@end

@interface NSDate (DateFormatter)

- (NSString *)stringForLog;
- (NSString *)localizedStringWithTimeZone:(NSTimeZone *)timeZone dateStyle:(NSDateFormatterStyle)dstyle timeStyle:(NSDateFormatterStyle)tstyle;


@end

#endif
