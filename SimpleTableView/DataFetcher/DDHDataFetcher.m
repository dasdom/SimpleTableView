//
//  DDHDataFetcher.m
//  SimpleTableView
//
//  Created by Dominik Hauser on 02.04.14.
//  Copyright (c) 2014 dasdom. All rights reserved.
//

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
