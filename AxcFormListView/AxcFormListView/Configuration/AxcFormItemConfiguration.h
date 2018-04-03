//
//  AxcFormItemConfiguration.h
//  Fabric_Merchants
//
//  Created by Axc on 2018/3/31.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcFormBaseCell.h"
// 提起的View视图
#import "AxcFormPullUpDateView.h"
#import "AxcFormPullUpPickView.h"
#import "AxcFormPictureCell.h"
#import <KSPhotoBrowser.h>
#import <ZLPhotoActionSheet.h>

@class AxcFormItemConfiguration;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

typedef NSString *(^numberCharactersFormatting) (NSInteger currentInputLength,NSInteger maxInputLength);//1
typedef void(^numberCharactersMaxCeiling) (AxcUI_Label *label);//1
typedef void(^numberCharactersNormal) (AxcUI_Label *label);//1
typedef void(^clickAddPicBlcok) (AxcFormItemConfiguration *config);//2
typedef void(^clickLookPicBlcok) (KSPhotoBrowser * browser);//3
typedef void(^libSelectImageBlock) (NSArray<UIImage *> * images, NSArray<PHAsset *> *assets, BOOL isOriginal,AxcFormItemConfiguration *config);//4


typedef NS_ENUM(NSInteger, AxcFormItemConfigurationStyle) {
    AxcFormItemConfigurationStyleDefault = 0,            // 默认标题配副标题
    // 文本类
    AxcFormItemConfigurationStyleTextInput,              // 文本输入
    AxcFormItemConfigurationStyleContentTextInput,       // 内容输入
    AxcFormItemConfigurationStyleProportionInput,       // 1:1比例输入 (未实现)
    AxcFormItemConfigurationStyleThreeProportionInput,  // 1:1:1比例输入 (未实现)
    // 选择类
    AxcFormItemConfigurationStyleDatePickUp,            // 拉起时间滚轮选择
    AxcFormItemConfigurationStylePickUp,                // 拉起滚轮选择
    AxcFormItemConfigurationStyleCustomView,            // 拉起自定义View设置
    AxcFormItemConfigurationStyleActionSheet,           // 拉起ActionSheet选择
    AxcFormItemConfigurationStyleAlent,                 // Alent选择
    AxcFormItemConfigurationStyleSegmented,             // Segmented选择
    // 开关类
    AxcFormItemConfigurationStyleSwitch,                // Switch和标题
    // 附件类
    AxcFormItemConfigurationStyleSystemPictureSelected, // 图片/照片选择 系统自带的选择器只能选择1张
    AxcFormItemConfigurationStyleLibPictureSelected,    // 图片/照片选择 三方库组件，支持多选
    // 自定义触发类
    AxcFormItemConfigurationStyleCustomAction,          // 点击后回调
};
// 分割线模式
typedef NS_ENUM(NSInteger, AxcFormItemConfigurationCellPartingLineStyle) {
    AxcFormItemConfigurationCellPartingLineStyleDefult,     // 系统默认
    AxcFormItemConfigurationCellPartingLineStyleFill,       // 左右填满
    AxcFormItemConfigurationCellPartingLineStyleNone,       // 无分割线
};

#pragma mark - 小元素item构造器
@interface AxcFormItemConfiguration :NSObject
// 构建函数
- (instancetype)initWithStyle:(AxcFormItemConfigurationStyle )style;

// Cell类型
@property(nonatomic, assign)AxcFormItemConfigurationStyle cellStyle;
// 点击效果
@property(nonatomic, assign)UITableViewCellSelectionStyle selectionStyle;
// 附带样式
@property(nonatomic, assign)UITableViewCellAccessoryType    accessoryType;
// 分割线模式
@property(nonatomic, assign)AxcFormItemConfigurationCellPartingLineStyle cellPartingLineStyle;
// 是否开启点击后逐渐消失 默认不开启
@property(nonatomic, assign)BOOL isDeselectRow;


// 大标题Label
@property(nonatomic, strong)AxcUI_Label *titleLabel;
// 副标题Label
@property(nonatomic, strong)AxcUI_Label *subtitleLabel;
// 副文本
@property(nonatomic, strong)UITextField *subtitleTextField;
// 文本输入框
@property(nonatomic, strong)UITextView *contentTextView;
// 开关
@property(nonatomic, strong)UISwitch *switchControl;
// 文本字符限制显示label 无限制情况下默认为Hidden
@property(nonatomic, strong)AxcUI_Label *numberCharactersLabel;

// 表单输入字数限制 缺省为0（无限制）
@property (nonatomic, assign) NSInteger maxInputLength;
// 回调的文案设置Block
@property(nonatomic, copy)numberCharactersFormatting numberCharactersFormatting;
// 普通状态设置的回调，有默认值
@property(nonatomic, copy)numberCharactersNormal numberCharactersNormal;
// 当字数抵达上限时的回调
@property(nonatomic, copy)numberCharactersMaxCeiling numberCharactersMaxCeiling;


