//
//  AxcFormListView.m
//  Fabric_Merchants
//
//  Created by Axc on 2018/3/31.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcFormListView.h"

#import <Photos/Photos.h>

@interface AxcFormListView ()<
UITableViewDelegate
,UITableViewDataSource
,UIActionSheetDelegate
,UINavigationControllerDelegate
,UIImagePickerControllerDelegate

>
// 当前点击的IndexPath
@property(nonatomic, strong)NSIndexPath *clickableIndexPath;

@end
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation AxcFormListView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewStyle )style{
    self = [super init];
    if (self) {
        self.style = style;
    }
    return self;
}


#pragma mark - SETGET

#pragma mark - 代理
// 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.formTableView endEditing:YES];
    WeakSelf;
    AxcFormItemConfiguration *configuration = [self configurationIndexPath:indexPath];
    self.clickableIndexPath = indexPath;
    if (configuration.isDeselectRow) [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(AxcFormListView:didSelectRowAtIndexPath:style:)]) {
        [self.delegate AxcFormListView:weakSelf didSelectRowAtIndexPath:indexPath style:configuration.cellStyle];
    }
    AxcFormPullUpView *pullUpView = nil;
    // 此处预留固定触发库
    switch (configuration.cellStyle) {
        case AxcFormItemConfigurationStyleDatePickUp:{ // 拉起时间滚轮选择
            pullUpView = configuration.dateView;
            [configuration.dateView.rightBtn addTarget:weakSelf
                                                action:@selector(selected_dateView)
                                      forControlEvents:UIControlEventTouchUpInside];
            [weakSelf pullUpViewLogic:pullUpView indexPath:indexPath style:configuration.cellStyle];
        }break;
        case AxcFormItemConfigurationStylePickUp:{ // 拉起滚轮选择
            pullUpView = configuration.pickView;
            [configuration.pickView.rightBtn addTarget:weakSelf
                                                action:@selector(selected_pickView)
                                      forControlEvents:UIControlEventTouchUpInside];
            [weakSelf pullUpViewLogic:pullUpView indexPath:indexPath style:configuration.cellStyle];
        }break;
        case AxcFormItemConfigurationStyleCustomView:{ // 拉起自定义
            pullUpView = configuration.customPullUpView;
            [weakSelf pullUpViewLogic:pullUpView indexPath:indexPath style:configuration.cellStyle];
        }break;
        case AxcFormItemConfigurationStyleActionSheet:{ // 拉起Sheet
            if (!configuration.actionSheet.delegate)
                configuration.actionSheet.delegate = weakSelf;
            configuration.actionSheet.tag = 5324;
            [configuration.actionSheet showInView:weakSelf];
        }break;
        case AxcFormItemConfigurationStyleAlent:{ // 拉起Alent
            [[self axcUI_superViewController] presentViewController:configuration.alertController animated:YES completion:nil];
        }break;
        case AxcFormItemConfigurationStyleSystemPictureSelected:{ // 选择照片
            if ([configuration isBeyondImage]) { // 没到上线
                [weakSelf Axc_popClickImagePickerSheet];
            }else{
                [weakSelf Axc_popWarningAlentWithMsg:[NSString stringWithFormat:@"只能选择%ld张照片！",configuration.imageRowCount]];
            }
        }break;
        case AxcFormItemConfigurationStyleLibPictureSelected:{ // 选择照片 三方库
            [configuration.zlImageActionSheet showPreviewAnimated:YES sender:weakSelf.axcUI_superViewController];
          
        }break;
        default: break;
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    [self addImageWithCell:@[image]];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
// 向Cell里添加图片
- (void)addImageWithCell:(NSArray <UIImage *>*)images{
    AxcFormItemConfiguration *configuration = [self configurationIndexPath:self.clickableIndexPath];
    [configuration.images removeObjectAtIndex:configuration.images.count-1];
    [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AxcFormImagesModel *model = [AxcFormImagesModel new];
        model.imageObj = obj;
        [configuration.images addObject:model];
    }];
    if ([configuration isBeyondImage]) { // 没到上线
        AxcFormImagesModel *addModel = [AxcFormImagesModel new];
        addModel.imageShowType = 1;
        addModel.imageObj = configuration.addImagePic;
        [configuration.images addObject:addModel];
    }
    [configuration.collectionView reloadData];
    [configuration upLoadCollectionViewHeight]; // 更新检查高度
    [configuration valueChange];    // 更新存储Copy的只针对像
}

