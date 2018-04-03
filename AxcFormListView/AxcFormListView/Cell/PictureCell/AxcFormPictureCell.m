//
//  AxcFormPictureCell.m
//  Fabric_Merchants
//
//  Created by Axc on 2018/4/1.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcFormPictureCell.h"

@implementation AxcFormPictureCell

- (void)awakeFromNib {
    [super awakeFromNib];

    
    [self.delectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_top).offset(-5);
        make.left.mas_equalTo(self.imageView.mas_left).offset(-5);
        make.width.height.mas_equalTo(20);
    }];
}

- (void)setModel:(AxcFormImagesModel *)model{
    _model = model;
    self.imageView.image = _model.imageObj;
    
}

- (UIButton *)delectedBtn{
    if (!_delectedBtn) {
        _delectedBtn = [UIButton new];
        _delectedBtn.hidden = YES;
        _delectedBtn.layer.masksToBounds = YES;
        _delectedBtn.layer.cornerRadius = 10;
        _delectedBtn.backgroundColor = [UIColor redColor];
        [_delectedBtn setTitle:@"-" forState:UIControlStateNormal];
        [_delectedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_delectedBtn];
    }
    return _delectedBtn;
}

@end
