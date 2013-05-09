//
//  FacebookResultCellFactory.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/10/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "UIFactory.h"

@class FacebookResultCell;
@interface FacebookResultCellFactory : UIFactory

+ (FacebookResultCell *)createfacebookCellWithCell:(FacebookResultCell *)cell feedItem:(id)currentFeedItem;
+ (CGFloat)calculateHeightForFacebookCellWithData:(id)currentFeedItem;

@end
