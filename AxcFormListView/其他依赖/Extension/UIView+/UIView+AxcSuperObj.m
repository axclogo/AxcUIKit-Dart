//
//  UIView+AxcSuperObj.m
//  Fabric_Merchants
//
//  Created by Axc on 2018/3/30.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "UIView+AxcSuperObj.h"

@implementation UIView (AxcSuperObj)

#pragma mark 获取当前View所在的ViewController
- (UIViewController *)axcUI_superViewController{
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    return nil;
}


@end
