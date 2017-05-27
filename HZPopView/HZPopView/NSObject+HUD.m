//
//  NSObject+HUD.m
//  gosparkchat
//
//  Created by zzgo on 2016/10/13.
//  Copyright © 2016年 gospark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+HUD.h"
#import "AppDelegate.h"


static CGFloat const kTime = 2.0f;
static CGFloat const kSuccessMessageTime = 0.3f;
static CGFloat const kFailureMessageTime = 0.8f;

@implementation NSObject (HUD)

//---------------------显示成功,几秒后消失------------------------------------
/** 显示成功文字和图片,几秒后消失 */
+ (void)hz_showSuccess:(NSString *)success
{
  [self hz_showText:success icon:@"success.png" view:nil afterDelay:kSuccessMessageTime];
}
/** 显示成功文字和图片,几秒后消失(放到指定view中) */
+ (void)hz_showSuccess:(NSString *)success toView:(UIView *)view
{
  [self hz_showText:success icon:@"success.png" view:view afterDelay:kSuccessMessageTime];
}

//------------------------显示出错,几秒后消失---------------------------------
/** 显示出错图片和文字,几秒后消失 */
+ (void)hz_showError:(NSString *)error
{
  [self hz_showText:error icon:@"error.png" view:nil afterDelay:kFailureMessageTime];
}
/** 显示出错图片和文字,几秒后消失(放到指定view中) */
+ (void)hz_showError:(NSString *)error toView:(UIView *)view
{
  [self hz_showText:error icon:@"error.png" view:view afterDelay:kFailureMessageTime];
}

//--------------------------显示信息,几秒后消失-------------------------------
/**  只显示文字,几秒后消失 */
+ (void)hz_showText:(NSString *)text
{
  [self hz_showText:text icon:nil view:nil];
}
/**  只显示文字,几秒后消失(放到指定view中) */
+ (void)hz_showText:(NSString *)text toView:(UIView *)view
{
  [self hz_showText:text icon:nil view:view];
}

/**  只显示图片,几秒后消失 */
+ (void)hz_showIcon:(NSString *)icon
{
  [self hz_showText:nil icon:icon view:nil];
}

/**  只显示图片,几秒后消失(放到指定view中) */
+ (void)hz_showIcon:(NSString *)icon view:(UIView *)view
{
  [self hz_showText:nil icon:icon view:view];
}

/**  显示文字和图片,几秒后消失 */
+ (void)hz_showText:(NSString *)text icon:(NSString *)icon
{
  [self hz_showText:text icon:icon view:nil];
}

+ (UIView *)rootWindowView
{
  UIView *view = [[UIApplication sharedApplication].windows lastObject];
  return view;
}

+ (void)hz_showText:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
  [self hz_showText:text icon:icon view:view afterDelay:kTime];
}

/**  显示文字和图片,几秒后消失(放到指定view中) */
+ (void)hz_showText:(NSString *)text
               icon:(NSString *)icon
               view:(UIView *)view
         afterDelay:(NSTimeInterval)delay
{
  if (view == nil) {
    view = [self rootWindowView];
  }
  // 快速显示一个提示信息
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
  
//  hud.labelText = text;
  hud.labelText=text;
  hud.labelFont = [UIFont systemFontOfSize:14];
  //    hud.minSize = CGSizeMake(100, 100);
  // GCC的C扩充功能Code Block Evaluation，
  //    hud.color = kColorTheme;
  
  // YES代表需要蒙版效果(默认是NO)
  //    hud.dimBackground = YES;
  
  // 设置图片
  NSString *imgStr = [NSString stringWithFormat:@"%@", icon];
  hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgStr]];
  
  // 再设置模式
  hud.mode = MBProgressHUDModeCustomView;
  
  // 隐藏时候从父控件中移除
  hud.removeFromSuperViewOnHide = YES;
  
  // 几秒之后再消失
  [hud hide:YES afterDelay:delay];
//  [hud hideAnimated:YES afterDelay:delay];
}

