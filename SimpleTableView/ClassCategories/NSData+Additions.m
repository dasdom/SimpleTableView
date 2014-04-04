//
//  NSData+Additions.m
//  SimpleTableView
//
//  Created by dasdom on 04.04.14.
//  Copyright (c) 2014 dasdom. All rights reserved.
//

#import "NSData+Additions.h"

@implementation NSData (Additions)

- (NSString*)stringValueWithEncoding:(NSStringEncoding)encoding {
    return [[NSString alloc] initWithData:self encoding:encoding];
}

- (NSString*)stringValue {
    return [self stringValueWithEncoding:NSUTF8StringEncoding];
}

@end
