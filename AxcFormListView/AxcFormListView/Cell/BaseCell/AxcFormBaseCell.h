//
//  AxcFormBaseCell.h
//  Fabric_Merchants
//
//  Created by Axc on 2018/3/31.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AxcUI_Label.h"


@interface AxcFormBaseCell : UITableViewCell

// 大标题
@property(nonatomic, strong)AxcUI_Label *titleLabel;
// 副标题Label
@property(nonatomic, strong)AxcUI_Label *subtitleLabel;
// 副文本
@property(nonatomic, strong)UITextField *subtitleTextField;
// 文本输入框
@property(nonatomic, strong)UITextView *contentTextView;
// 开关
@property(nonatomic, strong)UISwitch *switchControl;
// 选项卡
@property(nonatomic, strong)UISegmentedControl *segmentedControl;
// 照片展示器
@property(nonatomic, strong)UICollectionView *collectionView;
// 文本字符限制显示label
@property(nonatomic, strong)AxcUI_Label *numberCharactersLabel;



// 所有边距 10
@property(nonatomic, assign)CGFloat allMargin;
// 是否是必填
@property (nonatomic, assign) BOOL required;
// 必填星号Label
@property(nonatomic, strong)UILabel *mandatoryLabel;
// 左边距
@property(nonatomic, assign)CGFloat leftMargin;
// 长摁完成按钮
@property(nonatomic, strong)UIButton *photoCompleteBtn;
// 表单输入字
@property (nonatomic, assign) NSString *limitStr;


@end
