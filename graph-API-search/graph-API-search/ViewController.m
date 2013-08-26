//
//  ViewController.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/9/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "ViewController.h"
#import "ROObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
//        self.imageViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 90, 90)];
//        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, 290, 325)];
//        self.messageLabel.font = [UIFont boldSystemFontOfSize:12];
//        self.messageLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//        self.messageLabel.backgroundColor = [UIColor clearColor];
//        self.messageLabel.numberOfLines = 0;
//        self.name.text = self.currentObject.objectName;
        
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.imageViewIcon setImageWithURL:self.currentObject.iconURL
                       placeholderImage:nil];
    [self.messageLabel setText:self.currentObject.message];
    [self.name setText:self.currentObject.objectName];
    [self.createTime setText:self.currentObject.createDate];
    [self setupNextButtonWithImageName:@"reject.png" andHilightedImageName:nil withImageWidth:36 andImageHeight:32];
    
//    self.view.layer.borderColor = [UIColor redColor].CGColor;
//    self.view.layer.borderWidth = 1.0f;
//
//    self.imageViewIcon.layer.borderColor = [UIColor blackColor].CGColor;
//    self.imageViewIcon.layer.borderWidth = 1.0f;
//    self.messageLabel.layer.borderColor = [UIColor blackColor].CGColor;
//    self.messageLabel.layer.borderWidth = 1.0f;
    
//    [self.view addSubview:self.imageViewIcon];
//    [self.view addSubview:self.messageLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
