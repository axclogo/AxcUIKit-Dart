//
//  AxcFormConfigurationModel.h
//  Fabric_Merchants
//
//  Created by Axc on 2018/3/31.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AxcFormConfigurationModel : NSObject

// 关于Cell的索引
@property(nonatomic, strong)NSIndexPath *indexPath;

// 内容，如果是选择或者开关则为Num类型，subtitle、textView、TextFiled为String类型
@property(nonatomic, strong)id contentObj;

// 是否合法，只有检测到NSString类型的值才会使用正则进行匹配，如果正则字符的长度为0（就是没设置正则匹配），则合法；
// 如果正则长度有（说明需要进行匹配正则）则进行匹配，合法1，不合法0
@property(nonatomic, assign)BOOL isLegal;

// 标题文字，大多用于提示，比方说“您输入的XX不合法”，XX中就代表某个标题不合法
@property(nonatomic, copy)NSString *titleStr;

// 用于记录用的参数，相当于Tag
@property(nonatomic, strong)id mark;

@end