#pragma mark - 其他组件代理回调区
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    AxcFormItemConfiguration *configuration = [self configurationIndexPath:self.clickableIndexPath];
    if (actionSheet.tag == 5324) {
        if (buttonIndex)  configuration.subtitleLabel.text = configuration.selectedArray[buttonIndex-1];
    }else if (actionSheet.tag == 5325){
        if (buttonIndex == 0 || buttonIndex == 1) {
            if (buttonIndex == 1) { // 拍照
                configuration.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            }else if (buttonIndex == 0){  // 相册
                configuration.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            [self pushImageickerController:configuration];
        }
    }else{}
}
#pragma mark - tableView代理回调区
// Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AxcFormItemConfiguration *configuration =  [self configurationIndexPath:indexPath];
    configuration.selfIndexPath = indexPath;
    WeakSelf;
    if (configuration.cellStyle == AxcFormItemConfigurationStyleSystemPictureSelected ) {
        configuration.clickAddPicBlcok = ^(AxcFormItemConfiguration *config) {
            weakSelf.clickableIndexPath = config.selfIndexPath;
            [weakSelf Axc_popClickImagePickerSheet];
        };
        configuration.clickLookPicBlcok = ^(KSPhotoBrowser *browser) {
            [browser showFromViewController:weakSelf.axcUI_superViewController];
        };
    }else if (configuration.cellStyle == AxcFormItemConfigurationStyleLibPictureSelected){ // 三方库选择
        configuration.selectImageBlock = ^(NSArray<UIImage *> *images, NSArray<PHAsset *> *assets, BOOL isOriginal, AxcFormItemConfiguration *config) {
            if (configuration.pictureSelectNum < images.count + [configuration getTrueImgsCount]) { // 超出了
                [self Axc_popWarningAlentWithMsg:[NSString stringWithFormat:@"最多只能选取%ld张图片！",config.pictureSelectNum]];
                // 这个三方库没有公开回弹属性，只能通过消息发送执行了。。。
                [config.zlImageActionSheet performSelector:NSSelectorFromString(@"hide")];
            }else{
                [weakSelf addImageWithCell:images];
            }
        };
        configuration.clickAddPicBlcok = ^(AxcFormItemConfiguration *config) {
            weakSelf.clickableIndexPath = config.selfIndexPath;
            [config.zlImageActionSheet showPreviewAnimated:YES sender:weakSelf.axcUI_superViewController];
        };
        configuration.clickLookPicBlcok = ^(KSPhotoBrowser *browser) { // 点击cell查看
            [browser showFromViewController:weakSelf.axcUI_superViewController];
        };
    }
    return [configuration dequeueReusableCellWithTableView:tableView]; // 使用固定的数组记录所有控件对象，免去tableView的复用影响
}
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{return self.formCollectionArray.count;}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{return [self.formCollectionArray objectAtIndex:section].items.count;}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[self.formCollectionArray objectAtIndex:indexPath.section].items objectAtIndex:indexPath.row].temporaryHeight;}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AxcFormItemSectionConfiguration *config = [self.formCollectionArray objectAtIndex:section];
    if (config.sectionHeaderView) {
        return config.sectionHeaderView;
    }
    return nil;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    AxcFormItemSectionConfiguration *config = [self.formCollectionArray objectAtIndex:section];
    if (config.sectionHeaderTitle) {
        return config.sectionHeaderTitle;
    }
    return nil;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    AxcFormItemSectionConfiguration *config = [self.formCollectionArray objectAtIndex:section];
    return config.sectionHeaderHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    AxcFormItemSectionConfiguration *config = [self.formCollectionArray objectAtIndex:section];
    if (config.sectionFooterView) {
        return config.sectionFooterView;
    }
    return nil;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    AxcFormItemSectionConfiguration *config = [self.formCollectionArray objectAtIndex:section];
    if (config.sectionFooterTitle) {
        return config.sectionFooterTitle;
    }
    return nil;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    AxcFormItemSectionConfiguration *config = [self.formCollectionArray objectAtIndex:section];
    return config.sectionFooterHeight;
}

#pragma mark - 拉起选择器函数区
- (void)pushImageickerController:(AxcFormItemConfiguration *)configuration{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) { // 判断权限
        if (status == PHAuthorizationStatusNotDetermined || status == PHAuthorizationStatusAuthorized) {
            //使用模态呈现相册
            configuration.imagePickerController.delegate = self;
            [self.axcUI_superViewController presentViewController:configuration.imagePickerController
                                                         animated:YES completion:nil];
        }else{
            [self Axc_popWarningAlentWithMsg:@"请在系统设置中开启相册授权"];
        }
    }];
}
- (void)pullUpViewLogic:(AxcFormPullUpView *)pullUpView indexPath:(NSIndexPath *)indexPath style:(AxcFormItemConfigurationStyle )style;{
    pullUpView.indexPath = indexPath;     WeakSelf;// 标记索引
    [pullUpView.leftBtn addTarget:self action:@selector(dismiss_pullView) forControlEvents:UIControlEventTouchUpInside];
    if ([self.delegate respondsToSelector:@selector(AxcFormListView:indexPath:pullUpView:style:)]) {
        [self.delegate AxcFormListView:weakSelf indexPath:indexPath pullUpView:pullUpView style:style];
    }
    [[self axcUI_superViewController] AxcUI_presentSemiView:pullUpView withOptions:
     @{AxcUISemiModalOptionKeys.axcUI_transitionStyle:@(AxcSemiModalTransitionStyleSlideUp),
       AxcUISemiModalOptionKeys.axcUI_pushParentBack:@(0)
       }];
}

