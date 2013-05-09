//
//  FacebookResultCell.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/10/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "FacebookResultCell.h"

@implementation FacebookResultCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.imageViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 90, 90)];
        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 90)];
        self.messageLabel.font = [UIFont boldSystemFontOfSize:12];
        self.messageLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        self.messageLabel.backgroundColor = [UIColor clearColor];
        self.messageLabel.numberOfLines = 0;
        
        [self addSubview:self.imageViewIcon];
        [self addSubview:self.messageLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
