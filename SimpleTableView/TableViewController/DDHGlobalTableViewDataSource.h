//
//  DDHTableViewDataSource.h
//  SimpleTableView
//
//  Created by dasdom on 02.04.14.
//  Copyright (c) 2014 dasdom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDHSetData.h"

@interface DDHGlobalTableViewDataSource : NSObject <DDHSetData, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *postsArray;
@end
