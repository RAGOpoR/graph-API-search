//
//  FacebookResultCellFactory.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/10/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "FacebookResultCellFactory.h"
#import "FacebookResultCell.h"

#define kfacebookCellHeight 50

@implementation FacebookResultCellFactory

+ (FacebookResultCell *)createfacebookCellWithCell:(FacebookResultCell *)cell feedItem:(id)currentFeedItem {
    
    
    cell.layer.borderColor = [UIColor redColor].CGColor;
    cell.layer.borderWidth = 1.0f;

    cell.contentView.layer.borderColor = [UIColor blackColor].CGColor;
    cell.contentView.layer.borderWidth = 1.0f;
    
    return cell;
}

+ (CGFloat)calculateHeightForFacebookCellWithData:(id)currentFeedItem {
    return kfacebookCellHeight;
}

@end
