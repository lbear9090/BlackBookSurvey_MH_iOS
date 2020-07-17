//
//  MISDropdownViewController.m
//  MISDropdownViewController
//
//  Created by Michael Schneider on 4/11/15.
//  Copyright (c) 2015 mischneider. All rights reserved.
//

#import "MISDropdownViewController.h"

#define kDefaultBackgroundOverlayAlpha 0.5

@protocol MISDropdownViewControllerPresentation;

#pragma mark - MISDropdownViewController

@interface MISDropdownViewController () <UIPopoverControllerDelegate>
@property (assign, nonatomic, readwrite) MISDropdownViewControllerPresentationMode dropdownPresentationMode;
@property (assign, nonatomic, readwrite, getter=isDropdownVisible) BOOL dropdownVisible;
@property (strong, nonatomic, readwrite) id<MISDropdownViewControllerPresentation> dropdownPresentation;
@property (assign, nonatomic, readwrite) MISDropdownViewControllerPosition dropdownPosition;

- (void)backgroundOverlayTapped:(id)sender;
- (void)informDelegateAboutDismiss;
@end


#pragma mark - MISDropdownViewControllerPresentation

@protocol MISDropdownViewControllerPresentation <NSObject>
- (instancetype)initWithDropdownViewController:(MISDropdownViewController *)dropdownViewController;
- (void)presentDropdownFromRect:(CGRect)rect inViewController:(UIViewController *)viewController position:(MISDropdownViewControllerPosition)position;
- (void)dismissDropdownAnimated:(BOOL)animated;
- (void)handleRotation;
@end


#pragma mark - MISDropdownViewControllerPresentationPopover

@interface MISDropdownViewControllerPresentationPopover : NSObject <MISDropdownViewControllerPresentation>
@property (weak, nonatomic) MISDropdownViewController *dropdownViewController;
@property (strong, nonatomic) UIPopoverController *dropdownPopoverController;
@end

@implementation MISDropdownViewControllerPresentationPopover


#pragma mark - Lifecycle

- (instancetype)initWithDropdownViewController:(MISDropdownViewController *)dropdownViewController
{
    self = [super init];
    if (self == nil) { return self; }
    _dropdownViewController = dropdownViewController;
    return self;
}


#pragma mark - API

