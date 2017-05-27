//
//  HZPopViewController.m
//  HZPopView
//
//  Created by zz go on 2017/5/25.
//  Copyright © 2017年 zzgo. All rights reserved.
//

#import "HZPopViewController.h"
#import "HZPopCategory.h"
#import "HZPopBackground.h"

@implementation HZPopViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.popBackground];
    
//    [self.view addSubview:self.popView];
    
//    self.popView.frame = self.view.bounds;
    self.popBackground.frame= self.view.bounds;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
//    self.popView.frame = self.view.bounds;
    self.popBackground.frame= self.view.bounds;
}


#pragma mark - StatusBar
- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIWindow *window = self.popView.previousKeyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows firstObject];
    }
    return [[window hz_viewControllerForStatusBarStyle] preferredStatusBarStyle];
}

- (BOOL)prefersStatusBarHidden
{
    UIWindow *window = self.popView.previousKeyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows firstObject];
    }
    return [[window hz_viewControllerForStatusBarHidden] prefersStatusBarHidden];
}


#pragma mark - 屏幕旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.popView.supportedInterfaceOrientations;
}

//旋转执行完毕
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //    if (self.actionSheet.blurEffectEnabled && !kiOS8Later) {
    //        [self.actionSheet setupStyle];
    //    }
}
@end

