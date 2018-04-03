//
//  AxcFormPullUpDateView.m
//  Fabric_Merchants
//
//  Created by Axc on 2018/3/31.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcFormPullUpDateView.h"

@implementation AxcFormPullUpDateView


- (void)createUI{
    [super createUI];
    self.titleLabel.text = @"选择时间";
   
    
    WeakSelf;
    // 选择框
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0.0,0.0,0.0,0.0)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        
        [self addSubview:_datePicker];
    }
    return _datePicker;
}

@end