//*******************************我是快乐的分割线*************************************/
//--------------------------显示HUD-------------------------------
/** 只显示菊花(需要主动让它消失,HUD放在Window中) */
+ (MBProgressHUD *)hz_showHUD
{
  return [self hz_showMessage:nil toView:nil];
}

/** 显示菊花和文字(需要主动让它消失,HUD放在Window中) */
+ (MBProgressHUD *)hz_showMessage:(NSString *)message
{
  return [self hz_showMessage:message toView:nil];
}

/** 显示菊花和文字(需要主动让它消失，HUD放到指定view中) */
+ (MBProgressHUD *)hz_showMessage:(NSString *)message toView:(UIView *)view
{
  if (view == nil) {
      //      view = [[UIApplication sharedApplication].windows lastObject];
      view=[[UIApplication sharedApplication].delegate window];
  }
  // 快速显示一个提示信息
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
  hud.labelText = message;
  
  hud.labelFont = [UIFont systemFontOfSize:14];
  //    hud.minSize = CGSizeMake(100, 100);
  //    hud.size = CGSizeMake(100, 100);
  
  // 隐藏时候从父控件中移除
  hud.removeFromSuperViewOnHide = YES;
  // YES代表需要蒙版效果(默认是NO)
  //    hud.dimBackground = YES;
  
  return hud;
}

//--------------------------隐藏HUD-------------------------------
/** 隐藏HUD(HUD在Window中) */
+ (void)hz_hideHUD
{
  [self hz_hideHUDForView:nil];
}

/** 隐藏HUD(HUD在指定view中) */
+ (void)hz_hideHUDForView:(UIView *)view
{
  if (view == nil) {
//    view = [[UIApplication sharedApplication].windows lastObject];
      view =[[UIApplication sharedApplication].delegate window];
  }
  [MBProgressHUD hideHUDForView:view animated:YES];
}

- (void)hz_alert:(NSString *)text
{
  [[self class] hz_showText:text];
}

- (BOOL)hz_alertError:(NSError *)error
{
  if (error) {
    if ([error.domain isEqualToString:NSURLErrorDomain]) {
      [self hz_alert:@"网络连接发生错误"];
    }
    else {
#ifndef DEBUG
      [self hz_alert:[NSString stringWithFormat:@"%@", error]];
#else
      NSString *info = error.localizedDescription;
      [self hz_alert:info ? info : [NSString stringWithFormat:@"%@", error]];
#endif
    }
    return YES;
  }
  return NO;
}

- (BOOL)hz_filterError:(NSError *)error
{
  return [self hz_alertError:error] == NO;
}

- (void)hz_showErrorAlert:(NSString *)text
{
  [[self class] hz_showError:text];
}

- (void)hz_showSuccessAlert:(NSString *)text
{
  [[self class] hz_showSuccess:text];
}

- (void)hz_toast:(NSString *)text duration:(NSTimeInterval)duration
{
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[self class] rootWindowView] animated:YES];
  //    hud.labelText=text;
  hud.detailsLabelFont = [UIFont systemFontOfSize:14];
//  hud.detailsLabel.font=[UIFont systemFontOfSize:14];
  hud.detailsLabelText = text;
  hud.margin = 10.f;
  hud.removeFromSuperViewOnHide = YES;
  hud.mode = MBProgressHUDModeText;
  [hud hide:YES afterDelay:duration];
}

- (void)hz_showNetworkIndicator
{
  UIApplication *app = [UIApplication sharedApplication];
  app.networkActivityIndicatorVisible = YES;
}

- (void)hz_hideNetworkIndicator
{
  UIApplication *app = [UIApplication sharedApplication];
  app.networkActivityIndicatorVisible = NO;
}

- (void)hz_showProgress
{
  [MBProgressHUD showHUDAddedTo:[[self class] rootWindowView] animated:YES];
}

- (void)hz_hideProgress
{
  [MBProgressHUD hideHUDForView:[[self class] rootWindowView] animated:YES];
}

- (void)hz_showHUDText:(NSString *)text
{
  [self hz_toast:text];
}

- (void)hz_toast:(NSString *)text
{
  [self hz_toast:text duration:2];
}

@end
