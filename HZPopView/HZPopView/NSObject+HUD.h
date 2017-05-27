//
//  NSObject+HUD.h
//  gosparkchat
//
//  Created by zzgo on 2016/10/13.
//  Copyright © 2016年 gospark. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
#import <UIKit/UIKit.h>

@interface NSObject (HUD)

//---------------------显示成功,几秒后消失------------------------------------

/** 显示成功文字和图片,几秒后消失 */
+ (void)hz_showSuccess:(NSString *)success;

/** 显示成功文字和图片,几秒后消失(放到指定view中) */
+ (void)hz_showSuccess:(NSString *)success toView:(UIView *)view;

//------------------------显示出错,几秒后消失---------------------------------

/** 显示出错图片和文字,几秒后消失 */
+ (void)hz_showError:(NSString *)error;

/** 显示出错图片和文字,几秒后消失(放到指定view中) */
+ (void)hz_showError:(NSString *)error toView:(UIView *)view;

//--------------------------显示信息,几秒后消失-------------------------------

/**  只显示文字,几秒后消失 */
+ (void)hz_showText:(NSString *)text;
/**  只显示文字,几秒后消失(放到指定view中) */
+ (void)hz_showText:(NSString *)text toView:(UIView *)view;

/**  只显示图片,几秒后消失 */
+ (void)hz_showIcon:(NSString *)icon;
/**  只显示图片,几秒后消失(放到指定view中) */
+ (void)hz_showIcon:(NSString *)icon view:(UIView *)view;

/**  显示文字和图片,几秒后消失 */
+ (void)hz_showText:(NSString *)text icon:(NSString *)icon;
/**  显示文字和图片,几秒后消失(放到指定view中) */
+ (void)hz_showText:(NSString *)text icon:(NSString *)icon view:(UIView *)view;

//*******************************我是快乐的分割线*************************************
//--------------------------显示HUD-------------------------------
/** 只显示菊花(需要主动让它消失,HUD放在Window中) */
+ (MBProgressHUD *)hz_showHUD;
/** 显示菊花和文字(需要主动让它消失,HUD放在Window中) */
+ (MBProgressHUD *)hz_showMessage:(NSString *)message;
/** 显示菊花和文字(需要主动让它消失，HUD放到指定view中) */
+ (MBProgressHUD *)hz_showMessage:(NSString *)message toView:(UIView *)view;

//--------------------------隐藏HUD-------------------------------
/** 隐藏HUD(HUD在Window中) */
+ (void)hz_hideHUD;
/** 隐藏HUD(HUD在指定view中) */
+ (void)hz_hideHUDForView:(UIView *)view;

- (void)hz_showNetworkIndicator;

- (void)hz_hideNetworkIndicator;

- (void)hz_showProgress;

- (void)hz_hideProgress;

- (void)hz_alert:(NSString *)text;

- (BOOL)hz_alertError:(NSError *)error;

- (BOOL)hz_filterError:(NSError *)error;

- (void)hz_showHUDText:(NSString *)text;

- (void)hz_toast:(NSString *)text;

- (void)hz_toast:(NSString *)text duration:(NSTimeInterval)duration;

- (void)hz_showErrorAlert:(NSString *)text;

- (void)hz_showSuccessAlert:(NSString *)text;

@end
