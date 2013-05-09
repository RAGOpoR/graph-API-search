//
//  ViewController.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/9/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ROObject;
@interface ViewController : UIViewController {
    ROObject *_currentObject;
    UIImageView *_imageViewIcon;
    UILabel *_messageLabel;
}

@property (nonatomic, strong) UIImageView *imageViewIcon;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) ROObject *currentObject;

@end
