//
//  UIView+RunTimeAttributes.m
//  TechBuddy
//
//  Created by C111 on 08/10/15.
//  Copyright © 2015 C111. All rights reserved.
//

#import "UIView+RunTimeAttributes.h"

@implementation UIView (RunTimeAttributes)

@dynamic borderColor, borderWidth, cornerRadius, masksToBounds;

- (void)setBorderColor:(UIColor *)borderColor
{
    [self.layer setBorderColor:borderColor.CGColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    [self.layer setBorderWidth:borderWidth];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    [self.layer setCornerRadius:cornerRadius];
}

- (void)setMasksToBounds:(BOOL)masksToBounds
{
    [self.layer setMasksToBounds:masksToBounds];
}

@end