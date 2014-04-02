//
//  DDHDataFetcher.h
//  SimpleTableView
//
//  Created by Dominik Hauser on 02.04.14.
//  Copyright (c) 2014 dasdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDHDataFetcher : NSObject

- (void)fetchGlobalWithCompletion:(void(^)(NSArray *postsArray, NSError *error))completion;

@end
