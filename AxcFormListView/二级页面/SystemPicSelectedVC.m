//
//  SystemPicSelectedVC.m
//  AxcFormListView
//
//  Created by Axc on 2018/4/2.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "SystemPicSelectedVC.h"

@interface SystemPicSelectedVC ()

@end

@implementation SystemPicSelectedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}


- (void)createUI{
    self.formView = [[AxcFormListView alloc] initWithFrame:self.view.bounds];
    self.formView.formTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.formView.formTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
    [self.view addSubview:self.formView];
    [self.formView mas_makeConstraints:^(MASConstraintMaker *make) {
        AxcWholeFrameLayout;
    }];
    
    
    
    NSMutableArray *rowArray = [NSMutableArray array];
    // 基础使用 *******************************************************************************************************
    AxcFormItemConfiguration *picClick = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleSystemPictureSelected];
    picClick.titleLabel.text = @"选择照片";
    picClick.initialHeight = 150;   // 初始高度150
    [rowArray addObject:picClick];
    // 以下为自定义样式，API和相关三方库无异
    // 外观设置优化 *******************************************************************************************************
    AxcFormItemConfiguration *picClick1 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleSystemPictureSelected];
    picClick1.required = YES;
    picClick1.titleLabel.text = @"店铺图片";
    picClick1.initialHeight = 250;   // 初始高度250
    picClick1.pictureSelectNum = 2; // 最大承载两张
    picClick1.imageRowCount = 2; // 一行放2张
    picClick1.phothoCellCornerRadius = 10; // 设置Cell的圆角
    picClick1.isMoveSorting = NO;   // 禁止长摁移动排序
    picClick1.addImagePic = [UIImage imageNamed:@"Add_Image"]; // 添加图片的候选图
    picClick1.ksPhotoBrowser.backgroundStyle = KSPhotoBrowserBackgroundStyleBlur;    // 查看图片时候的背景样式
    picClick1.ksPhotoBrowser.pageindicatorStyle = KSPhotoBrowserPageIndicatorStyleText;  // 下方显示数量的模式
    picClick1.cellPartingLineStyle = AxcFormItemConfigurationCellPartingLineStyleNone;
    [rowArray addObject:picClick1];
    /*
     picClick1.ksPhotoBrowser 的相关属性
     @property (nonatomic, assign) KSPhotoBrowserInteractiveDismissalStyle dismissalStyle;
     @property (nonatomic, assign) KSPhotoBrowserBackgroundStyle backgroundStyle;
     @property (nonatomic, assign) KSPhotoBrowserPageIndicatorStyle pageindicatorStyle;
     @property (nonatomic, assign) KSPhotoBrowserImageLoadingStyle loadingStyle;
     */
    //
    AxcFormItemConfiguration *picClick2 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleSystemPictureSelected];
    picClick2.titleLabel.text = @"说说配图";
    picClick2.initialHeight = 180;   // 初始高度180
    picClick2.pictureSelectNum = 9; // 最大承载9张
    picClick2.imageRowCount = 3; // 一行放3张
    picClick2.cellPartingLineStyle = AxcFormItemConfigurationCellPartingLineStyleNone;
    picClick2.backGroundColor = [UIColor groupTableViewBackgroundColor];
    [rowArray addObject:picClick2];
    //
    AxcFormItemConfiguration *picClick3 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleSystemPictureSelected];
    picClick3.titleLabel.text = @"上传点什么吧";
    picClick3.initialHeight = 150;   // 初始高度150
    picClick3.pictureSelectNum = 8; // 最大承载8张
    picClick3.phothoCellCornerRadius = 10; // 设置Cell的圆角
    picClick3.addImagePic = [UIImage imageNamed:@"Add_Image"]; // 添加图片的候选图
    [rowArray addObject:picClick3];
    
    // 1组对象构造器
    AxcFormItemSectionConfiguration *sectionC = [[AxcFormItemSectionConfiguration alloc] init];
    // 所有元素添加进组构造器，成为一组
    sectionC.items = rowArray;
    // 添加一个组到表单
    [self.formView.formCollectionArray addObject:sectionC];
    [self.formView.formTableView reloadData];
}




@end
