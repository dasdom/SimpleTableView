//
//  DDHWebViewController.m
//  SimpleTableView
//
//  Created by dasdom on 02.04.14.
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