- (void)selected_dateView{  // 时间选择器
    AxcFormItemConfiguration *configuration = [self configurationIndexPath:self.clickableIndexPath];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = configuration.formatText;
    configuration.subtitleLabel.text = [dateFormatter stringFromDate:configuration.dateView.datePicker.date];
    [self.formTableView reloadData];
    [self dismiss_pullView];
}
- (void)selected_pickView{  // 滚轮选择器
    NSMutableString *valueStr = [NSMutableString string];
    AxcFormItemConfiguration *configuration = [self configurationIndexPath:self.clickableIndexPath];
    NSArray *seleArr = configuration.selectedArray;
    if ([configuration.pickView isTwoDimensional]) { // 如果是二维数组则转换多组
        [configuration.pickView.selectedIndexs enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx) {
                if (!configuration.formatText.length) {
                    configuration.formatText = @"-"; } // 默认使用作为格式化依据
                [valueStr appendString:configuration.formatText];
            }
            NSArray *rowArr = seleArr[idx];
            [valueStr appendString:rowArr[obj.integerValue]];
        }];
    }else{
        valueStr = seleArr[configuration.pickView.selectedIndex];
    }
    configuration.subtitleLabel.text = valueStr;
    [self.formTableView reloadData];
    [self dismiss_pullView];
}

- (void)dismiss_pullView{ // 点击取消
    [[self axcUI_superViewController] AxcUI_dismissSemiModalView];
}
#pragma mark - 全局复用函数
- (AxcFormItemConfiguration *)configurationIndexPath:(NSIndexPath *)indexPath{
    return [[self.formCollectionArray objectAtIndex:indexPath.section].items
            objectAtIndex:indexPath.row];
}
- (void)Axc_popWarningAlentWithMsg:(NSString *)msg{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                          message:msg
                                                   preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
                                                     style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    [self.axcUI_superViewController presentViewController:alertController animated:YES completion:nil];
}
- (void)Axc_popClickImagePickerSheet{
    UIActionSheet *actionSheet  = [[UIActionSheet alloc] initWithTitle:@"选取图片"
                                                delegate:self
                                       cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:@"相册",@"拍照",nil];
    actionSheet.tag = 5325;
    [actionSheet showInView:self];
}

// 获取列表表单中的所有数据
- (NSArray<NSArray <AxcFormConfigurationModel *>*> *)GetFormListViewAllData{
    NSMutableArray *dataArray_i = [NSMutableArray array];
    [self.formCollectionArray enumerateObjectsUsingBlock:^(AxcFormItemSectionConfiguration * _Nonnull section_obj,
                                                           NSUInteger section_idx,
                                                           BOOL * _Nonnull section_stop) {
        NSMutableArray *dataArray_j = [NSMutableArray array];
        [section_obj.items enumerateObjectsUsingBlock:^(AxcFormItemConfiguration * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            AxcFormConfigurationModel *model = [AxcFormConfigurationModel new];
            model.indexPath = [NSIndexPath indexPathForRow:idx inSection:section_idx];
            model.titleStr = obj.titleLabel.text;
            model.contentObj = obj.contentObj;
            model.isLegal = YES; // 默认都是是
            if (obj.regularStr.length) { // 模型中有设置正则匹配文本
                if ([obj.contentObj isKindOfClass:[NSString class]]) { // 是字符，可以进行正则匹配
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",obj.regularStr];
                    NSString *value = [NSString stringWithFormat:@"%@",obj.contentObj];
                    model.isLegal = [predicate evaluateWithObject:value];
                }else if ([obj.contentObj isKindOfClass:[NSNull class]]){
                    model.isLegal = NO; // 有设置正则但是有没有数据
                }
            }
            if (obj.required && [obj.contentObj isKindOfClass:[NSNull class]]) { // 如果必填却没有填写
                model.isLegal = NO;
            }
            [dataArray_j addObject:model];
        }];
        [dataArray_i addObject:dataArray_j];
    }];
    return dataArray_i;
}

- (void)createUI{
    [self addSubview:self.formTableView];
    [self.formTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        AxcWholeFrameLayout;
    }];
}
#pragma mark - 懒加载
- (UITableView *)createTableViewWithStyle:(UITableViewStyle)style{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.frame style:style];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    return tableView;
}
- (UITableView *)formTableView{
    if (!_formTableView) {
        _formTableView = [self createTableViewWithStyle:self.style];
    }
    return _formTableView;
}
- (NSMutableArray<AxcFormItemSectionConfiguration *> *)formCollectionArray{
    if (!_formCollectionArray) {
        _formCollectionArray = [NSMutableArray array];
    }
    return _formCollectionArray;
}


@end


