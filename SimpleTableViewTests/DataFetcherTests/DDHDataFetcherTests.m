//
//  DDHDataFetcherTests.m
//  SimpleTableView
//
//  Created by dasdom on 04.04.14.
//  Copyright (c) 2014 dasdom. All rights reserved.
//
// The MIT License (MIT)
//
// Copyright (c) 2014 Dominik Hauser
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import <XCTest/XCTest.h>
#import "OHHTTPStubs.h"
#import "DDHDataFetcher.h"

@interface DDHDataFetcherTests : XCTestCase
@property (nonatomic, strong) DDHDataFetcher *dataFetcher;
@property (nonatomic, assign) BOOL done;
@end

@implementation DDHDataFetcherTests

- (void)setUp
{
    [super setUp];
    self.dataFetcher = [[DDHDataFetcher alloc] init];
    self.done = NO;
}

- (void)tearDown {
    self.dataFetcher = nil;
    [OHHTTPStubs removeAllStubs];
    [super tearDown];
}

- (BOOL)waitForCompletion:(NSTimeInterval)timeoutSecs {
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0)
            break;
    } while (!self.done);
    
    return self.done;
}

- (void)testThatFetchGlobalStreamCallsAPI {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        NSLog(@"request.URL.absoluteString: %@", request.URL.absoluteString);
        BOOL adnAPICall = [request.URL.host isEqualToString:@"alpha-api.app.net"];
        if (adnAPICall) {
            XCTAssertEqualObjects(request.URL.absoluteString, @"https://alpha-api.app.net/stream/0/posts/stream/global");
        }
        return adnAPICall;
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        return nil;
    }];
    
    typeof(self) __weak weakSelf = self;
    [self.dataFetcher fetchGlobalWithCompletion:^(NSArray *globalPostArray, NSError *error) {
        typeof(self) __strong strongSelf = weakSelf;
        strongSelf.done = YES;
    }];
    
    XCTAssertTrue([self waitForCompletion:5.0f], @"Didn't complete in expected time.");
}

- (void)testThatFetchGlobalStreamReturnsExpectedResponse {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        NSLog(@"request.URL.absoluteString: %@", request.URL.absoluteString);
        BOOL adnAPICall = [request.URL.host isEqualToString:@"alpha-api.app.net"];
        if (adnAPICall) {
            XCTAssertEqualObjects(request.URL.absoluteString, @"https://alpha-api.app.net/stream/0/posts/stream/global");
        }
        return adnAPICall;
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"globalStreamResponse" ofType:@"json"];
        NSLog(@"path: %@", path);
        return [OHHTTPStubsResponse responseWithFileAtPath:path statusCode:200 headers:@{@"Content-Type":@"text/json"}];
    }];
    
    typeof(self) __weak weakSelf = self;
    [self.dataFetcher fetchGlobalWithCompletion:^(NSArray *globalPostArray, NSError *error) {
        typeof(self) __strong strongSelf = weakSelf;
        XCTAssertEqual([globalPostArray count], 1);
        NSDictionary *expecedResponse = @{@"text" : @"This is an easy test response."};
        id firstResponseElement = [globalPostArray firstObject];
        XCTAssertNotNil(firstResponseElement);
        XCTAssertTrue([firstResponseElement isKindOfClass:[NSDictionary class]]);
        XCTAssertEqual([(NSDictionary*)firstResponseElement count], [expecedResponse count]);
        for (NSString *keyStrings in expecedResponse) {
            XCTAssertEqualObjects(expecedResponse[keyStrings], firstResponseElement[keyStrings]);
        }
        strongSelf.done = YES;
    }];
    
    XCTAssertTrue([self waitForCompletion:5.0f], @"Didn't complete in expected time.");
}

@end
