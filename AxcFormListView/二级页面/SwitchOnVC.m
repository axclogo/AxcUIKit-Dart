//
//  SwitchOnVC.m
//  AxcFormListView
//
//  Created by Axc on 2018/4/2.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "SwitchOnVC.h"

@interface SwitchOnVC ()

@end

@implementation SwitchOnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}


- (void)createUI{
    self.formView = [[AxcFormListView alloc] initWithFrame:self.view.bounds];
    self.formView.formTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.formView.formTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
    [self.view addSubview:self.formView];
    [self.formView mas_makeConstraints:^(MASConstraintMaker *make) {
        AxcWholeFrameLayout;
    }];
    
    
    
    NSMutableArray *rowArray = [NSMutableArray array];
    // 基础使用 *******************************************************************************************************
    AxcFormItemConfiguration *switchC = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleSwitch];
    switchC.titleLabel.text = @"开启免打扰";
    [rowArray addObject:switchC];
    // 以下为自定义样式，API和系统无异
    // 外观设置优化 *******************************************************************************************************
    AxcFormItemConfiguration *switchC2 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleSwitch];
    switchC2.titleLabel.text = @"推送设置";
    switchC2.required = YES;
    [switchC2.switchControl addTarget:self action:@selector(click_switchC) forControlEvents:UIControlEventValueChanged];
    switchC2.cellPartingLineStyle = AxcFormItemConfigurationCellPartingLineStyleNone;
    [rowArray addObject:switchC2];
    //
    AxcFormItemConfiguration *switchC3 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleSwitch];
    switchC3.titleLabel.text = @"每日提醒";
    switchC3.required = YES;
    [switchC3.switchControl addTarget:self action:@selector(click_switchC) forControlEvents:UIControlEventValueChanged];
    switchC3.cellPartingLineStyle = AxcFormItemConfigurationCellPartingLineStyleNone;
    switchC3.switchControl.on = YES; // 直接赋值就完事了
    switchC3.switchControl.tintColor = kThemeColor;
    switchC3.switchControl.onTintColor = kThemeColor;
    switchC3.backGroundColor = [UIColor groupTableViewBackgroundColor];
    switchC3.initialHeight = 100;  // 支持预设高度
    [rowArray addObject:switchC3];
    //
    AxcFormItemConfiguration *switchC4 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleSwitch];
    switchC4.titleLabel.text = @"在职状态";
    [switchC4.switchControl addTarget:self action:@selector(click_switchC) forControlEvents:UIControlEventValueChanged];
    [rowArray addObject:switchC4];
    
    
    
    
    
    
    // 1组对象构造器
    AxcFormItemSectionConfiguration *sectionC = [[AxcFormItemSectionConfiguration alloc] init];
    // 所有元素添加进组构造器，成为一组
    sectionC.items = rowArray;
    // 添加一个组到表单
    [self.formView.formCollectionArray addObject:sectionC];
    [self.formView.formTableView reloadData];
}

- (void)click_switchC{
    NSLog(@"触发了开关事件");
}

@end
