//
//  HZPopView.h
//  HZPopView
//
//  Created by zz go on 2017/5/25.
//  Copyright © 2017年 zzgo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HZPopType) {
    HZPopTypeAlert,
    HZPopTypeSheet,
    HZPopTypeCustom,
};

NS_ASSUME_NONNULL_BEGIN


@class HZPopView;

typedef void(^HZPopBlock)(HZPopView *);
typedef void(^HZPopCompletionBlock)(HZPopView *, BOOL);

@interface HZPopView : UIView

/**
 *  支持的朝向
 */
@property(nonatomic,assign) UIInterfaceOrientationMask supportedInterfaceOrientations UI_APPEARANCE_SELECTOR;

/**
 *   标记藏于 HZPopView 下面的 UIWindow
 */
@property (weak, nonatomic, readonly) UIWindow *previousKeyWindow;

/**
 *  是否点击背景后关闭 HZPopView
 */
@property (nonatomic, getter=isBackgroundTouchClosureEnabled) NSInteger backgroundTouchClosureEnabled UI_APPEARANCE_SELECTOR;



@property (nonatomic, assign          ) HZPopType    type;                // default is HZPopTypeAlert.

@property (nonatomic, copy            ) HZPopCompletionBlock   showCompletionBlock; // show completion block.
@property (nonatomic, copy            ) HZPopCompletionBlock   hideCompletionBlock; // hide completion block

@property (nonatomic, copy            ) HZPopBlock   showAnimation;       // custom show animation block.
@property (nonatomic, copy            ) HZPopBlock   hideAnimation;       // custom hide animation block.


/**
 弹出 HZPopView
 */
-(void)show;

@end

NS_ASSUME_NONNULL_END
