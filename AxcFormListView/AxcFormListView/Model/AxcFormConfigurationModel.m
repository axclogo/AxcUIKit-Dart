//
//  AxcFormConfigurationModel.m
//  Fabric_Merchants
//
//  Created by Axc on 2018/3/31.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcFormConfigurationModel.h"

@implementation AxcFormConfigurationModel

// 方便打印
-(NSString *)description{
    return [NSString stringWithFormat:@"\n\n%@:%@\n合法：%@\n索引%@\n\n",self.titleStr,self.contentObj,self.isLegal?@"是":@"否",self.indexPath];
}

@end
