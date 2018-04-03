
//
//  AxcCityPickerView.m
//  xiezhi-iOS
//
//  Created by Axc on 2017/11/28.
//  Copyright © 2017年 Axc. All rights reserved.
//

#import "AxcFormPullUpView.h"


@implementation AxcFormPullUpView

- (instancetype)init{
    if (self == [super init]) {
        [self createUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(60);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(60);
    }];
    [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
}


- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] init];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self addSubview:_rightBtn];
    }
    return _rightBtn;
}
- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self addSubview:_leftBtn];
    }
    return _leftBtn;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = kThemeColor;
        
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
