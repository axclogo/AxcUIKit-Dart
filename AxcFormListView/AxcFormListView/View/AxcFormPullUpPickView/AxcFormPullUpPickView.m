//
//  AxcFormPullUpPickView.m
//  Fabric_Merchants
//
//  Created by Axc on 2018/3/31.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcFormPullUpPickView.h"

@implementation AxcFormPullUpPickView

- (void)createUI{
    [super createUI];
    self.titleLabel.text = @"选择";
    WeakSelf;
    // 选择框
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)setSelectedArray:(NSArray *)selectedArray{
    _selectedArray = selectedArray;

    if ([self isTwoDimensional]) {
        if (!self.selectedIndexs.count) {
            [_selectedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.selectedIndexs addObject:@(0)];
            }];
        }
    }else{
        self.selectedIndex = 0;
    }
    [self.pickerView reloadAllComponents];
}
//selectedIndexPaths
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if ([self isTwoDimensional]) {
        [self.selectedIndexs replaceObjectAtIndex:component withObject:@(row)];
    }else{
        self.selectedIndex = row;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if ([self isTwoDimensional]) {
        return self.selectedArray.count;
    }
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([self isTwoDimensional]) {
        NSArray *arr = self.selectedArray[component];
        return arr.count;
    }
    return self.selectedArray.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if ([self isTwoDimensional]) {
        NSArray *arr = self.selectedArray[component];
        NSObject *obj = arr[row];
        return obj.description;
    }
    NSObject *obj = self.selectedArray[row];
    return obj.description;
}


- (BOOL )isTwoDimensional{
    BOOL is = NO;
    if (self.selectedArray.count > 0) { // 如果是二维数组则转换多组
        id obj = self.selectedArray.firstObject;
        is = [obj isKindOfClass:[NSArray class]];
    }
    return is;
}

- (NSMutableArray<NSNumber *> *)selectedIndexs{
    if (!_selectedIndexs) {
        _selectedIndexs = [NSMutableArray array];
    }
    return _selectedIndexs;
}
- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [UIPickerView new];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [self addSubview:_pickerView];
    }
    return _pickerView;
}

@end