- (void)presentDropdownFromRect:(CGRect)rect inViewController:(UIViewController *)viewController position:(MISDropdownViewControllerPosition)position
{
    MISDropdownViewController *dropdownViewController = self.dropdownViewController;
    
    dropdownViewController.preferredContentSize = dropdownViewController.contentView.bounds.size;
    dropdownViewController.view.frame = dropdownViewController.contentView.bounds;
    [dropdownViewController.view addSubview:dropdownViewController.contentView];
    
    UIPopoverController *dropdownPopoverController = [[UIPopoverController alloc] initWithContentViewController:dropdownViewController];
    dropdownPopoverController.delegate = (id<UIPopoverControllerDelegate>)self.dropdownViewController;
    dropdownPopoverController.backgroundColor = dropdownViewController.contentView.backgroundColor;
    self.dropdownPopoverController = dropdownPopoverController;
    
    [dropdownPopoverController presentPopoverFromRect:rect inView:viewController.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)dismissDropdownAnimated:(BOOL)animated
{
    [self.dropdownPopoverController dismissPopoverAnimated:animated];
}

- (void)handleRotation { }

@end


#pragma mark - MISDropdownViewControllerPresentationOverflow

@interface MISDropdownViewControllerPresentationOverflow : NSObject <MISDropdownViewControllerPresentation>
@property (nonatomic, weak) MISDropdownViewController *dropdownViewController;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIButton *backgroundOverlay;
@end

@implementation MISDropdownViewControllerPresentationOverflow


#pragma mark - Lifecycle

- (instancetype)initWithDropdownViewController:(MISDropdownViewController *)dropdownViewController
{
    self = [super init];
    if (self == nil) { return self; }
    _dropdownViewController = dropdownViewController;
    return self;
}


#pragma mark - Setter / Getter

- (UIView *)containerView
{
    if (_containerView == nil) {
        _containerView = [UIView new];
        _containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _containerView;
}

- (UIButton *)backgroundOverlay
{
    if (_backgroundOverlay == nil) {
        _backgroundOverlay = [UIButton buttonWithType:UIButtonTypeCustom];
        _backgroundOverlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backgroundOverlay.backgroundColor = [UIColor blackColor];
        _backgroundOverlay.alpha = 0.0;
        [_backgroundOverlay addTarget:self.dropdownViewController action:@selector(backgroundOverlayTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _backgroundOverlay;
}

- (CGFloat)contentViewHeight
{
    return MIN(CGRectGetHeight(self.dropdownViewController.contentView.bounds),
               CGRectGetHeight(self.dropdownViewController.view.bounds));
}


#pragma mark - API

- (void)presentDropdownFromRect:(CGRect)rect inViewController:(UIViewController *)viewController position:(MISDropdownViewControllerPosition)position
{
    [self.containerView.layer removeAllAnimations];
    [self setupContainerView];

    [self addContainerViewControllerToViewController:viewController];
    
    [UIView animateWithDuration:0.4
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:4.0
                        options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         CGRect containerViewFrame = self.containerView.frame;
                         containerViewFrame.origin.y = self.visibleContainerViewYPosition;
                         self.containerView.frame = containerViewFrame;
                         
                         self.backgroundOverlay.alpha = kDefaultBackgroundOverlayAlpha;
                     }
                     completion:nil];
}

- (void)dismissDropdownAnimated:(BOOL)animated
{
    [UIView animateWithDuration:0.3f
                          delay:0.05f
         usingSpringWithDamping:1.0
          initialSpringVelocity:4.0
                        options: UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         CGRect r = self.containerView.frame;
                         r.origin.y = self.hiddenContainerViewYPosition;
                         self.containerView.frame = r;
                         
                         self.backgroundOverlay.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         if (!finished) { return; }

                         [self removeContainerView];
                         [self removeContainerViewControllerFromParentController];
                         
                         [self.dropdownViewController informDelegateAboutDismiss];
                     }];
}

- (void)handleRotation
{
    CGRect containerViewFrame = self.containerView.frame;
    containerViewFrame.origin.y = self.visibleContainerViewYPosition;
    self.containerView.frame = containerViewFrame;
}


#pragma mark - Setup

- (void)addContainerViewControllerToViewController:(UIViewController *)viewController
{
    if (self.dropdownViewController.parentViewController != nil) { return; }
    
    self.dropdownViewController.view.frame = viewController.view.bounds;
    [viewController addChildViewController:self.dropdownViewController];
    [viewController.view addSubview:self.dropdownViewController.view];
    [self.dropdownViewController didMoveToParentViewController:viewController];
}

- (void)removeContainerViewControllerFromParentController
{
    [self.dropdownViewController willMoveToParentViewController:nil];
    [self.dropdownViewController.view removeFromSuperview];
    [self.dropdownViewController removeFromParentViewController];
}

- (void)setupContainerView
{
    if (self.containerView.superview != nil) { return; }
    
    UIView *dropdownView = self.dropdownViewController.view;
    UIView *contentView = self.dropdownViewController.contentView;
    
    // Background Overlay
    self.backgroundOverlay.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(dropdownView.frame), CGRectGetHeight(dropdownView.frame));
    [dropdownView addSubview:self.backgroundOverlay];
    
    // Content View
    contentView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.containerView.frame), CGRectGetHeight(contentView.bounds));
    [self.containerView addSubview:contentView];
    
    // Container View
    CGFloat containerViewY = -self.contentViewHeight;
    if (self.dropdownViewController.dropdownPosition == MISDropdownViewControllerPositionBottom) {
        containerViewY = CGRectGetMaxY(dropdownView.frame);
    }
    self.containerView.frame = CGRectMake(0.0, containerViewY, CGRectGetWidth(dropdownView.bounds), self.contentViewHeight);

    [dropdownView addSubview:self.containerView];
}

- (void)removeContainerView
{
    [self.dropdownViewController.contentView removeFromSuperview];
    [self.containerView removeFromSuperview];
    [self.backgroundOverlay removeFromSuperview];
}


#pragma mark - Helper

- (CGFloat)visibleContainerViewYPosition
{
    CGFloat containerViewY = self.fullNavigationBarHeight;
    if (self.dropdownViewController.dropdownPosition == MISDropdownViewControllerPositionBottom) {
        containerViewY = CGRectGetMaxY(self.dropdownViewController.view.frame) - self.contentViewHeight - self.tabBarHeight;
    }
    return containerViewY;
}

- (CGFloat)hiddenContainerViewYPosition
{
    CGFloat containerViewY = -self.contentViewHeight;
    if (self.dropdownViewController.dropdownPosition == MISDropdownViewControllerPositionBottom) {
        containerViewY = CGRectGetMaxY(self.dropdownViewController.view.frame);
    }
    return containerViewY;
}

