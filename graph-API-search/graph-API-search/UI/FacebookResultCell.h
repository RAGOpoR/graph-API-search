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
    UILabel *_name;
    UILabel *_createTime;
}

@property (nonatomic, strong) UIImageView *imageViewIcon;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *createTime;


@end
