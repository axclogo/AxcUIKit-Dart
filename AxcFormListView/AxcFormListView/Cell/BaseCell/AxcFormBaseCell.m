//
//  AxcFormBaseCell.m
//  Fabric_Merchants
//
//  Created by Axc on 2018/3/31.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcFormBaseCell.h"

@implementation AxcFormBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}







- (void)setTitleLabel:(AxcUI_Label *)titleLabel{
    _titleLabel = titleLabel;
    [self addSubview:_titleLabel];
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftMargin);
        make.top.mas_equalTo(self.allMargin);
        make.bottom.mas_equalTo(-self.allMargin);
        make.width.mas_equalTo([_titleLabel.text AxcUI_widthWithStringFont:_titleLabel.font] + 10);
    }];
}
- (void)setSubtitleLabel:(AxcUI_Label *)subtitleLabel{
    _subtitleLabel = subtitleLabel;
    [self addSubview:_subtitleLabel];
    [_subtitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.allMargin);
        make.bottom.mas_equalTo(-self.allMargin);
        if (_titleLabel) {
            make.left.mas_equalTo(self.titleLabel.mas_right).offset(5);
        }else{
            make.left.mas_equalTo(0);
        }
        if (self.accessoryType == UITableViewCellAccessoryNone) {
            make.right.mas_equalTo(-self.allMargin);
        }else{
            make.right.mas_equalTo(-self.allMargin - 30);
        }
    }];
  
}
- (void)setSubtitleTextField:(UITextField *)subtitleTextField{
    _subtitleTextField = subtitleTextField;
    [self addSubview:_subtitleTextField];
    [_subtitleTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-self.allMargin);
        make.top.mas_equalTo(self.allMargin);
        make.bottom.mas_equalTo(-self.allMargin);
        if (_titleLabel) {
            make.left.mas_equalTo(self.titleLabel.mas_right).offset(5);
        }else{
            make.left.mas_equalTo(0);
        }
    }];
    
}
- (void)setContentTextView:(UITextView *)contentTextView{
    _contentTextView = contentTextView;
    // 先更新标题
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftMargin);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo([_titleLabel.text AxcUI_widthWithStringFont:_titleLabel.font] + 10);
        make.height.mas_equalTo([_titleLabel.text AxcUI_heightWithStringFont:_titleLabel.font] + 10);
    }];
    self.mandatoryLabel = nil;
    self.required = self.required; // 重置星号
    [self addSubview:_contentTextView];
    [_contentTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.allMargin);
        make.right.bottom.mas_equalTo(-self.allMargin);
        if (_titleLabel) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
        }else{
            make.top.mas_equalTo(self.allMargin);
        }
    }];
   
}

- (void)setNumberCharactersLabel:(AxcUI_Label *)numberCharactersLabel{
    _numberCharactersLabel = numberCharactersLabel;
    [self addSubview:_numberCharactersLabel];
    [_numberCharactersLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        UIView *view_point = nil;
        if (_contentTextView) {
            view_point = self.contentTextView;
            make.height.mas_equalTo(30);
        }else if (_subtitleTextField){
            view_point = self.subtitleTextField;
            make.top.mas_equalTo(view_point.mas_top).offset(0);
        }
        make.right.mas_equalTo(view_point.mas_right).offset(-self.allMargin);
        make.bottom.mas_equalTo(view_point.mas_bottom).offset(0);
        make.width.mas_equalTo([_numberCharactersLabel.text AxcUI_heightWithStringFont:_numberCharactersLabel.font] + 10);
    }];
}

- (void)setLimitStr:(NSString *)limitStr{
    _limitStr = limitStr;
    self.numberCharactersLabel.text = _limitStr;
    [self.numberCharactersLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat width = [self.numberCharactersLabel.text AxcUI_widthWithStringFont:self.numberCharactersLabel.font] + 10;
        make.width.mas_equalTo(width);
    }];
}

- (void)setSwitchControl:(UISwitch *)switchControl{
    _switchControl = switchControl;
    [self addSubview:_switchControl];
    [_switchControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-self.allMargin);
    }];
}

- (void)setSegmentedControl:(UISegmentedControl *)segmentedControl{
    _segmentedControl = segmentedControl;
    [self addSubview:_segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.allMargin);
        make.bottom.mas_equalTo(-self.allMargin);
        make.right.mas_equalTo(-self.allMargin);
    }];
}
- (void)setCollectionView:(UICollectionView *)collectionView{
    _collectionView = collectionView;
    // 先更新标题
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftMargin);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo([_titleLabel.text AxcUI_widthWithStringFont:_titleLabel.font] + 10);
        make.height.mas_equalTo([_titleLabel.text AxcUI_heightWithStringFont:_titleLabel.font] + 10);
    }];
    self.mandatoryLabel = nil;
    self.required = self.required; // 重置星号
    [self addSubview:_collectionView];
    [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.bottom.mas_equalTo(0);
        if (_titleLabel) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
        }else{
            make.top.mas_equalTo(self.allMargin);
        }
    }];
    [_collectionView reloadData];
}
- (void)setPhotoCompleteBtn:(UIButton *)photoCompleteBtn{
    _photoCompleteBtn = photoCompleteBtn;
    [self addSubview:_photoCompleteBtn];
    [_photoCompleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.collectionView.mas_top).offset(0);
        make.right.mas_equalTo(-self.allMargin);
        if (!_photoCompleteBtn.axcUI_Width) {
            make.width.mas_equalTo(50);
        }else{
            make.width.mas_equalTo(_photoCompleteBtn.axcUI_Width);
        }
    }];
}


- (void)setRequired:(BOOL)required{
    _required = required;
    self.mandatoryLabel.hidden = !_required;
}

- (CGFloat)leftMargin{
    if (!_leftMargin) {
        _leftMargin = self.allMargin;
    }
    return _leftMargin;
}

#pragma mark - 懒加载

- (UILabel *)mandatoryLabel{
    if (!_mandatoryLabel) {
        _mandatoryLabel = [[UILabel alloc] init];
        _mandatoryLabel.text = @"*";
        _mandatoryLabel.textAlignment = NSTextAlignmentCenter;
        _mandatoryLabel.textColor = [UIColor AxcUI_colorWithHexColor:@"E3170D"];
        _mandatoryLabel.font = self.titleLabel.font;
        [self addSubview:_mandatoryLabel];
        [_mandatoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_top).offset(0);
            make.right.mas_equalTo(self.titleLabel.mas_left).offset(-3);
            make.width.mas_equalTo(7);
            make.height.mas_equalTo(self.titleLabel.mas_height);
        }];
    }
    return _mandatoryLabel;
}

@end
