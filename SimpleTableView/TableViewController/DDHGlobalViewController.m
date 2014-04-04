//
//  DDHGlobalViewController.m
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

#import "DDHGlobalViewController.h"
#import "DDHDataFetcher.h"
#import "DDHGlobalView.h"

@interface DDHGlobalViewController ()
@property (nonatomic, strong) DDHGlobalView *globalView;
@end

@implementation DDHGlobalViewController

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
//    NSLog(@"%s, %d", __func__, __LINE__);
//    self.view.backgroundColor = [UIColor yellowColor];
//    NSLog(@"%s, %d", __func__, __LINE__);
    
    return self;
}

- (void)loadView {
    CGRect contentViewFrame = [[UIScreen mainScreen] applicationFrame];
    self.globalView = [[DDHGlobalView alloc] initWithFrame:contentViewFrame];
    
    self.view = self.globalView;
    
    NSLog(@"%s, %d", __func__, __LINE__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%s, %d", __func__, __LINE__);
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(openSafari:)];
    self.navigationItem.rightBarButtonItem = barButton;
    
    [self.globalView.reloadButton addTarget:self action:@selector(loadGlobalPosts) forControlEvents:UIControlEventTouchUpInside];
    
    NSAssert(self.tableViewDataSource, @"The tableViewDataSource has to be set at this point.");
    self.globalView.tableView.dataSource = self.tableViewDataSource;
    self.globalView.tableView.delegate = self.tableViewDataSource;

    [self loadGlobalPosts];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%s, %d", __func__, __LINE__);
}

- (void)viewWillLayoutSubviews {
    NSLog(@"%s, %d", __func__, __LINE__);
}

- (void)viewDidLayoutSubviews {
    NSLog(@"%s, %d", __func__, __LINE__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSLog(@"%s, %d", __func__, __LINE__);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"%s, %d", __func__, __LINE__);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"%s, %d", __func__, __LINE__);
}

- (void)openSafari:(UIBarButtonItem*)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://dasdev.de"]];
}

#pragma mark -
- (void)loadGlobalPosts {
    DDHDataFetcher *dataFetcher = [[DDHDataFetcher alloc] init];
    [dataFetcher fetchGlobalWithCompletion:^(NSArray *postsArray, NSError *error) {
        NSLog(@"postsArray: %@", postsArray);
        if ([postsArray count] > 0) {
            [self.tableViewDataSource setData:postsArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.globalView.tableView reloadData];
                [self.globalView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            });
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
