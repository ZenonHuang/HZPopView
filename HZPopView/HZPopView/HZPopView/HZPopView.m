//
//  HZPopView.m
//  HZPopView
//
//  Created by zz go on 2017/5/25.
//  Copyright © 2017年 zzgo. All rights reserved.
//

#import "HZPopView.h"
#import "HZMacro.h"
#import "HZPopBackground.h"
#import "HZPopCategory.h"
#import "HZPopViewController.h"


@interface HZPopView ()
@property (weak, nonatomic, readwrite) UIWindow *previousKeyWindow;
@property (nonatomic,nonnull,strong) HZPopBackground * background;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,readwrite,getter=isVisible) BOOL visible;
@end


@implementation HZPopView

#pragma mark - init 
// +initialize 和 -init 方法区别
+ (void)initialize
{
    if (self != [HZPopView class]) {
        return;
    }
    HZPopView *appearance = [self appearance];
    //    appearance.buttonHeight = 56;
    //    appearance.offsetY = - bigFragment;
    appearance.tintColor = [UIColor blackColor];
    //    appearance.destructiveButtonColor = [UIColor redColor];
    //    appearance.cancelButtonColor = [UIColor blackColor];
    //    appearance.sheetWidth = MIN(kScreenWidth, kScreenHeight) - 20;
    //    appearance.backgroundTransparentEnabled = YES;
    appearance.backgroundTouchClosureEnabled = YES;
    //    appearance.blurEffectEnabled = YES;
    //    appearance.rectCornerRadius = 10;
    //    appearance.ambientColor = [UIColor colorWithWhite:1 alpha:0.65];
    //    appearance.separatorColor = [UIColor clearColor];
    //    appearance.animationDuration = 0.2;
    //    appearance.animationDampingRatio = 1;
    //    appearance.animationVelocity = 1;
    appearance.supportedInterfaceOrientations = UIInterfaceOrientationMaskAll;
}

-(instancetype)initWithFrame:(CGRect)frame{
    //    self=[super initWithFrame:[UIScreen mainScreen].bounds];
    self=[super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.backgroundColor = [UIColor orangeColor];
    
    //window
    self.previousKeyWindow = [UIApplication sharedApplication].keyWindow;
    
    //background
    self.background=[[HZPopBackground alloc] init];
    [self.background addSubview:self];
    
    
    //type
    self.type=HZPopTypeAlert;
    
    
    
    //监听方向改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(statusBarDidChangeOrientation:) 
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification 
                                               object:nil];
    return self;
}

#pragma mark - public
-(void)show{
    [self setupNewWindow];
    
    [self setupLayout];
    
    //弹出 HZPopView 动画
    //    void(^animations)(void) = ^() {
    //        self.background.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    //    };
    //    void(^completion)(BOOL finished) = ^(BOOL finished) {
    //        
    //        self.visible = YES;
    //    };
    //    
    //    [UIView animateWithDuration:0.5
    //                          delay:0 
    //         usingSpringWithDamping:1
    //          initialSpringVelocity:1
    //                        options:UIViewAnimationOptionCurveEaseInOut
    //                     animations:animations 
    //                     completion:completion];
    
    self.showAnimation(self);
    
}


#pragma mark - private



#pragma mark show action
/**
 *  设定新的 UIWindow，并将 HZPopView 附加在上面
 */
- (void)setupNewWindow
{
    if ([self isVisible]) {
        return;
    }
    
    self.previousKeyWindow = [UIApplication sharedApplication].keyWindow;
    [self.previousKeyWindow interruptGesture];
    
    //设置 控制器 和popview
    HZPopViewController *popVC = [HZPopViewController new];
    popVC.popView = self;
    popVC.popBackground = self.background;
    
    //设置window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    self.window.rootViewController = popVC;
    [self.window makeKeyAndVisible];    
}

/**
 *  设定所有内容的布局
 */
- (void)setupLayout
{
    // 设定是否触碰背景关闭
    self.background.userInteractionEnabled = self.isBackgroundTouchClosureEnabled;

    
}

#pragma mark  handle Notification
- (void)statusBarDidChangeOrientation:(NSNotification *)notification {
    self.bounds = [UIScreen mainScreen].bounds;
    self.background.frame = self.bounds;
    
    [self updateConstraints];

}

#pragma mark - handle close
/**asdf
 *  取消 HZPopView 的方法
 */
- (void)close
{
    if (![self isVisible]) {
        return;
    }
    
    self.hideAnimation(self);
    
    //    [UIView animateWithDuration:0.2
    //                          delay:0 
    //                        options:UIViewAnimationOptionCurveEaseInOut 
    //                     animations:^{
    //                         self.background.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    //                         self.backgroundColor =[UIColor clearColor];

    //                     } completion:^(BOOL finished) {
    //                         
    //                         [self cleanWindow];
    //                         self.visible = NO;
    //                         
    //                     }];
    
}

- (void)cleanWindow
{
    self.window.rootViewController = nil;
    self.window = nil;
    [self.previousKeyWindow makeKeyAndVisible];
}

#pragma mark - setter / getter
- (void)setType:(HZPopType)type
{
    _type = type;
    
    switch (type)
    {
        case HZPopTypeAlert:
        {
            self.showAnimation = [self alertShowAnimation];
            self.hideAnimation = [self alertHideAnimation];
            break;
        }
        case HZPopTypeSheet:
        {
            //            self.showAnimation = [self sheetShowAnimation];
            //            self.hideAnimation = [self sheetHideAnimation];
            break;
        }
        case HZPopTypeCustom:
        {
            //            self.showAnimation = [self customShowAnimation];
            //            self.hideAnimation = [self customHideAnimation];
            break;
        }
            
        default:
            break;
    }
}


- (BOOL)isVisible
{
    // action sheet is visible iff it's associated with a window
    return !!self.window && self.window.rootViewController;
}

- (HZPopBlock)alertShowAnimation
{
    @weakify(self);
    HZPopBlock block = ^(HZPopView *popView){
        @strongify(self);

        
        self.layer.transform = CATransform3DMakeScale(1.2f, 1.2f, 1.0f);
        self.alpha = 0.0f;
        
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             self.layer.transform = CATransform3DIdentity;
                             self.alpha = 1.0f;
                             self.background.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
                             
                         } completion:^(BOOL finished) {
                
                             self.visible = YES;
                             !self.showCompletionBlock?:self.showCompletionBlock(self, finished);
                             
                         }];
    };
    
    return block;
}

- (HZPopBlock)alertHideAnimation
{
    @weakify(self);
    HZPopBlock block = ^(HZPopView *popView){
        @strongify(self);
        
        [UIView animateWithDuration:0.3
                              delay:0
                            options: UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.alpha = 0.0f;
                         }
                         completion:^(BOOL finished) {
                             
                             if ( finished )
                             {
                                 [self cleanWindow];
                                 self.visible = NO;
                                 [self removeFromSuperview];
                             }
                             
                             !self.hideCompletionBlock?:self.hideCompletionBlock(self, finished);
                             
                         }];
    };
    
    return block;
}

@end
