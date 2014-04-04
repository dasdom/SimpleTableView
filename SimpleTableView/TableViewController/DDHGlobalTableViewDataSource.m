//
//  DDHTableViewDataSource.m
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

#import "DDHGlobalTableViewDataSource.h"

@implementation DDHGlobalTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.postsArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    }
    
    cell.textLabel.text = self.postsArray[indexPath.row][@"text"];

    dispatch_queue_t avatarDownloaderQueue = dispatch_queue_create("de.dasdom.avatarDownloader", NULL);
    dispatch_async(avatarDownloaderQueue, ^{
        NSString *avatarUrlString = self.postsArray[indexPath.row][@"user"][@"avatar_image"][@"url"];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:avatarUrlString]]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            UITableViewCell *asyncCell = [tableView cellForRowAtIndexPath:indexPath];
            asyncCell.imageView.image = image;
        });
    });
    return cell;
}

#pragma mark - DDHSetData
- (void)setData:(NSArray *)array {
    self.postsArray = array;
}

@end
