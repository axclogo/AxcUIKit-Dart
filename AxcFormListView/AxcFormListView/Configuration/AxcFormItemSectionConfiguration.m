//
//  AxcFormItemSectionConfiguration.m
//  Fabric_Merchants
//
//  Created by Axc on 2018/3/31.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcFormItemSectionConfiguration.h"

@implementation AxcFormItemSectionConfiguration

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sectionHeaderHeight = 30;
        self.sectionFooterHeight = CGFLOAT_MIN;
    }
    return self;
}

@end
