//
//  OtherSelectedVC.m
//  AxcFormListView
//
//  Created by Axc on 2018/4/2.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "OtherSelectedVC.h"

@interface OtherSelectedVC ()

@end

@implementation OtherSelectedVC

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
    AxcFormItemConfiguration *sheet = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleActionSheet];
    sheet.titleLabel.text = @"Sheet单选";
    sheet.selectedArray = @[@"美国",@"中国",@"新加坡",@"意大利"]; // 单选
    // 其他必要设置
    sheet.required = YES;
    sheet.subtitleLabel.textAlignment = NSTextAlignmentRight;
    sheet.subtitleLabel.textColor = [UIColor lightGrayColor];
    [rowArray addObject:sheet];
    // 基础使用 *******************************************************************************************************
    AxcFormItemConfiguration *alent = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleAlent];
    alent.titleLabel.text = @"Alent单选";
    alent.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    alent.selectedArray = @[@"美国",@"中国",@"新加坡",@"意大利"]; // 单选
    [rowArray addObject:alent];
    // 基础使用 *******************************************************************************************************
    AxcFormItemConfiguration *segmented = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleSegmented];
    segmented.required = YES;
    segmented.titleLabel.text = @"你的性别";
    segmented.selectedArray = @[@"男",@"女"];
    [rowArray addObject:segmented];
    // 以下为自定义样式，API和系统无异
    // 外观设置优化 *******************************************************************************************************
    AxcFormItemConfiguration *segmented2 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleSegmented];
    segmented2.titleLabel.text = @"你的性别";
    segmented2.selectedArray = @[@"男",@"女"];
    segmented2.segmentedControl.tintColor = kThemeColor;
    segmented2.cellPartingLineStyle = AxcFormItemConfigurationCellPartingLineStyleNone; // 单去除这个cell元素的系统分割线
    [rowArray addObject:segmented2];
    // 更多选项
    AxcFormItemConfiguration *segmented3 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleSegmented];
    segmented3.required = YES;
    segmented3.titleLabel.text = @"学历";
    segmented3.selectedArray = @[@"幼儿园",@"小学",@"初中",@"高中",@"本科"];
    segmented3.segmentedControl.tintColor = kThemeColor;
    segmented3.backGroundColor = [UIColor groupTableViewBackgroundColor]; // Cell的背景色
    segmented3.cellPartingLineStyle = AxcFormItemConfigurationCellPartingLineStyleNone; // 单去除这个cell元素的系统分割线
    [rowArray addObject:segmented3];
    // 就跟使用系统控件一个道理 不再过多演示 segmentedControl
    AxcFormItemConfiguration *segmented4 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleSegmented];
    segmented4.titleLabel.text = @"身份";
    segmented4.selectedArray = @[@"BOSS",@"应聘者"];
    segmented4.backGroundColor = [UIColor groupTableViewBackgroundColor]; // Cell的背景色
    //分段控件的响应事件
    [segmented4.segmentedControl addTarget:self action:@selector(segmengAction:)forControlEvents:UIControlEventValueChanged];
    [rowArray addObject:segmented4];
    
    
    
    // 1组对象构造器
    AxcFormItemSectionConfiguration *sectionC = [[AxcFormItemSectionConfiguration alloc] init];
    // 所有元素添加进组构造器，成为一组
    sectionC.items = rowArray;
    // 添加一个组到表单
    [self.formView.formCollectionArray addObject:sectionC];
    [self.formView.formTableView reloadData];
}

- (void)segmengAction:(UISegmentedControl *)sender{
    NSLog(@"%ld",sender.selectedSegmentIndex);
}

@end
