//
//  UIView+Alignment.h
//  ZodioJai
//
//  Created by Jai Govindani on 3/5/13.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Alignment)

- (void)moveUpToPoint:(CGFloat)y;
- (void)alignRightToPoint:(CGPoint)point;

/*!
 @abstract Moves the view's origin - default is animated. To control animation use moveOriginToPoint:animated: instead
 @param point New origin to set
 */
- (void)moveOriginToPoint:(CGPoint)point;

/*!
 @abstract Moves the view's origin to the given point
 @param point New origin for the view
 @param animated Whether to animate the move or not
 */
- (void)moveOriginToPoint:(CGPoint)point animated:(BOOL)animated;

- (void)moveOriginToPoint:(CGPoint)point withWidth:(CGFloat)width;

@end
