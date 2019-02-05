//
//  AKVersion.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 13/08/2018.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import "AKVersion.h"
#import "NSBundle+AnobiKit.h"


@implementation AKVersion

+ (instancetype)versionWithString:(NSString *)string {
    return [[self alloc] initWithString:string];
}

+ (instancetype)appVersion {
    static id _appVersion;
    if (_appVersion) {
        return _appVersion;
    }
    return _appVersion = [[self alloc] initWithString:[NSBundle appShortVersion] build:[NSBundle appBuildVersion]];
}

- (instancetype)initWithString:(NSString *)string build:(NSString *)build {
    if (self = [self initWithString:string]) {
        NSInteger b = build.integerValue;
        if (b < 0) {
            @throw NSInternalInconsistencyException;
            return nil;
        }
        self.build = b;
    }
    return self;
}

- (instancetype)initWithString:(NSString *)string {
    if (self = [self init]) {
        NSArray<NSString *> *parts = [string componentsSeparatedByString:@"."];
        if (parts.count > 4) {
            @throw NSInternalInconsistencyException;
            return nil;
        }
        if (parts.count == 0) {
            @throw NSInternalInconsistencyException;
            return nil;
        }
        for (int i = 0; i < parts.count; i++) {
            NSInteger part = parts[i].integerValue;
            if (part < 0) {
                @throw NSInternalInconsistencyException;
                return nil;
            }
            switch (i) {
                case 0:
                    self.major = part;
                    break;
                case 1:
                    self.minor = part;
                    break;
                case 2:
                    self.patch = part;
                    break;
                case 3:
                    self.build = part;
                    break;
                default:
                    @throw NSInternalInconsistencyException;
                    break;
            }
        }
    }
    return self;
}

+ (NSString *)trim:(NSString *)version {
    while ([version hasSuffix:@".0"]) {
        version = [version substringToIndex:version.length - 2];
    }
    return version;
}

- (NSString *)stringWithFormat:(NSString *)format { // MJ.MN.P.B
    if (!format) format = @"%MJ.%MN.%P.%B";
    NSString *escape = [NSUUID UUID].UUIDString;
    format = [format stringByReplacingOccurrencesOfString:@"%%" withString:escape];
    format = [format stringByReplacingOccurrencesOfString:@"%MJ" withString:@(self.major).stringValue];
    format = [format stringByReplacingOccurrencesOfString:@"%MN" withString:@(self.minor).stringValue];
    format = [format stringByReplacingOccurrencesOfString:@"%P" withString:@(self.patch).stringValue];
    format = [format stringByReplacingOccurrencesOfString:@"%B" withString:@(self.build).stringValue];
    format = [format stringByReplacingOccurrencesOfString:escape withString:@"%"];
    return format;
}

- (NSString *)stringWithStyle:(AKVersionFormatStyle)style {
    switch (style) {
        case AKVersionFormatStyleShort:
            return [self shortString];
        case AKVersionFormatStyleMedium:
            return [self mediumString];
        case AKVersionFormatStyleLong:
            return [self longString];
        case AKVersionFormatStyleFull:
            return [self fullString];
        default:
            return [self string];
    }
}

- (NSString *)shortString { // AKVersionFormatStyleShort
    return [self.class trim:[self stringWithFormat:@"%MJ.%MN.%P.%B"]];
}

- (NSString *)string { // AKVersionFormatStyleDefault
    return [self stringWithFormat:nil];
}

- (NSString *)mediumString { // AKVersionFormatStyleMedium
    return [self stringWithFormat:@"v%MJ.%MN.%Pb%B"];
}

- (NSString *)longString { // AKVersionFormatStyleLong
    return [self stringWithFormat:@"v%MJ.%MN.%P build %B"];
}

- (NSString *)fullString { // AKVersionFormatStyleFull
    return [self stringWithFormat:@"version %MJ.%MN.%P build %B"];
}

- (NSString *)description {
    return self.string;
}

- (NSString *)debugDescription {
    NSString *version = [self stringWithFormat:@"\nmajor(MJ):%MJ\nminor(MN):%MN\npatch(P) :%P\nbuild(B) :%B"];
    return [NSString stringWithFormat:@"%@%@", super.description, version];
}

@end
