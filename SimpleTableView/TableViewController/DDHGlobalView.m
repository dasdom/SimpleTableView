//
//  DDHGlobalView.m
//  SimpleTableView
//
//  Created by dasdom on 02.04.14.
//  Copyright (c) 2014 dasdom. All rights reserved.
//

#import "DDHGlobalView.h"

@implementation DDHGlobalView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.tableView];
    
    self.reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reloadButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.reloadButton setTitle:@"Load more posts" forState:UIControlStateNormal];
    [self.reloadButton setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    self.reloadButton.backgroundColor = [UIColor redColor];
    [self addSubview:self.reloadButton];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_tableView, _reloadButton);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_tableView]|" options:kNilOptions metrics:nil views:viewsDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView][_reloadButton]|" options:kNilOptions metrics:nil views:viewsDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_reloadButton]|" options:kNilOptions metrics:nil views:viewsDictionary]];


    return self;
}

@end
