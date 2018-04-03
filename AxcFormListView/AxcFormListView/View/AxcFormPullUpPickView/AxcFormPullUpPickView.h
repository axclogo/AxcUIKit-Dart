//
//  AxcFormPullUpPickView.h
//  Fabric_Merchants
//
//  Created by Axc on 2018/3/31.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcFormPullUpView.h"

@interface AxcFormPullUpPickView : AxcFormPullUpView <UIPickerViewDataSource,UIPickerViewDelegate>

// 选项组 支持二维数组和单维数组
@property(nonatomic, strong)NSArray *selectedArray;
// 滚轮
@property(nonatomic, strong)UIPickerView *pickerView;
// 选中的索引
@property(nonatomic, assign)NSInteger selectedIndex;
// 二维数组选中的索引
@property(nonatomic, strong)NSMutableArray <NSNumber *>*selectedIndexs;
// 是否二维数组
- (BOOL )isTwoDimensional;

@end
