//
//  HZTestViewController.m
//  HZPopView
//
//  Created by zz go on 2017/5/26.
//  Copyright © 2017年 zzgo. All rights reserved.
//

#import <Masonry.h>
#import "NSObject+HUD.h"
#import "HZShowPopViewController.h"
#import "HZPopView.h"

@interface HZShowPopViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HZShowPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = @[@"HZPop",@"show HUD"][indexPath.row];
    cell.textLabel.textColor = [UIColor redColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self action:indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)action                          :(NSUInteger)index;
{
    switch ( index ) {
        case 0                      :
        {
            @autoreleasepool {
                // Code benefitting from a local autorelease pool.
                HZPopView *popView=[HZPopView new];
                //            UIView *container=(UIView *)popView.popContainer;
                [popView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(popView.superview);
                    make.size.mas_equalTo(CGSizeMake(200, 100));
                }];
                [popView show];
            }
            
            break;
        }
            
        case 1                      :
        {
            [[NSObject class] hz_showHUD];
            
            dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, 5.0 * NSEC_PER_SEC);
            dispatch_after(timer, dispatch_get_main_queue(), ^(void){
                //NSLog(@"GCD-----%@",[NSThread currentThread]);
                [[NSObject class] hz_hideHUD];
            });
            
            break;
        }
        default                         :
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

