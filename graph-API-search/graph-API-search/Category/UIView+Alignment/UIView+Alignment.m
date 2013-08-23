//
//  UIView+Alignment.m
//  ZodioJai
//
//  Created by Jai Govindani on 3/5/13.
//
//

#import "UIView+Alignment.h"

@implementation UIView (Alignment)

- (void)moveUpToPoint:(CGFloat)y
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = y;
    [self setFrame:tempFrame];
}

- (void)alignRightToPoint:(CGPoint)point
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = point.x - self.frame.size.width;
    [self setFrame:tempFrame];
}

- (void)moveOriginToPoint:(CGPoint)point
{
    [self moveOriginToPoint:point animated:YES];
}

- (void)moveOriginToPoint:(CGPoint)point animated:(BOOL)animated
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = point.x;
    tempFrame.origin.y = point.y;
    
    if (animated)
    {
        [UIView animateWithDuration:0.1 animations:^{
            [self setFrame:tempFrame];
        }];
    }
    else
    {
        self.hidden = YES;
        [self setFrame:tempFrame];
        self.hidden = NO;
    }

}

- (void)moveOriginToPoint:(CGPoint)point withWidth:(CGFloat)width
{
//    CGRect tempFrame = self.frame;
//    
//    tempFrame.origin.x = point.x;
//    tempFrame.origin.y = point.y;
//    tempFrame.size.width = width;
//    
//    [self setFrame:tempFrame];
    
    [self moveOriginToPoint:point withWidth:width animated:NO];
}

- (void)moveOriginToPoint:(CGPoint)point withWidth:(CGFloat)width animated:(BOOL)animated
{
    self.hidden = YES;
    
    CGRect tempFrame = self.frame;
    
    tempFrame.origin.x = point.x;
    tempFrame.origin.y = point.y;
    tempFrame.size.width = width;
    
    [self setFrame:tempFrame];
    
    self.hidden = NO;
}

@end
