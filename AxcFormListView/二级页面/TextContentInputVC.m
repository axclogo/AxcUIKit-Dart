//
//  TextContentInputVC.m
//  AxcFormListView
//
//  Created by Axc on 2018/4/2.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "TextContentInputVC.h"

@interface TextContentInputVC ()

@end

@implementation TextContentInputVC

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
    AxcFormItemConfiguration *content = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleContentTextInput];
    content.titleLabel.text = @"个人简介";
    content.contentTextView.backgroundColor = [UIColor AxcUI_CloudColor];
    content.initialHeight = 100; // 初始高度
    [rowArray addObject:content];
    // 以下为自定义样式，API和系统无异
    // 外观设置优化 *******************************************************************************************************
    AxcFormItemConfiguration *content2 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleContentTextInput];
    content2.titleLabel.text = @"特长";
    content2.titleLabel.font = [UIFont systemFontOfSize:15];
    content2.required = YES;
    content2.contentTextView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    content2.contentTextView.layer.borderWidth = 0.5;
    content2.contentTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    content2.contentTextView.layer.masksToBounds = YES;
    content2.contentTextView.layer.cornerRadius = 5;
    content2.contentTextView.backgroundColor = [UIColor AxcUI_colorWithHexColor:@"f6f6f6"];
    content2.initialHeight = 150;
    content2.maxInputLength = 50;
    // 设置普通未超出字符的样式
    content2.numberCharactersNormal = ^(AxcUI_Label *label) {
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
    };
    // 设置超出文本后的样式，不设置即默认为普通状态
    content2.numberCharactersMaxCeiling = ^(AxcUI_Label *label) {
        label.textColor = [UIColor redColor];
    };
    // 设置文案管理，回调一个当前字符数量和总共的字符数量
    content2.numberCharactersFormatting = ^NSString *(NSInteger currentInputLength, NSInteger maxInputLength) {
        return [NSString stringWithFormat:@"当前：%ld/最大:%ld",currentInputLength,maxInputLength];
    };
    content2.cellPartingLineStyle = AxcFormItemConfigurationCellPartingLineStyleNone; // 去除单个Cell分割线
    [rowArray addObject:content2];
    // 其他外观 单个Cell去除分割线 *******************************************************************************************************
    AxcFormItemConfiguration *content3 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleContentTextInput];
    content3.titleLabel.text = @"个人荣誉";
    content3.titleLabel.font = [UIFont systemFontOfSize:15];
    content3.required = YES;
    content3.contentTextView.font = [UIFont systemFontOfSize:14];
    content3.contentTextView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    content3.contentTextView.layer.borderWidth = 0.5;
    content3.contentTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    content3.contentTextView.layer.masksToBounds = YES;
    content3.contentTextView.layer.cornerRadius = 5;
    content3.contentTextView.backgroundColor = [UIColor AxcUI_colorWithHexColor:@"f6f6f6"];
    content3.initialHeight = 150;
    content3.backGroundColor = [UIColor groupTableViewBackgroundColor];
    content3.cellPartingLineStyle = AxcFormItemConfigurationCellPartingLineStyleNone; // 去除单个Cell分割线
    [rowArray addObject:content3];
    // 专业特长 *******************************************************************************************************
    AxcFormItemConfiguration *content4 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleContentTextInput];
    content4.titleLabel.text = @"专业特长";
    content4.titleLabel.font = [UIFont systemFontOfSize:15];
    content4.contentTextView.layer.masksToBounds = YES;
    content4.contentTextView.layer.cornerRadius = 5;
    content4.contentTextView.backgroundColor = [UIColor AxcUI_CloudColor];
    content4.contentTextView.font = [UIFont systemFontOfSize:14];
    content4.contentTextView.textColor = [UIColor AxcUI_SilverColor];
    content4.contentTextView.text = @"熟悉Objective-C\n熟悉面向对象设计\n面向AOP编程";
    content4.initialHeight = 120; // 初始高度
    [rowArray addObject:content4];
    
    
    
    
    
    // 组对象构造器
    AxcFormItemSectionConfiguration *sectionC = [[AxcFormItemSectionConfiguration alloc] init];
    sectionC.items = rowArray;
    
    
    [self.formView.formCollectionArray addObject:sectionC];
    [self.formView.formTableView reloadData];
}



@end
