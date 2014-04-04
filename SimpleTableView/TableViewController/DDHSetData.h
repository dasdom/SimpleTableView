//
//  DDHSetData.h
//  SimpleTableView
//
//  Created by dasdom on 02.04.14.
//  Copyright (c) 2014 dasdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DDHSetData <NSObject>
@required
  - (void)setData:(NSArray*)array;
@end
