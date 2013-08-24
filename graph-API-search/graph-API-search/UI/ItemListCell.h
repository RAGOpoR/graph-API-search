//
//  ItemListCell.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 8/23/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemListCell : UITableViewCell {
    UIImageView *_imageViewIcon;
    UILabel *_messageLabel;
    UILabel *_name;
    UILabel *_createTime;
}

@property (nonatomic, strong) IBOutlet UIImageView *imageViewIcon;
@property (nonatomic, strong) IBOutlet UILabel *messageLabel;
@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UILabel *createTime;

@end
