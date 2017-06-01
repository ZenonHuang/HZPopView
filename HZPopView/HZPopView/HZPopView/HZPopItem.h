//
//  HZPopItem.h
//  HZPopView
//
//  Created by zz go on 2017/5/31.
//  Copyright © 2017年 zzgo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HZPopItemStyle) {
    HZPopItemStyleDefault = 0,
    HZPopItemStyleCancel,
    HZPopItemStyleDestructive,
};

@interface HZPopItem : UIButton
@property (nonatomic,nullable) UIColor *normalColor;
@property (nonatomic,nullable) UIColor *highlightedColor;
@property (nonatomic) HZPopItemStyle style;
@property (nonatomic,nullable,strong,readonly) void (^handler)(HZPopItem * button);
/**
 *  位于按钮后面的调节颜色的图层，在没有 `normalColor` 或 `highlightedColor` 时使用 ambientColor 替代
 */
@property (weak,nonatomic) UIView *behindColorView;

+ (instancetype)buttonWithTitle:(NSString *)title style:(HZPopItemStyle)style;
+ (instancetype)buttonWithTitle:(NSString *)title style:(HZPopItemStyle)style handler:(nullable void (^)(HZPopItem * button))handler;
@end

NS_ASSUME_NONNULL_END  
