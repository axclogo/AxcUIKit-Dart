//
//  LibPicSelectedVC.m
//  AxcFormListView
//
//  Created by Axc on 2018/4/2.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "LibPicSelectedVC.h"

@interface LibPicSelectedVC ()

@end

@implementation LibPicSelectedVC

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
    AxcFormItemConfiguration *picClick = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleLibPictureSelected];
    picClick.titleLabel.text = @"选择照片";
    picClick.initialHeight = 150;   // 初始高度150
    [rowArray addObject:picClick];
    // 以下为自定义样式，API和相关三方库无异
    // 外观设置优化 *******************************************************************************************************
    AxcFormItemConfiguration *picClick1 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleLibPictureSelected];
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
    picClick1.zlImageActionSheet.configuration.cellCornerRadio = 10; // 选择预览时的弧度
    [rowArray addObject:picClick1];
    /*
     picClick1.ksPhotoBrowser 的相关属性
     @property (nonatomic, assign) KSPhotoBrowserInteractiveDismissalStyle dismissalStyle;
     @property (nonatomic, assign) KSPhotoBrowserBackgroundStyle backgroundStyle;
     @property (nonatomic, assign) KSPhotoBrowserPageIndicatorStyle pageindicatorStyle;
     @property (nonatomic, assign) KSPhotoBrowserImageLoadingStyle loadingStyle;
     */
    //
    AxcFormItemConfiguration *picClick2 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleLibPictureSelected];
    picClick2.titleLabel.text = @"说说配图";
    picClick2.initialHeight = 180;   // 初始高度180
    picClick2.pictureSelectNum = 9; // 最大承载9张
    picClick2.imageRowCount = 3; // 一行放3张
    picClick2.cellPartingLineStyle = AxcFormItemConfigurationCellPartingLineStyleNone;
    picClick2.backGroundColor = [UIColor groupTableViewBackgroundColor];
    [rowArray addObject:picClick2];
    //
    AxcFormItemConfiguration *picClick3 = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleLibPictureSelected];
    picClick3.titleLabel.text = @"上传点什么吧";
    picClick3.initialHeight = 150;   // 初始高度150
    picClick3.pictureSelectNum = 8; // 最大承载8张
    picClick3.phothoCellCornerRadius = 10; // 设置Cell的圆角
    picClick3.addImagePic = [UIImage imageNamed:@"Add_Image"]; // 添加图片的候选图
    picClick3.zlImageActionSheet.configuration.selectedMaskColor = [UIColor purpleColor];
    picClick3.zlImageActionSheet.configuration.navBarColor = [UIColor orangeColor];
    picClick3.zlImageActionSheet.configuration.navTitleColor = [UIColor blackColor];
    picClick3.zlImageActionSheet.configuration.bottomBtnsNormalTitleColor = kRGB(80, 160, 100);
    picClick3.zlImageActionSheet.configuration.bottomBtnsDisableBgColor = kRGB(190, 30, 90);
    picClick3.zlImageActionSheet.configuration.bottomViewBgColor = [UIColor blackColor];
    picClick3.zlImageActionSheet.configuration.statusBarStyle = UIStatusBarStyleDefault;
    [rowArray addObject:picClick3];
    
    /*
     picClick1.zlImageActionSheet 的相关设置属性
     //以下参数为自定义参数，均可不设置，有默认值
     picClick1.zlImageActionSheet.configuration.sortAscending = self.sortSegment.selectedSegmentIndex==0;
     picClick1.zlImageActionSheet.configuration.allowSelectImage = self.selImageSwitch.isOn;
     picClick1.zlImageActionSheet.configuration.allowSelectGif = self.selGifSwitch.isOn;
     picClick1.zlImageActionSheet.configuration.allowSelectVideo = self.selVideoSwitch.isOn;
     picClick1.zlImageActionSheet.configuration.allowSelectLivePhoto = self.selLivePhotoSwitch.isOn;
     picClick1.zlImageActionSheet.configuration.allowForceTouch = self.allowForceTouchSwitch.isOn;
     picClick1.zlImageActionSheet.configuration.allowEditImage = self.allowEditSwitch.isOn;
     picClick1.zlImageActionSheet.configuration.allowEditVideo = self.allowEditVideoSwitch.isOn;
     picClick1.zlImageActionSheet.configuration.allowSlideSelect = self.allowSlideSelectSwitch.isOn;
     picClick1.zlImageActionSheet.configuration.allowMixSelect = self.mixSelectSwitch.isOn;
     picClick1.zlImageActionSheet.configuration.allowDragSelect = self.allowDragSelectSwitch.isOn;
     //设置相册内部显示拍照按钮
     picClick1.zlImageActionSheet.configuration.allowTakePhotoInLibrary = self.takePhotoInLibrarySwitch.isOn;
     //设置在内部拍照按钮上实时显示相机俘获画面
     picClick1.zlImageActionSheet.configuration.showCaptureImageOnTakePhotoBtn = self.showCaptureImageSwitch.isOn;
     //设置照片最大预览数
     picClick1.zlImageActionSheet.configuration.maxPreviewCount = self.previewTextField.text.integerValue;
     //设置照片最大选择数
     picClick1.zlImageActionSheet.configuration.maxSelectCount = self.maxSelCountTextField.text.integerValue;
     //设置允许选择的视频最大时长
     picClick1.zlImageActionSheet.configuration.maxVideoDuration = self.maxVideoDurationTextField.text.integerValue;
     //设置照片cell弧度
     picClick1.zlImageActionSheet.configuration.cellCornerRadio = self.cornerRadioTextField.text.floatValue;
     //单选模式是否显示选择按钮
     //    picClick1.zlImageActionSheet.configuration.showSelectBtn = YES;
     //是否在选择图片后直接进入编辑界面
     picClick1.zlImageActionSheet.configuration.editAfterSelectThumbnailImage = self.editAfterSelectImageSwitch.isOn;
     //是否保存编辑后的图片
     //    picClick1.zlImageActionSheet.configuration.saveNewImageAfterEdit = NO;
     //设置编辑比例
     //    picClick1.zlImageActionSheet.configuration.clipRatios = @[GetClipRatio(7, 1)];
     //是否在已选择照片上显示遮罩层
     picClick1.zlImageActionSheet.configuration.showSelectedMask = self.maskSwitch.isOn;
     //颜色，状态栏样式
         picClick1.zlImageActionSheet.configuration.selectedMaskColor = [UIColor purpleColor];
         picClick1.zlImageActionSheet.configuration.navBarColor = [UIColor orangeColor];
         picClick1.zlImageActionSheet.configuration.navTitleColor = [UIColor blackColor];
         picClick1.zlImageActionSheet.configuration.bottomBtnsNormalTitleColor = kRGB(80, 160, 100);
         picClick1.zlImageActionSheet.configuration.bottomBtnsDisableBgColor = kRGB(190, 30, 90);
         picClick1.zlImageActionSheet.configuration.bottomViewBgColor = [UIColor blackColor];
         picClick1.zlImageActionSheet.configuration.statusBarStyle = UIStatusBarStyleDefault;
     //是否允许框架解析图片
     picClick1.zlImageActionSheet.configuration.shouldAnialysisAsset = self.allowAnialysisAssetSwitch.isOn;
     //框架语言
     picClick1.zlImageActionSheet.configuration.languageType = self.languageSegment.selectedSegmentIndex;
     //自定义多语言
     //    picClick1.zlImageActionSheet.configuration.customLanguageKeyValue = @{@"ZLPhotoBrowserCameraText": @"没错，我就是一个相机"};
     
     //是否使用系统相机
     //    picClick1.zlImageActionSheet.configuration.useSystemCamera = YES;
     //    picClick1.zlImageActionSheet.configuration.sessionPreset = ZLCaptureSessionPreset1920x1080;
     //    picClick1.zlImageActionSheet.configuration.exportVideoType = ZLExportVideoTypeMp4;
     //    picClick1.zlImageActionSheet.configuration.allowRecordVideo = NO;
     */
    
    // 1组对象构造器
    AxcFormItemSectionConfiguration *sectionC = [[AxcFormItemSectionConfiguration alloc] init];
    // 所有元素添加进组构造器，成为一组
    sectionC.items = rowArray;
    // 添加一个组到表单
    [self.formView.formCollectionArray addObject:sectionC];
    [self.formView.formTableView reloadData];
}

@end
