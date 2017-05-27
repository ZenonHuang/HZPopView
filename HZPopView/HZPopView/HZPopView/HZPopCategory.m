//
//  HZPopViewController+Extension.m
//  HZPopView
//
//  Created by zz go on 2017/5/26.
//  Copyright © 2017年 zzgo. All rights reserved.
//

#import "HZPopCategory.h"

#pragma mark - UIView 

@implementation UIView (Extension)

- (void)interruptGesture
{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        if (([gesture isKindOfClass:[UITapGestureRecognizer class]] || [gesture isKindOfClass:[UIPanGestureRecognizer class]]) && gesture.enabled == YES) {
//            gesture.enabled = NO;
            //默认打开手势
            gesture.enabled = YES;
        }
    }
    for (UIView *subview in self.subviews) {
        [subview interruptGesture];
    }
}

@end

#pragma mark - UIViewController

@implementation UIViewController (Extension)

- (UIViewController *)hz_viewControllerForStatusBarStyle
{
    UIViewController *currentViewController = [UIViewController hz_currentViewController];
    
    while ([currentViewController childViewControllerForStatusBarStyle]) {
        currentViewController = [currentViewController childViewControllerForStatusBarStyle];
    }
    
    return currentViewController;
}

//- (UIViewController *)currentViewController
//{
//    UIViewController *viewController = window.rootViewController;
//    while (viewController.presentedViewController) {
//        viewController = viewController.presentedViewController;
//    }
//    return viewController;
//}

+ (UIViewController *)hz_currentViewController
{
    // Find best view controller
    UIViewController *viewController =
    [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
}

+ (UIViewController *)findBestViewController:(UIViewController *)vc
{
    if (vc.presentedViewController) {
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
    }
    else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *)vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    }
    else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController *)vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
    }
    else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController *)vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
    }
    else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}
@end

#pragma mark - UIWindow

@implementation UIWindow (Extension)

- (UIViewController *)hz_currentViewController
{
    // Find best view controller
    UIViewController *viewController =self.rootViewController;
    return [UIViewController findBestViewController:viewController];
}

- (UIViewController *)hz_viewControllerForStatusBarStyle
{
    UIViewController *currentViewController = [self hz_currentViewController];
    
    while ([currentViewController childViewControllerForStatusBarStyle]) {
        currentViewController = [currentViewController childViewControllerForStatusBarStyle];
    }
    
    return currentViewController;
}

- (UIViewController *)hz_viewControllerForStatusBarHidden
{
    UIViewController *currentViewController = [self hz_currentViewController];
    
    while ([currentViewController childViewControllerForStatusBarHidden]) {
        currentViewController = [currentViewController childViewControllerForStatusBarHidden];
    }
    
    return currentViewController;
}

@end
