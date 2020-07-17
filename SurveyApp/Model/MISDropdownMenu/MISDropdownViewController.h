//
//  MISDropdownViewController.h
//  MISDropdownViewController
//
//  Created by Michael Schneider on 4/11/15.
//  Copyright (c) 2015 mischneider. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MISDropdownViewControllerPresentationModeAutomatic,
    MISDropdownViewControllerPresentationModeOverflow,
    MISDropdownViewControllerPresentationModePopover
} MISDropdownViewControllerPresentationMode;

typedef enum : NSUInteger {
    MISDropdownViewControllerPositionUnknown,
    MISDropdownViewControllerPositionTop,
    MISDropdownViewControllerPositionBottom,
} MISDropdownViewControllerPosition;

@protocol MISDropdownViewControllerDelegate;

@interface MISDropdownViewController : UIViewController

@property (strong, nonatomic) UIView *contentView;
@property (assign, nonatomic, readonly) MISDropdownViewControllerPresentationMode dropdownPresentationMode;
@property (assign, nonatomic, readonly) MISDropdownViewControllerPosition dropdownPosition;
@property (assign, nonatomic, readonly, getter=isDropdownVisible) BOOL dropdownVisible;

@property (weak, nonatomic) id<MISDropdownViewControllerDelegate> delegate;

- (instancetype)initWithContentView:(UIView *)contentView presentationMode:(MISDropdownViewControllerPresentationMode)presentationMode NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithPresentationMode:(MISDropdownViewControllerPresentationMode)presentationMode;

- (void)presentDropdownFromBarButtonItem:(UIBarButtonItem *)item inViewController:(UIViewController *)viewController position:(MISDropdownViewControllerPosition)position;
- (void)presentDropdownFromRect:(CGRect)rect inViewController:(UIViewController *)viewController position:(MISDropdownViewControllerPosition)position;

- (void)dismissDropdownAnimated:(BOOL)animated;

@end

@protocol MISDropdownViewControllerDelegate <NSObject>
- (void)dropdownControllerDidDismissDropdown:(MISDropdownViewController *)controller;
@end
