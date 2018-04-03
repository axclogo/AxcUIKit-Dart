//
//  UIButton+AxcCellButton_IndexPath.m
//  xiezhi-iOS
//
//  Created by Axc on 2018/1/15.
//  Copyright © 2018年 Axc. All rights reserved.
//

#import "UIButton+AxcCellButton_IndexPath.h"
#import <objc/runtime.h>

static NSString * const kindexPath = @"indexPath";

@implementation UIButton (AxcCellButton_IndexPath)

- (void)setIndexPath:(NSIndexPath *)indexPath{
    [self willChangeValueForKey:kindexPath];
    objc_setAssociatedObject(self, &kindexPath,
                             indexPath,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kindexPath];
}

- (NSIndexPath *)indexPath{
    return objc_getAssociatedObject(self, &kindexPath);
}

@end
