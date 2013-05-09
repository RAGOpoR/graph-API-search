//
//  FacebookResultCell.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/10/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacebookResultCell : UITableViewCell {
    UIImageView *_imageViewIcon;
    UILabel *_messageLabel;
}

@property (nonatomic, strong) UIImageView *imageViewIcon;
@property (nonatomic, strong) UILabel *messageLabel;

@end
