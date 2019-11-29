//
//  NSString+Concatenation.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2018-12-27.
//

#import "NSString+Concatenation.h"

@implementation NSString (Concatenation)

- (NSString *) :(NSString *)append {
    return [self stringByAppendingString:append];
}

- (NSString *) :(NSString *)append :(NSString *)second {
    return [@[self, append, second] componentsJoinedByString:@""];
}

- (NSString *) :(NSString *)append :(NSString *)second :(NSString *)third {
    return [@[self, append, second, third] componentsJoinedByString:@""];
}
- (NSString *) :(NSString *)append :(NSString *)second :(NSString *)third :(NSString *)forth {
    return [@[self, append, second, third, forth] componentsJoinedByString:@""];
}
- (NSString *) :(NSString *)append :(NSString *)second :(NSString *)third :(NSString *)forth :(NSString *)fifth {
    return [@[self, append, second, third, forth, fifth] componentsJoinedByString:@""];
}

- (NSString *)concat:(NSString *)append, ... {
    va_list args;
    va_start(args, append);
    
    NSMutableString *mutable = self.mutableCopy;
    [mutable appendString:append];
    
    NSString *string;
    while((string = va_arg(args, NSString *))) {
        [mutable appendString:string];
    }
    
    va_end(args);
    return mutable.copy;
}

@end
