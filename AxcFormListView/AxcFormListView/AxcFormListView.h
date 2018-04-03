//
//  AxcFormListView.h
//  Fabric_Merchants
//
//  Created by Axc on 2018/3/31.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AxcFormConfigurationModel.h"
#import "AxcFormItemSectionConfiguration.h"


@class AxcFormListView;
@protocol AxcFormListViewDelegate <NSObject >

@optional

// 点击触发后
- (void)AxcFormListView:(AxcFormListView *)axcFormListView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
                  style:(AxcFormItemConfigurationStyle )style;

// 当有一个View被提起的时候
- (void)AxcFormListView:(AxcFormListView *)axcFormListView
              indexPath:(NSIndexPath *)indexPath
             pullUpView:(AxcFormPullUpView *)pullUpView
                  style:(AxcFormItemConfigurationStyle )style;

@end

@interface AxcFormListView : UIView

- (instancetype)initWithStyle:(UITableViewStyle )style;

@property(nonatomic, assign)UITableViewStyle style;
// 列表View
@property(nonatomic, strong)UITableView *formTableView;
// 列表表单组
@property(nonatomic, strong)NSMutableArray <AxcFormItemSectionConfiguration *>*formCollectionArray;
// 代理回调
@property(nonatomic, weak)id <AxcFormListViewDelegate >delegate;

// Get获取所有表单数据(<NSString、Image、NSNumber(BOOL)>)
- (NSArray<NSArray <AxcFormConfigurationModel *>*> *)GetFormListViewAllData;
// 取消模态推出的所有View
- (void)dismiss_pullView;


@end







