//
//  ViewController.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/9/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ROObject;
@interface ViewController : ZViewController {
    ROObject *_currentObject;
    UIImageView *_imageViewIcon;
    UILabel *_messageLabel;
    UILabel *_name;
    UILabel *_createTime;
}

@property (nonatomic, strong) IBOutlet UIImageView *imageViewIcon;
@property (nonatomic, strong) IBOutlet UILabel *messageLabel;
@property (nonatomic, strong) ROObject *currentObject;
@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UILabel *createTime;
@end
