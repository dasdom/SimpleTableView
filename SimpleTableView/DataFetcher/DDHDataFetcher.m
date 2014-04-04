//
//  DDHDataFetcher.m
//  SimpleTableView
//
//  Created by Dominik Hauser on 02.04.14.
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

#import "DDHDataFetcher.h"
#import "NSData+Additions.h"

static NSString *baseURLString = @"https://alpha-api.app.net/stream/0/";

static NSURL *globalStreamURL(void) { return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", baseURLString, @"posts/stream/global"]]; }

@implementation DDHDataFetcher

- (NSURLRequest*)requestWithURL:(NSURL*)url method:(NSString*)restMethod body:(NSDictionary*)body
{
    NSArray *allowedMethodNames = @[@"GET", @"POST", @"DELETE"];
    NSAssert([allowedMethodNames containsObject:restMethod], @"Only GET, POST and DELETE are allowed as rest methods at the moment.");
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    urlRequest.HTTPMethod = restMethod;
    
    if (body) {
        NSError *jsonError = nil;
        NSData *bodyData = [NSJSONSerialization dataWithJSONObject:body options:kNilOptions error:&jsonError];
        if (jsonError) {
            return nil;
        }
        urlRequest.HTTPBody = bodyData;
    }
    
    return urlRequest;
}

- (NSURLRequest*)postRequestWithURL:(NSURL*)url body:(NSDictionary*)body {
    return [self requestWithURL:url method:@"POST" body:body];
}

- (NSURLRequest*)getRequestWithURL:(NSURL*)url {
    return [self requestWithURL:url method:@"GET" body:nil];
}

#pragma mark - Requests
- (void)fetchGlobalWithCompletion:(void(^)(NSArray *postsArray, NSError *error))completion {
    NSURLRequest *urlRequest = [self getRequestWithURL:globalStreamURL()];
    
    NSURLSession *session = [self sessionWithDefaultConfig];
    NSURLSessionTask *sessionTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSError *jsonError = nil;
        NSDictionary *responseDictionary = nil;
        if (!error) {
//            NSLog(@"dataString: %@", [data stringValue]);
            responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            error = jsonError;
        }
        if (completion) completion(responseDictionary[@"data"], error);
    }];
    [sessionTask resume];
}

#pragma mark - Session with default config
- (NSURLSession*)sessionWithDefaultConfig {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    return [NSURLSession sessionWithConfiguration:sessionConfiguration];
}

@end
