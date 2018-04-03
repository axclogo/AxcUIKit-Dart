//
//  AxcCityPickerView.h
//  xiezhi-iOS
//
//  Created by Axc on 2017/11/28.
//  Copyright © 2017年 Axc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AxcFormPullUpView : UIView


@property(nonatomic, strong)UILabel *titleLabel;

@property(nonatomic, strong)UIButton *leftBtn;
@property(nonatomic, strong)UIButton *rightBtn;

// 索引
@property(nonatomic, strong)NSIndexPath *indexPath;

- (void)createUI;

@end
