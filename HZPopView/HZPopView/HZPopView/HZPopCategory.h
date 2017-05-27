//
//  HZPopViewController+Extension.h
//  HZPopView
//
//  Created by zz go on 2017/5/26.
//  Copyright © 2017年 zzgo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
- (void)interruptGesture;
@end

@interface UIViewController (Extension)
- (UIViewController *)hz_viewControllerForStatusBarStyle;
+ (UIViewController *)hz_currentViewController;
+ (UIViewController *)findBestViewController:(UIViewController *)vc;
@end


@interface UIWindow (Extension)
- (UIViewController *)hz_currentViewController;
- (UIViewController *)hz_viewControllerForStatusBarStyle;
- (UIViewController *)hz_viewControllerForStatusBarHidden;
@end
