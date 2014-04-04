//
//  DDHTableViewDataSource.m
//  SimpleTableView
//
//  Created by dasdom on 02.04.14.
//  Copyright (c) 2014 dasdom. All rights reserved.
//

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
