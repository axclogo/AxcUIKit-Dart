//
//  ComprehensiveUseOfVC.m
//  AxcFormListView
//
//  Created by Axc on 2018/4/2.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "ComprehensiveUseOfVC.h"

@interface ComprehensiveUseOfVC ()

@end

@implementation ComprehensiveUseOfVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.formView = [[AxcFormListView alloc] initWithStyle:UITableViewStylePlain];
    self.formView.formTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.formView.formTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
    [self.view addSubview:self.formView];
    [self.formView mas_makeConstraints:^(MASConstraintMaker *make) {
        AxcWholeFrameLayout;
    }];
    [self createUI];
}


- (void)createUI{
    // 组对象构造器
    AxcFormItemSectionConfiguration *sectionC = [[AxcFormItemSectionConfiguration alloc] init];
    sectionC.sectionHeaderTitle = @"个人信息";
    NSMutableArray *rowArray = [NSMutableArray array];
    //
    AxcFormItemConfiguration *name = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleTextInput];
    name.required = YES;                          // 设置为必选
    name.titleLabel.text = @"姓名";
    name.subtitleTextField.placeholder = @"请填写姓名";
    [self settingTextField:name.subtitleTextField];
    [self settingTitleLabel:name.titleLabel];
    [rowArray addObject:name];
    //
    AxcFormItemConfiguration *email = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleTextInput];
    email.required = YES;                          // 设置为必选
    email.titleLabel.text = @"邮箱";
    email.subtitleTextField.placeholder = @"请填写邮箱";
    email.regularStr = @"^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$"; // 设置正则匹配
    [self settingTextField:email.subtitleTextField];
    [self settingTitleLabel:email.titleLabel];
    [rowArray addObject:email];
    //
    AxcFormItemConfiguration *gender = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleSegmented];
    gender.required = YES;                          // 设置为必选
    gender.titleLabel.text = @"性别";
    gender.selectedArray = @[@"男",@"女"];
    gender.segmentedControl.tintColor = [UIColor AxcUI_CarrotColor];
    [self settingTitleLabel:gender.titleLabel];
    [rowArray addObject:gender];
    //
    AxcFormItemConfiguration *age = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStylePickUp];
    age.required = YES;                          // 设置为必选
    age.titleLabel.text = @"年龄";
    age.subtitleLabel.text = @"请选择";
    NSMutableArray *arr_M = [NSMutableArray array];
    for (int i = 10; i < 100; i ++) {
        [arr_M addObject:[NSString stringWithFormat:@"%d岁",i]];
    }
    age.selectedArray = arr_M;
    [self settingTitleLabel:age.titleLabel];
    [self settingSubTitleLabel:age.subtitleLabel];
    [rowArray addObject:age];
    // 
    AxcFormItemConfiguration *height = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStylePickUp];
    height.titleLabel.text = @"身高";
    height.required = YES;
    NSMutableArray *arrHeight_M = [NSMutableArray array];
    for (int i = 0; i < 2; i ++) {
        NSMutableArray *arr_IM = [NSMutableArray array];
        for (int j = 100; j < 150; j += 10) {
            [arr_IM addObject:[NSString stringWithFormat:@"%d cm",j]];
        }
        [arrHeight_M addObject:arr_IM];
    }
    height.selectedArray = arrHeight_M;
    height.subtitleLabel.text = height.formatText = @" 至 ";
    [self settingTitleLabel:height.titleLabel];
    [self settingSubTitleLabel:height.subtitleLabel];
    [rowArray addObject:height];
    
    AxcFormItemConfiguration *education = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleActionSheet];
    education.required = YES;
    education.titleLabel.text = @"最高学历";
    education.selectedArray = @[@"高中",@"大专",@"本科",@"研究生",@"硕士"];
    education.subtitleLabel.text = [education.selectedArray firstObject];
    [self settingTitleLabel:education.titleLabel];
    [self settingSubTitleLabel:education.subtitleLabel];
    [rowArray addObject:education];
    sectionC.items = rowArray;

    AxcFormItemSectionConfiguration *sectionC2 = [[AxcFormItemSectionConfiguration alloc] init];
    sectionC2.sectionHeaderTitle = @"工作信息";
    NSMutableArray *rowArray2 = [NSMutableArray array];
    AxcFormItemConfiguration *conpanyName = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleTextInput];
    conpanyName.titleLabel.text = @"公司名称";
    conpanyName.subtitleTextField.placeholder = @"请填写公司名称";
    conpanyName.subtitleLabel.text = @"-";
    [self settingTextField:conpanyName.subtitleTextField];
    [self settingTitleLabel:conpanyName.titleLabel];
    [rowArray2 addObject:conpanyName];
    
    AxcFormItemConfiguration *stateLeaving = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleSwitch];
    stateLeaving.titleLabel.text = @"离职状态";
    stateLeaving.switchControl.tintColor = [UIColor AxcUI_CarrotColor];
    stateLeaving.switchControl.onTintColor = [UIColor AxcUI_CarrotColor];
    [self settingTitleLabel:stateLeaving.titleLabel];
    [rowArray2 addObject:stateLeaving];
    
    AxcFormItemConfiguration *workStartTime = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleDatePickUp];
    workStartTime.titleLabel.text = @"起始时间";
    workStartTime.formatText = @"yyyy-MM-dd";
    workStartTime.subtitleLabel.text = @"-";
    [self settingTitleLabel:workStartTime.titleLabel];
    [self settingSubTitleLabel:workStartTime.subtitleLabel];
    [rowArray2 addObject:workStartTime];
    //
    AxcFormItemConfiguration *workEndTime = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleDatePickUp];
    workEndTime.titleLabel.text = @"终止时间";
    workEndTime.formatText = @"yyyy-MM-dd";
    workEndTime.subtitleLabel.text = @"-";
    [self settingTitleLabel:workEndTime.titleLabel];
    [self settingSubTitleLabel:workEndTime.subtitleLabel];
    [rowArray2 addObject:workEndTime];
    //
    AxcFormItemConfiguration *jobContent = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleContentTextInput];
    jobContent.titleLabel.text = @"工作内容";
    jobContent.initialHeight = 150;
    jobContent.maxInputLength = 120;
    [self settingTitleLabel:jobContent.titleLabel];
    [self settingContentTextView:jobContent.contentTextView];
    [rowArray2 addObject:jobContent];

    sectionC2.items = rowArray2;
    
    AxcFormItemSectionConfiguration *sectionC3 = [[AxcFormItemSectionConfiguration alloc] init];
    sectionC3.sectionHeaderTitle = @"个人说明";
    NSMutableArray *rowArray3 = [NSMutableArray array];
    AxcFormItemConfiguration *personalInterests = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleContentTextInput];
    personalInterests.titleLabel.text = @"个人爱好";
    personalInterests.initialHeight = 150;
    personalInterests.maxInputLength = 120;
    [self settingTitleLabel:personalInterests.titleLabel];
    [self settingContentTextView:personalInterests.contentTextView];
    [rowArray3 addObject:personalInterests];
    
    AxcFormItemConfiguration *personalHonor = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleContentTextInput];
    personalHonor.titleLabel.text = @"个人荣誉";
    personalHonor.initialHeight = 150;
    personalHonor.maxInputLength = 120;
    [self settingTitleLabel:personalHonor.titleLabel];
    [self settingContentTextView:personalHonor.contentTextView];
    personalHonor.cellPartingLineStyle = AxcFormItemConfigurationCellPartingLineStyleNone; // 去除单个Cell分割线
    [rowArray3 addObject:personalHonor];
    
    AxcFormItemConfiguration *otherAttachments = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleSystemPictureSelected];
    otherAttachments.titleLabel.text = @"上传照片";
    otherAttachments.initialHeight = 180;   // 初始高度150
    otherAttachments.pictureSelectNum = 1; // 最大承载
    otherAttachments.imageRowCount = 3; // 一行放3张
    otherAttachments.phothoCellCornerRadius = 5; // 设置Cell的圆角
    otherAttachments.addImagePic = [UIImage imageNamed:@"Add_Image"]; // 添加图片的候选图
    otherAttachments.zlImageActionSheet.configuration.navBarColor = [UIColor AxcUI_CloudColor];
    [self settingTitleLabel:otherAttachments.titleLabel];
    [rowArray3 addObject:otherAttachments];
    
    AxcFormItemConfiguration *projectAttachment = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleLibPictureSelected];
    projectAttachment.titleLabel.text = @"其他附件";
    projectAttachment.initialHeight = 150;   // 初始高度180
    projectAttachment.pictureSelectNum = 8; // 最大8张
    projectAttachment.imageRowCount = 4; // 一行放4张
    [self settingTitleLabel:projectAttachment.titleLabel];
    [rowArray3 addObject:projectAttachment];
    
    sectionC3.items = rowArray3;
    sectionC3.sectionFooterTitle = @"这个是脚标";
    sectionC3.sectionFooterHeight = 30; // 这一组的尾视图高度
    
    [self.formView.formCollectionArray addObject:sectionC];
    [self.formView.formCollectionArray addObject:sectionC2];
    [self.formView.formCollectionArray addObject:sectionC3];
    [self.formView.formTableView reloadData];
}


#pragma mark - UI设置
- (void)settingSubTitleLabel:(UILabel *)label{
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor AxcUI_SilverColor];
    label.textAlignment = NSTextAlignmentRight;
}

- (void)settingTitleLabel:(UILabel *)titleLabel{
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor grayColor];
}

- (void)settingContentTextView:(UITextView *)contentTextView{
    contentTextView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    contentTextView.layer.borderWidth = 0.5;
    contentTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    contentTextView.layer.masksToBounds = YES;
    contentTextView.layer.cornerRadius = 5;
    contentTextView.backgroundColor = [UIColor AxcUI_colorWithHexColor:@"f6f6f6"];
}
- (void)settingTextField:(UITextField *)text{
    text.textColor = [UIColor AxcUI_SilverColor];
    text.axcUI_PlaceholderLabel.textColor = [UIColor AxcUI_CarrotColor];
    text.font = [UIFont systemFontOfSize:14];
    text.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    text.leftViewMode = UITextFieldViewModeAlways; // 设置左边距
    text.layer.borderWidth = 0.5;
    text.layer.borderColor = [[UIColor AxcUI_CloudColor] CGColor];
    text.layer.masksToBounds = YES;
    text.layer.cornerRadius = 5;
}


@end
