//
//  UIView+RunTimeAttributes.h
//  TechBuddy
//
//  Created by C111 on 08/10/15.
//  Copyright © 2015 C111. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RunTimeAttributes)

@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable BOOL masksToBounds;

@end