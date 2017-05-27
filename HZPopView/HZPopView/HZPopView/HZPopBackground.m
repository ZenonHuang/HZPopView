//
//  HZPopBackground.m
//  HZPopView
//
//  Created by zz go on 2017/5/26.
//  Copyright © 2017年 zzgo. All rights reserved.
//

#import "HZPopBackground.h"

@implementation HZPopBackground

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    return self;
}

//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    
//    UIView *view=[super hitTest:point withEvent:event];
//
//    if (view==self) {
//        for (UIView *subView in  self.subviews ) {
//            if ([subView respondsToSelector:@selector(close)]) {
//                [subView performSelector:@selector(close)];
//            }
//        }
//    }
//   
//
//    return view;
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    for (int i=0; i< self.subviews.count ; i++) {  
        @autoreleasepool {
            UIView *subView=self.subviews[i];
            if ([subView respondsToSelector:@selector(close)]) {
                [subView performSelector:@selector(close)];
            }
         }
    }

}

//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
////    if ([self.superview respondsToSelector:@selector(close)]) {
////        [self.superview performSelector:@selector(close)];
////    }
//    for (UIView *subView in  self.subviews ) {
//        if ([subView respondsToSelector:@selector(close)]) {
//            [subView performSelector:@selector(close)];
//        }
//    }
//}
@end
