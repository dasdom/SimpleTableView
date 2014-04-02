//
//  DDHTableViewController.m
//  SimpleTableView
//
//  Created by Dominik Hauser on 02.04.14.
//  Copyright (c) 2014 dasdom. All rights reserved.
//

#import "DDHTableViewController.h"
#import "DDHDataFetcher.h"

@interface DDHTableViewController ()

@end

@implementation DDHTableViewController

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSLog(@"%s, %d", __func__, __LINE__);
    self.view.backgroundColor = [UIColor yellowColor];
    NSLog(@"%s, %d", __func__, __LINE__);
    
    return self;
}

- (void)loadView {
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(openSafari:)];
    self.navigationItem.rightBarButtonItem = barButton;

    CGRect contentViewFrame = [[UIScreen mainScreen] applicationFrame];
    UIView *contentView = [[UIView alloc] initWithFrame: contentViewFrame];
    
    self.view = contentView;
    
    NSLog(@"%s, %d", __func__, __LINE__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%s, %d", __func__, __LINE__);
    
    DDHDataFetcher *dataFetcher = [[DDHDataFetcher alloc] init];
    [dataFetcher fetchGlobalWithCompletion:^(NSArray *postsArray, NSError *error) {
        NSLog(@"postsArray: %@", postsArray);
    }];
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
