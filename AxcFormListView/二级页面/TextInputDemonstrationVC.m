//
//  TextInputDemonstrationVC.m
//  AxcFormListView
//
//  Created by Axc on 2018/4/2.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "TextInputDemonstrationVC.h"

@interface TextInputDemonstrationVC ()

@end

@implementation TextInputDemonstrationVC

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
    AxcFormItemConfiguration *input = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleTextInput];
    input.titleLabel.text = @"基础使用：";
    input.subtitleTextField.placeholder = @"请输入你的XXX";
    [rowArray addObject:input];
    // 以下为自定义样式，API和系统无异
    // 外观设置优化 *******************************************************************************************************
    AxcFormItemConfiguration *input2 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleTextInput];
    input2.regularStr = @"^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$"; // 设置正则匹配
    input2.required = YES;                          // 设置为必选
    input2.titleLabel.text = @"输入邮箱";
    input2.titleLabel.font = [UIFont systemFontOfSize:15];
    input2.subtitleTextField.textColor = [UIColor AxcUI_SilverColor];
    input2.subtitleTextField.placeholder = @"请输入邮箱(必填)";
    input2.subtitleTextField.axcUI_PlaceholderLabel.textColor = [UIColor AxcUI_CarrotColor];
    input2.subtitleTextField.font = [UIFont systemFontOfSize:14];
    input2.subtitleTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    input2.subtitleTextField.leftViewMode = UITextFieldViewModeAlways; // 设置左边距
    input2.subtitleTextField.layer.borderWidth = 0.5;
    input2.subtitleTextField.layer.borderColor = [[UIColor AxcUI_CloudColor] CGColor];
    input2.subtitleTextField.layer.masksToBounds = YES;
    input2.subtitleTextField.layer.cornerRadius = 5;
    [rowArray addObject:input2];
    // 匹配正则但不是必选 *******************************************************************************************************
    AxcFormItemConfiguration *input3 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleTextInput];
    input3.regularStr = @"^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$"; // 设置正则匹配
    input3.titleLabel.text = @"输入邮箱";
    input3.titleLabel.font = [UIFont systemFontOfSize:15];
    input3.subtitleTextField.textColor = [UIColor AxcUI_SilverColor];
    input3.subtitleTextField.placeholder = @"请输入邮箱(校验)";
    input3.subtitleTextField.backgroundColor = [UIColor whiteColor];
    input3.backGroundColor = [UIColor groupTableViewBackgroundColor]; // Cell的背景色
    [rowArray addObject:input3];
    // 设置字符数量限制 *******************************************************************************************************
    AxcFormItemConfiguration *input4 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleTextInput];
    input4.titleLabel.text = @"字符数量：";
    input4.subtitleTextField.placeholder = @"请输入10个字符";
    input4.maxInputLength = 10;
    [rowArray addObject:input4];
    // 超出字符后的相关设置以及文本格式*******************************************************************************************************
    AxcFormItemConfiguration *input5 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleTextInput];
    input5.titleLabel.text = @"回调和文案";
    input5.subtitleTextField.placeholder = @"字符数量回调以及文案管理";
    input5.maxInputLength = 10;
    // 设置普通未超出字符的样式
    input5.numberCharactersNormal = ^(AxcUI_Label *label) {
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
    };
    // 设置超出文本后的样式，不设置即默认为普通状态
    input5.numberCharactersMaxCeiling = ^(AxcUI_Label *label) {
        label.textColor = [UIColor redColor];
    };
    // 设置文案管理，回调一个当前字符数量和总共的字符数量
    input5.numberCharactersFormatting = ^NSString *(NSInteger currentInputLength, NSInteger maxInputLength) {
        return [NSString stringWithFormat:@"(%ld-%ld)",currentInputLength,maxInputLength];
    };
    [rowArray addObject:input5];
    // 超出字符后的相关设置以及文本格式2*******************************************************************************************************
    AxcFormItemConfiguration *input6 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleTextInput];
    input6.titleLabel.text = @"你的名字？";
    input6.subtitleTextField.placeholder = @"自定义文案";
    input6.maxInputLength = 5;
    // 设置普通未超出字符的样式
    input6.numberCharactersNormal = ^(AxcUI_Label *label) {
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
    };
    // 设置超出文本后的样式，不设置即默认为普通状态
    input6.numberCharactersMaxCeiling = ^(AxcUI_Label *label) {
        label.textColor = [UIColor redColor];
    };
    // 设置文案管理，回调一个当前字符数量和总共的字符数量
    input6.numberCharactersFormatting = ^NSString *(NSInteger currentInputLength, NSInteger maxInputLength) {
        return [NSString stringWithFormat:@"当前：%ld/最大:%ld",currentInputLength,maxInputLength];
    };
    [rowArray addObject:input6];
    // 左视图 *******************************************************************************************************
    AxcFormItemConfiguration *input7 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleTextInput];
    input7.titleLabel.text = @"搜索";
    input7.titleLabel.font = [UIFont systemFontOfSize:15];
    input7.subtitleTextField.placeholder = @"输入你想搜索的内容";
    UIImageView *glassImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"glass_img"]];
    glassImageView.axcUI_Size = CGSizeMake(30, 20);
    glassImageView.contentMode = UIViewContentModeScaleAspectFit;
    input7.subtitleTextField.leftView = glassImageView;
    input7.subtitleTextField.leftViewMode = UITextFieldViewModeAlways;
    [rowArray addObject:input7];
    // 同理右视图 *******************************************************************************************************
    AxcFormItemConfiguration *input8 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleTextInput];
    input8.required = YES;                          // 设置为必选
    input8.titleLabel.text = @"搜索";
    input8.titleLabel.font = [UIFont systemFontOfSize:15];
    input8.subtitleTextField.placeholder = @"输入你想搜索的内容";
    UIImageView *glassImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"glass_img"]];
    glassImageView2.axcUI_Size = CGSizeMake(30, 20);
    glassImageView2.contentMode = UIViewContentModeScaleAspectFit;
    input8.subtitleTextField.rightView = glassImageView2;
    input8.subtitleTextField.rightViewMode = UITextFieldViewModeAlways;
    input8.subtitleTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    input8.subtitleTextField.textAlignment = NSTextAlignmentCenter;
    input8.subtitleTextField.layer.borderWidth = 0.5;
    input8.subtitleTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    input8.subtitleTextField.layer.masksToBounds = YES;
    input8.subtitleTextField.layer.cornerRadius = 15;
    [rowArray addObject:input8];
    
    // 组对象构造器
    AxcFormItemSectionConfiguration *sectionC = [[AxcFormItemSectionConfiguration alloc] init];
    sectionC.items = rowArray;
    
    [self.formView.formCollectionArray addObject:sectionC];
    [self.formView.formTableView reloadData];
    
    
}


@end
