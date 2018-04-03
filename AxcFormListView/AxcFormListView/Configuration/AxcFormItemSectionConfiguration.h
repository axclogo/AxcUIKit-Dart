//
//  AxcFormItemSectionConfiguration.h
//  Fabric_Merchants
//
//  Created by Axc on 2018/3/31.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AxcFormItemConfiguration.h"

#pragma mark - 组元素构造器
@interface AxcFormItemSectionConfiguration :NSObject

// 使用tableView系统自带的头角标
@property(nonatomic, strong)NSString *sectionHeaderTitle;
@property(nonatomic, strong)NSString *sectionFooterTitle;

// 自定义的头脚
@property(nonatomic, strong)UIView *sectionHeaderView;
@property(nonatomic, strong)UIView *sectionFooterView;
// 头脚高度
@property(nonatomic, assign)CGFloat sectionHeaderHeight;
@property(nonatomic, assign)CGFloat sectionFooterHeight;


@property(nonatomic, strong)NSArray <AxcFormItemConfiguration *>*items;

@end