// 选择器类
// 选项卡
@property(nonatomic, strong)UISegmentedControl *segmentedControl;
// 需要提起的View
@property(nonatomic, strong)AxcFormPullUpDateView *dateView;        // 时间选择
@property(nonatomic, strong)AxcFormPullUpPickView *pickView;        // 滚轮选择
@property(nonatomic, strong)AxcFormPullUpView *customPullUpView;    // 自定义
// 提起的sheet
@property(nonatomic, strong)UIActionSheet *actionSheet;
// 提起的Alent
@property(nonatomic, strong)UIAlertController * alertController;

// 选择使用的数组
@property(nonatomic, strong)NSArray <NSString *>*selectedArray;

// 附件
// 系统照片选择器的实例
@property(nonatomic, strong)UIImagePickerController *imagePickerController;
// 三方库照片选择器的实例
@property(nonatomic, strong)ZLPhotoActionSheet *zlImageActionSheet;
// 三方库照片查看器的实例
@property(nonatomic, strong)KSPhotoBrowser *ksPhotoBrowser;
// 照片展示器
@property(nonatomic, strong)UICollectionView *collectionView;
// 照片展示在Cell的大小
@property(nonatomic, assign)CGSize imageItemSize;
// 默认屏宽占4张
@property(nonatomic, assign)NSInteger imageRowCount;
// 照片选择个数 缺省4张
@property(nonatomic, assign)NSInteger pictureSelectNum;


// 照片Cell的属性设置
// 添加照片的占位图
@property(nonatomic, strong)UIImage *addImagePic;
// 展示照片Cell的圆角
@property(nonatomic, assign)CGFloat phothoCellCornerRadius;
// 是否需要长摁移动排序 默认YES
@property(nonatomic, assign)BOOL isMoveSorting;
// 长摁完成按钮
@property(nonatomic, strong)UIButton *photoCompleteBtn;
// 编辑状态的删除按钮
@property(nonatomic, strong)UIButton *delectedBtn;


// 额外附加属性
// 是否是必填（必选） 默认NO
@property (nonatomic, assign) BOOL required;
// 正则匹配文本
@property(nonatomic, strong)NSString *regularStr;
// 格式化文本
@property(nonatomic, strong)NSString *formatText;
// 背景颜色
@property(nonatomic, strong)UIColor *backGroundColor;
// 初始高度（最开始的高度，自适应内的最低高度）静态
@property(nonatomic, assign)NSInteger initialHeight;
// 控件内所有边距 默认 10
@property(nonatomic, assign)CGFloat cellAllMargin;

/****** 对象类 *******/
// 内容对象 任意cell中的数据都可以通过这个获取 类型可能是 ：
//NSString、NSNumber、NSArray、UIImage、NSDate、NSData （后两者在以后更新中考虑可能会添加）
@property(nonatomic, strong)id contentObj;
/****** 预留值(无默认值，内部无使用) *******/
// 用于记录用的参数，无默认值，内部无使用,相当于Tag 比防说某个表单对应的Key值
@property(nonatomic, strong)id mark;
// 长整型Tag，可以用来遍历，无默认值，内部无使用，和上方参数mark一样，同为预留值
@property(nonatomic, assign)NSInteger tag;








/***************************************************************************************************************************/
// 以下无需设置，内部使用方法 *****内部方法***** *****内部方法***** *****内部方法***** *****内部方法***** *****内部方法***** *****内部方法***** *****内部方法*****
// Cell对象
- (AxcFormBaseCell *)dequeueReusableCellWithTableView:(UITableView *)tableView;
// 弱指针引用TB
@property(nonatomic, weak)UITableView *weakTableView;
// 临时运算高度(动态)
@property(nonatomic, assign)CGFloat temporaryHeight;
// 选好的照片组
@property(nonatomic, strong)NSMutableArray <AxcFormImagesModel *>*images;
// 自己的所在索引
@property(nonatomic, strong)NSIndexPath *selfIndexPath;
// 更新高度
- (void)upLoadCollectionViewHeight;
// 检查是否超出选择
- (BOOL )isBeyondImage;
// 获取真实图片的数量
- (NSInteger )getTrueImgsCount;
// 通知更新内部存储
- (void)valueChange;
// 点击添加图片
@property(nonatomic, strong)clickAddPicBlcok clickAddPicBlcok;
// 点击其他图片，准备查看
@property(nonatomic, strong)clickLookPicBlcok clickLookPicBlcok;
// 三方库发起选中图片
@property(nonatomic, copy)libSelectImageBlock selectImageBlock;

@end
#pragma clang diagnostic pop
