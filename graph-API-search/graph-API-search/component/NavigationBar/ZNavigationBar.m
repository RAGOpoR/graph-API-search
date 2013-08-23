//
//  ZNavigationBar.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 8/24/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "ZNavigationBar.h"
#import "UIColor+DFTheme.h"

@implementation ZNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //    UIImage* bg = [UIImage imageNamed:@"nav-bg"];
    //    [bg drawInRect: rect];
    if (self.translucent) {
        //        self.backgroundColor = [UIColor clearColor];
        UIColor *navColor = [[UIColor navigationBackgroundColor] colorWithAlphaComponent:0.96];
        CGContextRef ct = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(ct, navColor.CGColor);
        CGContextFillRect(ct, rect);
        
    }else{
        UIColor *navColor = [UIColor navigationBackgroundColor];
        CGContextRef ct = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(ct, navColor.CGColor);
        CGContextFillRect(ct, rect);
    }
}

@end