- (CGFloat)fullNavigationBarHeight
{
    CGFloat fullNavigationBarHeight = 0;
    if (self.dropdownViewController.navigationController.navigationBar.isTranslucent) {
        UIInterfaceOrientation orientation = UIApplication.sharedApplication.statusBarOrientation;
        CGFloat navigationBarHeight = self.dropdownViewController.navigationController.navigationBar.frame.size.height;
        CGRect statusBarFrame = UIApplication.sharedApplication.statusBarFrame;
        CGFloat statusBarHeight = statusBarFrame.size.height;

        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
            statusBarHeight = UIInterfaceOrientationIsLandscape(orientation) ? statusBarFrame.size.width : statusBarFrame.size.height;
        }
        fullNavigationBarHeight = statusBarHeight + navigationBarHeight;
    }
    return fullNavigationBarHeight;
}

- (CGFloat)tabBarHeight
{
    CGFloat tabBarHeight = 0.0;
    UITabBarController *tabBarController = self.dropdownViewController.tabBarController;
    if (tabBarController != nil && ![tabBarController.tabBar isHidden]) {
        tabBarHeight = tabBarController.tabBar.frame.size.height;
    }
    return tabBarHeight;
}


@end


#pragma mark - MISDropdownViewController

@implementation MISDropdownViewController

#pragma mark - Lifecycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithPresentationMode:MISDropdownViewControllerPresentationModeAutomatic];
}

- (instancetype)initWithPresentationMode:(MISDropdownViewControllerPresentationMode)presentationMode
{
    return [self initWithContentView:nil presentationMode:presentationMode];
}

- (instancetype)initWithContentView:(UIView *)contentView presentationMode:(MISDropdownViewControllerPresentationMode)presentationMode
{
    self = [super initWithNibName:nil bundle:nil];
    if (self == nil) { return self; }
    
    _contentView = contentView;
    _dropdownPresentationMode = presentationMode;
    [self initViewController];
    
    return self;
}

- (void)initViewController
{
    _dropdownVisible = NO;
    
    BOOL isPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
    id<MISDropdownViewControllerPresentation> presentation;
    if ((isPad && _dropdownPresentationMode == MISDropdownViewControllerPresentationModeAutomatic) ||
        _dropdownPresentationMode == MISDropdownViewControllerPresentationModePopover) {
        presentation = [[MISDropdownViewControllerPresentationPopover alloc] initWithDropdownViewController:self];
    }
    else {
        presentation = [[MISDropdownViewControllerPresentationOverflow alloc] initWithDropdownViewController:self];
    }
    _dropdownPresentation = presentation;
}


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}


#pragma mark - API

- (void)presentDropdownFromBarButtonItem:(UIBarButtonItem *)item inViewController:(UIViewController *)viewController position:(MISDropdownViewControllerPosition)position
{
    UIView *view = [item valueForKey:@"view"];
    CGRect rect = [view convertRect:view.bounds toView:viewController.view];
    [self presentDropdownFromRect:rect inViewController:viewController position:position];
}

- (void)presentDropdownFromRect:(CGRect)rect inViewController:(UIViewController *)viewController position:(MISDropdownViewControllerPosition)position
{
    if (self.dropdownVisible) { return; }

    self.dropdownPosition = position;
    self.dropdownVisible = YES;
    
    [self.dropdownPresentation presentDropdownFromRect:rect inViewController:viewController position:position];
}

- (void)dismissDropdownAnimated:(BOOL)animated
{
    if (!self.dropdownVisible) { return; }
    
    [self.dropdownPresentation dismissDropdownAnimated:animated];
    
    self.dropdownPosition = MISDropdownViewControllerPositionUnknown;
    self.dropdownVisible = NO;
}


#pragma mark - Actions

- (void)backgroundOverlayTapped:(id)sender
{
    [self dismissDropdownAnimated:YES];
}


#pragma mark - Delegate Helper

- (void)informDelegateAboutDismiss
{
    if ([self.delegate respondsToSelector:@selector(dropdownControllerDidDismissDropdown:)]) {
        [self.delegate dropdownControllerDidDismissDropdown:self];
    }
}


#pragma mark - UIPopoverDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.dropdownVisible = NO;

    [self informDelegateAboutDismiss];
}


#pragma mark - Rotation

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self.dropdownPresentation handleRotation];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
    }];
    
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.dropdownPresentation handleRotation];
}

@end
