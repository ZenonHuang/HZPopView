//
//  UIViewController+UIViewController_HZAlert.m
//  gosparkchat
//
//  Created by zz go on 2016/11/2.
//  Copyright © 2016年 gospark. All rights reserved.
//


#if __has_include(<TBAlertController.h>)
#import <TBAlertController.h>
#endif

#import <Foundation/Foundation.h>
#import "UIViewController+HZAlert.h"

@implementation UIViewController (HZAlert)
-(void)hz_showAlertWithTitle:(NSString *)title message:(NSString *)aMessage{

#if __has_include(<TBAlertController.h>)
    TBAlertAction *confirmAction=[TBAlertAction actionWithTitle:NSLocalizedString(@"Confirm", nil)  style:TBAlertActionStyleDefault handler:nil];
    
    TBAlertController *alerVC= [TBAlertController alertControllerWithTitle:title message:aMessage preferredStyle:TBAlertControllerStyleAlert];
    [alerVC addAction:confirmAction];
    [self presentViewController:alerVC animated:YES completion:nil];

#endif

}
@end
