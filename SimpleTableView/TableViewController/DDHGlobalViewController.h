//
//  DDHGlobalViewController.h
//  SimpleTableView
//
//  Created by Dominik Hauser on 02.04.14.
//  Copyright (c) 2014 dasdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDHSetData.h"

@interface DDHGlobalViewController : UIViewController
@property (nonatomic, strong) id <DDHSetData, UITableViewDataSource, UITableViewDelegate>tableViewDataSource;
@end
