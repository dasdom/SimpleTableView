//
//  DDHWebViewController.m
//  SimpleTableView
//
//  Created by dasdom on 02.04.14.
//  Copyright (c) 2014 dasdom. All rights reserved.
//

#import "DDHWebViewController.h"

@interface DDHWebViewController ()
@property (nonatomic, strong) UIWebView *webview;
@end

@implementation DDHWebViewController

- (void)loadView {
    self.webview = ({
        UIWebView *webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        webView;
    });
    
    self.view = self.webview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://dasdev.de"]]];
}

@end
