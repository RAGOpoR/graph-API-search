//
//  UIColor+DFTheme.m
//  dealfish
//
//  Created by Jirat K. on 7/1/56 BE.
//  Copyright (c) 2556 3DS INTERACTIVE CO., LTD. All rights reserved.
//

#import "UIColor+DFTheme.h"

@implementation UIColor (DFTheme)


+ (UIColor *)backgroundColor
{
    return [UIColor colorWithWhite:0.93f alpha:1.0f];
}

+ (UIColor *)navigationBackgroundColor
{
    return [UIColor colorWithHue:201.0f/359.0f saturation:0.97f brightness:0.72f alpha:1.0f];
}

@end
