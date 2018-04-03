//
//  SelectedVC.m
//  AxcFormListView
//
//  Created by Axc on 2018/4/2.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "SelectedVC.h"

@interface SelectedVC ()<AxcFormListViewDelegate>

@property(nonatomic, strong)UILabel *testShowLabel;
@property(nonatomic, strong)UIButton *testShowBtn;
@end

@implementation SelectedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}


- (void)createUI{
    self.formView = [[AxcFormListView alloc] initWithFrame:self.view.bounds];
    self.formView.formTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.formView.formTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
    self.formView.delegate = self;
    [self.view addSubview:self.formView];
    [self.formView mas_makeConstraints:^(MASConstraintMaker *make) {
        AxcWholeFrameLayout;
    }];
    
    // 1组对象构造器
    AxcFormItemSectionConfiguration *sectionC = [[AxcFormItemSectionConfiguration alloc] init];

    NSMutableArray *rowArray = [NSMutableArray array];
    // 基础使用 *******************************************************************************************************
    AxcFormItemConfiguration *time = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleDatePickUp];
    time.titleLabel.text = @"起始时间";
    time.formatText = @"yyyy-MM-dd";
    [rowArray addObject:time];
    // 以下为自定义样式，API和系统无异
    // 外观设置优化 *******************************************************************************************************
    AxcFormItemConfiguration *time2 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleDatePickUp];
    time2.required = YES;
    time2.titleLabel.text = @"选择时间";
    time2.titleLabel.font = [UIFont systemFontOfSize:15];
    time2.subtitleLabel.textColor = [UIColor lightGrayColor];
    time2.subtitleLabel.textAlignment = NSTextAlignmentRight;
    time2.subtitleLabel.font = [UIFont systemFontOfSize:14];
    time2.dateView.datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    time2.formatText = @"HH:mm:ss";  // 时间选择后转化的格式化文本
    [rowArray addObject:time2];
    // 基础使用 *******************************************************************************************************
    AxcFormItemConfiguration *pick = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStylePickUp];
    pick.titleLabel.text = @"滚轮选择器";
    pick.selectedArray = @[@"美国",@"中国",@"新加坡",@"意大利"]; // 单选
    pick.subtitleLabel.textAlignment = NSTextAlignmentRight;
    [rowArray addObject:pick];
    // 以下为自定义样式，API和系统无异
    // 设置优化 *******************************************************************************************************
    AxcFormItemConfiguration *pick2 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStylePickUp];
    pick2.titleLabel.text = @"多级滚轮选择";
    pick2.required = YES;
    pick2.subtitleLabel.textAlignment = NSTextAlignmentRight;
    pick2.selectedArray = @[@[@"美国",@"中国",@"新加坡",@"意大利"], // 多级选择 不支持联动，联动需要自定义设置
                           @[@"美国",@"中国",@"新加坡",@"意大利"],
                           @[@"美国",@"中国",@"新加坡",@"意大利"]];
    // 多级选择使用的格式化文本 默认是“-”
    pick2.formatText = @"~";
    [rowArray addObject:pick2];
    // 自定义，需要回调的代理设置 *******************************************************************************************************
    AxcFormItemConfiguration *customView = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleCustomView];
    customView.titleLabel.text = @"自定义拉起空白View";
    customView.customPullUpView.tag = 100;
    customView.subtitleLabel.textAlignment = NSTextAlignmentRight;
    customView.subtitleLabel.font = [UIFont systemFontOfSize:9];
    customView.subtitleLabel.numberOfLines = 0;
    [rowArray addObject:customView];
    
    
    // 所有元素添加进组构造器，成为一组
    sectionC.items = rowArray;
    // 添加一个组到表单
    [self.formView.formCollectionArray addObject:sectionC];
    [self.formView.formTableView reloadData];
}



// 当有一个View被提起的时候
- (void)AxcFormListView:(AxcFormListView *)axcFormListView
              indexPath:(NSIndexPath *)indexPath
             pullUpView:(AxcFormPullUpView *)pullUpView
                  style:(AxcFormItemConfigurationStyle )style{
    if (pullUpView.tag == 100) {
        pullUpView.titleLabel.text = @"自定义白板View选择";
        // 给自定义面板中添加控件
        [pullUpView addSubview:self.testShowLabel];
        [self.testShowLabel mas_updateConstraints:^(MASConstraintMaker *make) { // 每次提起时都会执行，所以需要用的是更新约束
            make.top.mas_equalTo(pullUpView.titleLabel.mas_bottom).offset(20);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(40);
        }];
        [pullUpView addSubview:self.testShowBtn];
        [self.testShowBtn mas_updateConstraints:^(MASConstraintMaker *make) { // 每次提起时都会执行，所以需要用的是更新约束
            make.center.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        // 添加点击确定的事件
        [pullUpView.rightBtn addTarget:self action:@selector(clickOKBtn) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)clickOKBtn{ // 获取构造器，使用下标
    AxcFormItemConfiguration *customView = [[self.formView.formCollectionArray objectAtIndex:0].items objectAtIndex:4];
    customView.subtitleLabel.text = self.testShowLabel.text; // 赋值 内部会进行监听，保存这个结果到表单
    [self.formView dismiss_pullView];  // 收起这个View
}
- (void)click_testShowBtn{
    NSLog(@"点击了自定义View上的按钮");
    [self clickOKBtn];
}










// 点击Cell触发后
- (void)AxcFormListView:(AxcFormListView *)axcFormListView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
                  style:(AxcFormItemConfigurationStyle )style{
    
}
#pragma mark - 懒加载
- (UILabel *)testShowLabel{
    if (!_testShowLabel) {
        _testShowLabel = [UILabel new];
        _testShowLabel.text = @"可以在代理中设置pullUpView的大小宽高\n默认大小为 屏宽 和 屏高/2";
        _testShowLabel.numberOfLines = 0;
        _testShowLabel.font = [UIFont systemFontOfSize:14];
    }
    return _testShowLabel;
}
- (UIButton *)testShowBtn{
    if (!_testShowBtn) {
        _testShowBtn = [UIButton new];
        _testShowBtn.backgroundColor = [UIColor AxcUI_PumpkinColor];
        [_testShowBtn setTitle:@"测试按钮" forState:UIControlStateNormal];
        [_testShowBtn addTarget:self action:@selector(click_testShowBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testShowBtn;
}

@end
