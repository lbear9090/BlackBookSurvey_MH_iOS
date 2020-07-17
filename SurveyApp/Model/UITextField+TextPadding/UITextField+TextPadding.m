//
//  UITextField+TextPadding.m
//  TechBuddy
//
//  Created by C111 on 03/11/15.
//  Copyright © 2015 C111. All rights reserved.
//

#import "UITextField+TextPadding.h"

@implementation UITextField (TextPadding)

@dynamic leftPadding, rightPadding;

- (void)setLeftPadding:(CGFloat)leftPadding
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, leftPadding, self.frame.size.height)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setRightPadding:(CGFloat)rightPadding
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, rightPadding, self.frame.size.height)];
    self.rightView = paddingView;
    self.rightViewMode = UITextFieldViewModeAlways;
}

@end