//
//  HZPopViewController.h
//  HZPopView
//
//  Created by zz go on 2017/5/25.
//  Copyright © 2017年 zzgo. All rights reserved.
//

#import "HZPopView.h"

@class HZPopBackground;
@class HZPopView;

@interface HZPopViewController : UIViewController
@property (weak, nonatomic) HZPopView *popView;
@property (weak, nonatomic) HZPopBackground *popBackground;
@end
