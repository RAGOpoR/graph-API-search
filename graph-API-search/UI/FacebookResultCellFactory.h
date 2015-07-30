//
//  FacebookResultCellFactory.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/10/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "UIFactory.h"

@class FacebookResultCell;
@class ROObject;
@interface FacebookResultCellFactory : UIFactory

+ (FacebookResultCell *)createfacebookCellWithCell:(FacebookResultCell *)cell feedItem:(ROObject*)currentFeedItem;
+ (CGFloat)calculateHeightForFacebookCellWithData:(ROObject*)currentFeedItem;

@end
