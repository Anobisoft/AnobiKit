//
//  AKVersion.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 13/08/2018.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AKVersionFormatStyle) {
    AKVersionFormatStyleShort = 0, // trimmed %MJ.%MN.%P.%B
    AKVersionFormatStyleDefault, // %MJ.%MN.%P.%B
    AKVersionFormatStyleMedium, // v%MJ.%MN.%Pb%B
    AKVersionFormatStyleLong, // v%MJ.%MN.%P build %B
    AKVersionFormatStyleFull, // version %MJ.%MN.%P build %B
};

@interface AKVersion : NSObject

+ (instancetype)versionWithString:(NSString *)string; // AKVersionFormatStyleDefault or trimmed
+ (instancetype)appVersion;

@property NSUInteger major;
@property NSUInteger minor;
@property NSUInteger patch;
@property NSUInteger build;


- (NSString *)stringWithFormat:(NSString *)format; // %MJ - major, %MN - minor, %P - patch, %B - build, %% - %
- (NSString *)stringWithStyle:(AKVersionFormatStyle)style;

- (NSString *)shortString; // AKVersionFormatStyleShort
- (NSString *)string; // AKVersionFormatStyleDefault
- (NSString *)mediumString; // AKVersionFormatStyleMedium
- (NSString *)longString; // AKVersionFormatStyleLong
- (NSString *)fullString; // AKVersionFormatStyleFull

+ (NSString *)trim:(NSString *)version; // right trim of ".0"

@end
