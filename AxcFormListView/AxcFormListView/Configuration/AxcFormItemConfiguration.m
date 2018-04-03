//
//  AxcFormItemConfiguration.m
//  Fabric_Merchants
//
//  Created by Axc on 2018/3/31.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "AxcFormItemConfiguration.h"

@interface AxcFormItemConfiguration ()<
UICollectionViewDataSource
,UICollectionViewDelegate
,KSPhotoBrowserDelegate

>
// 自己所持有Cell的指针
@property(nonatomic, strong)AxcFormBaseCell *holdCell;
// Cell之前的分割线尺寸
@property(nonatomic, assign)UIEdgeInsets separatorInset;
@property(nonatomic, assign)UIEdgeInsets layoutMargins;
@property(nonatomic, assign)BOOL isSetInset;
// 长摁时候的模型承载
@property(nonatomic, strong)AxcFormImagesModel *mobileModel;
// 文本内容的控制字
@property(nonatomic, copy)NSString *contentStrPoint;
@end


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"


@implementation AxcFormItemConfiguration
- (instancetype)initWithStyle:(AxcFormItemConfigurationStyle )style{
    self = [super init];
    if (self){
        [self settingInitial];
        self.cellStyle = style;
    }
    return self;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self settingInitial];
    }
    return self;
}
#pragma mark - 预设初始值
- (void)settingInitial{
    self.cellStyle = AxcFormItemConfigurationStyleDefault; // 默认状态
    self.initialHeight = 50; // 初始高度默认50
    self.isSetInset = NO;   // 单次执行分割线操作
    self.pictureSelectNum = 4; // 照片选择默认4张
    self.maxInputLength = 0;   // 文字限制无
    self.imageRowCount = 4;  // 一排4张图
    self.pictureSelectNum = 4; // 默认4张图
    self.addImagePic = [UIImage imageNamed:@"AxcFormListView.bundle/AxcFormList_AddImage.png"]; // 默认添加图
    self.isMoveSorting = YES; // 支持长摁排序
}
#pragma mark - SETGET
- (void)setInitialHeight:(NSInteger)initialHeight{
    _initialHeight = initialHeight;
    self.temporaryHeight = _initialHeight;
}

#pragma mark - 函数
- (AxcFormBaseCell *)dequeueReusableCellWithTableView:(UITableView *)tableView{
    self.weakTableView = tableView;
    Class class = NSClassFromString(@"AxcFormBaseCell");
    AxcFormBaseCell *cell = [[class alloc] init];
    self.holdCell = cell;
    
    cell.backgroundColor = self.backGroundColor;
    cell.selectionStyle = self.selectionStyle;
    cell.accessoryType = self.accessoryType;
    
    cell.subtitleLabel.hidden = YES;
    cell.subtitleTextField.hidden = YES;
    cell.contentTextView.hidden = YES;
    cell.switchControl.hidden = YES;
    cell.segmentedControl.hidden = YES;
    cell.collectionView.hidden = YES;

    cell.allMargin = self.cellAllMargin;    // 间距
    if (self.required)  cell.leftMargin += 10;
    cell.titleLabel = self.titleLabel;      // 大标题
    cell.required = self.required;          // 必选
    
    switch (self.cellStyle) {
        case AxcFormItemConfigurationStyleDefault:{               // 默认标题配副标题
            cell.subtitleLabel.hidden = NO;
            cell.subtitleLabel = self.subtitleLabel;
        }break;
            // 文本类
        case AxcFormItemConfigurationStyleTextInput:{              // 文本输入
            cell.subtitleTextField.hidden = NO;
            cell.subtitleTextField = self.subtitleTextField;
            cell.numberCharactersLabel = self.numberCharactersLabel;
            self.contentStrPoint = self.contentStrPoint; // 自执行Set
        }break;
        case AxcFormItemConfigurationStyleContentTextInput:{       // 内容输入
            cell.contentTextView.hidden = NO;
            cell.contentTextView = self.contentTextView;
            cell.numberCharactersLabel = self.numberCharactersLabel;
            self.contentStrPoint = self.contentStrPoint; // 自执行Set
        }break;
        case AxcFormItemConfigurationStyleProportionInput:{        // 1:1比例输入
            
        }break;
        case AxcFormItemConfigurationStyleThreeProportionInput:{   // 1:1:1比例输入
            
        }break;
            // 选择类
        case AxcFormItemConfigurationStyleDatePickUp:{             // 拉起时间滚轮选择
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.subtitleLabel.hidden = NO;
            cell.subtitleLabel = self.subtitleLabel;
        }break;
        case AxcFormItemConfigurationStylePickUp:{                 // 拉起滚轮选择
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.subtitleLabel.hidden = NO;
            cell.subtitleLabel = self.subtitleLabel;
        }break;
        case AxcFormItemConfigurationStyleActionSheet:{             // 拉起ActionSheet选择
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.subtitleLabel.hidden = NO;
            cell.subtitleLabel = self.subtitleLabel;
        }break;
        case AxcFormItemConfigurationStyleCustomView:{             // 拉起自定义View选择
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.subtitleLabel.hidden = NO;
            cell.subtitleLabel = self.subtitleLabel;
        }break;
        case AxcFormItemConfigurationStyleAlent:{                  // Alent选择
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.subtitleLabel.hidden = NO;
            cell.subtitleLabel = self.subtitleLabel;
        }break;
        case AxcFormItemConfigurationStyleSegmented:{              // Segmented选择
            cell.segmentedControl.hidden = NO;
            cell.segmentedControl = self.segmentedControl;
        }break;
            // 开关类
        case AxcFormItemConfigurationStyleSwitch:{                 // Switch和标题
            cell.switchControl.hidden = NO;
            cell.switchControl = self.switchControl;
        }break;
            // 附件类
        case AxcFormItemConfigurationStyleSystemPictureSelected:{        // 图片/照片选择
            cell.collectionView.hidden = NO;
            cell.collectionView = self.collectionView;
            cell.photoCompleteBtn = self.photoCompleteBtn;
            cell.collectionView.backgroundColor = self.backGroundColor;
        }break;
        case AxcFormItemConfigurationStyleLibPictureSelected:{        // 图片/照片选择 三方库
            cell.collectionView.hidden = NO;
            cell.collectionView = self.collectionView;
            cell.photoCompleteBtn = self.photoCompleteBtn;
            cell.collectionView.backgroundColor = self.backGroundColor;
        }break;
            // 自定义触发类
        case AxcFormItemConfigurationStyleCustomAction:{           // 点击后回调
            cell.subtitleLabel.hidden = NO;
            cell.subtitleLabel = self.subtitleLabel;
        }break;
        default: break;
    }
    // 设置分割线
    if (!self.isSetInset) {
        self.separatorInset = cell.separatorInset;
        self.layoutMargins = cell.layoutMargins;
        self.isSetInset = YES; // 唯一一次执行控制参
    }
    cell.preservesSuperviewLayoutMargins = NO;
    switch (self.cellPartingLineStyle) {
        case AxcFormItemConfigurationCellPartingLineStyleDefult:{
            cell.separatorInset = self.separatorInset;
            cell.layoutMargins = self.layoutMargins;
        }break;
        case AxcFormItemConfigurationCellPartingLineStyleFill:{
            cell.separatorInset = UIEdgeInsetsZero;
            cell.layoutMargins = UIEdgeInsetsZero;
        }break;
        case AxcFormItemConfigurationCellPartingLineStyleNone:{
            cell.separatorInset = UIEdgeInsetsMake(cell.axcUI_Height, kScreenWidth/2, cell.axcUI_Height,  kScreenWidth/2);
            cell.layoutMargins = UIEdgeInsetsMake(cell.axcUI_Height, kScreenWidth/2, cell.axcUI_Height,  kScreenWidth/2);
        }break;
        default: break;
    }
    return cell;
}


#pragma mark - 业务逻辑
- (void)setContentStrPoint:(NSString *)contentStrPoint{
    _contentStrPoint = contentStrPoint;
    if (self.maxInputLength != 0) { // 已设置了限制
        if (self.numberCharactersFormatting) {
            self.holdCell.limitStr = self.numberCharactersFormatting(_contentStrPoint.length,self.maxInputLength);
        }else{
            self.holdCell.limitStr = [NSString stringWithFormat:@"%ld/%ld",_contentStrPoint.length,self.maxInputLength];
        }
    }
}

- (void)valueChange{ // 下划线防止触发懒加载 判断存储类是否实例化来断言赋值参数
    if (_subtitleLabel) {
        self.contentObj = self.subtitleLabel.text;
    }
    if (_subtitleTextField){
        if (self.maxInputLength != 0 && self.subtitleTextField.text.length > self.maxInputLength) { // 超出字符
            if (self.numberCharactersMaxCeiling) { // 先回调通知
                self.numberCharactersMaxCeiling(self.holdCell.numberCharactersLabel);
            }
            self.subtitleTextField.text = self.contentStrPoint; // 用之前的去覆盖
            if (self.subtitleTextField.text.length != self.maxInputLength) { // 覆盖之后还不对等，说明这小崽子是粘贴的，回复一下原来设置
                if (self.numberCharactersNormal) { // 先回调通知
                    self.numberCharactersNormal(self.holdCell.numberCharactersLabel);
                }
            }
        }else{ // 回复/未超出情况
            if (self.numberCharactersNormal) { // 先回调通知
                self.numberCharactersNormal(self.holdCell.numberCharactersLabel);
            }
            self.contentStrPoint = self.subtitleTextField.text;   //
        }
        self.contentObj = self.subtitleTextField.text;
    }
    if (_contentTextView) {
        if (self.maxInputLength != 0 && self.contentTextView.text.length > self.maxInputLength) { // 超出字符
            if (self.numberCharactersMaxCeiling) { // 先回调通知
                self.numberCharactersMaxCeiling(self.holdCell.numberCharactersLabel);
            }
            self.contentTextView.text = self.contentStrPoint; // 用之前的去覆盖
            if (self.contentTextView.text.length != self.maxInputLength) { // 覆盖之后还不对等，说明这小崽子是粘贴的，回复一下原来设置
                if (self.numberCharactersNormal) { // 先回调通知
                    self.numberCharactersNormal(self.holdCell.numberCharactersLabel);
                }
            }
        }else{ // 未超出
            if (self.numberCharactersNormal) { // 先回调通知
                self.numberCharactersNormal(self.holdCell.numberCharactersLabel);
            }
            self.contentStrPoint = self.contentTextView.text;   //
        }
        self.contentObj = self.contentTextView.text;
        [self contentTextView_textChanged]; // 高度更新相关
    }
    if (_switchControl){
        self.contentObj = @(self.switchControl.on);
    }
    if (_segmentedControl){
        self.contentObj = @(self.segmentedControl.selectedSegmentIndex);
    }
    if (_collectionView) { // 图片选择实例化
        NSMutableArray *arr_M = [NSMutableArray array];
        [self.images enumerateObjectsUsingBlock:^(AxcFormImagesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (!obj.imageShowType) {
                [arr_M addObject: obj.imageObj];
            }
        }];
        self.contentObj = arr_M.copy;
    }
}
#define titleLabelHeight self.titleLabel.axcUI_Height+self.titleLabel.axcUI_Y+10
#define OtherHeight (titleLabelHeight+self.cellAllMargin+self.contentTextView.textContainerInset.top + self.contentTextView.textContainerInset.bottom)
/** 动态获取cell高度 */
- (CGFloat)cellHeightWithItem{
    if (self.contentTextView) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (self.contentTextView.font) {
            [dic setObject:self.contentTextView.font forKey:NSFontAttributeName];
        }
        CGSize detailSize = [self.contentTextView.text boundingRectWithSize:CGSizeMake(kScreenWidth - self.cellAllMargin, MAXFLOAT)
                                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                 attributes:dic
                                                                    context:nil].size;
        return MAX(detailSize.height, self.initialHeight - OtherHeight);
    }
    return 0;
}
- (void)contentTextView_textChanged{
    self.contentTextView.axcUI_Height = [self cellHeightWithItem];
    self.temporaryHeight = self.contentTextView.axcUI_Height + OtherHeight;
    [self.weakTableView beginUpdates];
    [self.weakTableView endUpdates];
}
- (void)upLoadCollectionViewHeight{
    NSInteger imageCount = self.images.count;
    
    NSInteger rowNum = imageCount/self.imageRowCount;
    CGFloat mo = imageCount%self.imageRowCount;
    if (mo > 0) {
        rowNum ++;
    }
    CGFloat collectionHeight = rowNum * (self.imageItemSize.height + (self.cellAllMargin));
    self.temporaryHeight = collectionHeight +titleLabelHeight;
    [self.weakTableView beginUpdates];
    [self.weakTableView endUpdates];
    self.photoCompleteBtn.hidden = ![self getTrueImgsCount];// 检测是否有图
    [self BtnComplete]; // 完成编辑
}
// 监听值
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self valueChange];
}



#pragma mark - 懒加载指针对象
- (id)contentObj{
    if (!_contentObj) {
        _contentObj = [NSNull null]; // 占位
    }
    return _contentObj;
}

- (AxcUI_Label *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[AxcUI_Label alloc] init];
    }
    return _titleLabel;
}
- (AxcUI_Label *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [[AxcUI_Label alloc] init];
        [_subtitleLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return _subtitleLabel;
}
- (UITextField *)subtitleTextField{
    if (!_subtitleTextField) {
        _subtitleTextField = [[UITextField alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valueChange)
                                                     name:UITextFieldTextDidChangeNotification object:nil];
    }
    return _subtitleTextField;
}
- (UITextView *)contentTextView{
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] init];
        //关闭textView滚动
        _contentTextView.scrollEnabled = NO;
        _contentTextView.editable = YES;
        //关闭自动校验
        _contentTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        _contentTextView.layoutManager.allowsNonContiguousLayout = NO;
        _contentTextView.showsVerticalScrollIndicator = NO;
        _contentTextView.showsHorizontalScrollIndicator = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valueChange)
                                                     name:UITextViewTextDidChangeNotification object:nil];
    }
    return _contentTextView;
}
- (AxcUI_Label *)numberCharactersLabel{
    if (!_numberCharactersLabel) {
        _numberCharactersLabel = [AxcUI_Label new];
        if (self.numberCharactersNormal) { // 先回调通知
            self.numberCharactersNormal(_numberCharactersLabel);
        }else{
            _numberCharactersLabel.textColor = [UIColor grayColor];
            _numberCharactersLabel.font = [UIFont systemFontOfSize:14];
            _numberCharactersLabel.textAlignment = NSTextAlignmentCenter;
        }
    }
    return _numberCharactersLabel;
}
- (UISwitch *)switchControl{
    if (!_switchControl) {
        _switchControl = [[UISwitch alloc] init];
        [_switchControl addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventValueChanged];
        _switchControl.on = NO;
        [self valueChange];
    }
    return _switchControl;
}
- (UISegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:self.selectedArray];
        [_segmentedControl addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.selectedSegmentIndex = 0;
        [self valueChange];
    }
    return _segmentedControl;
}

- (AxcFormPullUpPickView *)pickView{
    if (!_pickView) {
        _pickView = [[AxcFormPullUpPickView alloc] init];
        _pickView.selectedArray = self.selectedArray;
        [self defaultStructure:_pickView];
    }
    return _pickView;
}
- (AxcFormPullUpDateView *)dateView{
    if (!_dateView) {
        _dateView = [[AxcFormPullUpDateView alloc] init];
        [self defaultStructure:_dateView];
    }
    return _dateView;
}
- (AxcFormPullUpView *)customPullUpView{
    if (!_customPullUpView) {
        _customPullUpView = [[AxcFormPullUpView alloc] init];
        [self defaultStructure:_customPullUpView];
    }
    return _customPullUpView;
}

- (void)defaultStructure:(AxcFormPullUpView *)pullUpView{
    pullUpView.axcUI_Height = kScreenHeight/2;
    pullUpView.axcUI_Width = kScreenWidth;
}
#define msgStr [NSString stringWithFormat:@"选择%@",self.titleLabel.text]
- (UIActionSheet *)actionSheet{
    if (!_actionSheet) {
        _actionSheet  = [[UIActionSheet alloc] initWithTitle:msgStr
                                                    delegate:nil
                                           cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                           otherButtonTitles:nil];
        [self.selectedArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_actionSheet addButtonWithTitle:obj];
        }];
    }
    return _actionSheet;
}
- (UIAlertController *)alertController{
    if (!_alertController) {
        _alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                               message:msgStr
                                                        preferredStyle:UIAlertControllerStyleAlert];//UIAlertControllerStyleAlert视图在中央
        WeakSelf;
        [self.selectedArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:obj
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                                   weakSelf.subtitleLabel.text = obj;
                                                               }];
            [_alertController addAction:action];
        }];
    }
    return _alertController;
}
- (UIImagePickerController *)imagePickerController{
    if (!_imagePickerController) {
        _imagePickerController = //调用系统相册的类
        _imagePickerController = [[UIImagePickerController alloc]init];
        _imagePickerController.allowsEditing = YES;//设置选取的照片是否可编辑
        //设置相册呈现的样式
        _imagePickerController.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;//图片分组列表样式
    }
    return _imagePickerController;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        // 设置布局
        UICollectionViewFlowLayout *_flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.sectionInset = UIEdgeInsetsMake(self.cellAllMargin, self.cellAllMargin, self.cellAllMargin, self.cellAllMargin);
        _flowLayout.minimumLineSpacing = self.cellAllMargin;
        _flowLayout.minimumInteritemSpacing = 0;
        // 获取UICollectionView对象
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 10, 10) collectionViewLayout:_flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"AxcFormPictureCell" bundle:nil] forCellWithReuseIdentifier:@"axc"];
        UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longHandle:)];
        [_collectionView addGestureRecognizer:longTap];
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AxcFormPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"axc" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.model = self.images[indexPath.row];
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = self.phothoCellCornerRadius;
    cell.delectedBtn.hidden = YES;
    cell.delectedBtn.indexPath = indexPath;
    [cell.delectedBtn addTarget:self action:@selector(click_cellDelectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
// 返回item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  self.imageItemSize;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AxcFormImagesModel *model = self.images[indexPath.row];
    if (model.imageShowType) {
        WeakSelf;
        self.clickAddPicBlcok(weakSelf);
    }else{ // 想查看图片
        __block NSMutableArray *arr_M = @[].mutableCopy;
        [self.images enumerateObjectsUsingBlock:^(AxcFormImagesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (!obj.imageShowType) {
                AxcFormPictureCell *cell = (AxcFormPictureCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
                KSPhotoItem *item = [KSPhotoItem itemWithSourceView:cell.imageView image:cell.imageView.image];
                [arr_M addObject:item];
            }
        }];
        self.clickLookPicBlcok([self instantiationBrowserItems:arr_M selectedIndex:indexPath.row]);
    }
}
#define cellWidth(a) (kScreenWidth - ((a+1) * self.cellAllMargin)) / a 
- (CGSize)imageItemSize{
    _imageItemSize = CGSizeMake(cellWidth(self.imageRowCount), cellWidth(self.imageRowCount));
    return _imageItemSize;
}
- (NSMutableArray <AxcFormImagesModel *>*)images{
    if (!_images) {
        _images = [NSMutableArray array];
        AxcFormImagesModel *addModel = [AxcFormImagesModel new];
        addModel.imageShowType = 1;
        addModel.imageObj = self.addImagePic;
        [_images addObject:addModel];
    }
    return _images;
}
- (BOOL )isBeyondImage{
    return [self getTrueImgsCount] < self.pictureSelectNum;
}
- (NSInteger )getTrueImgsCount{
    __block NSInteger count = 0;
    [self.images enumerateObjectsUsingBlock:^(AxcFormImagesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!obj.imageShowType) {
            count ++;
        }
    }];
    return count;
}
// 长时间摸Collection，受不了了
-(void)longHandle:(UILongPressGestureRecognizer *)gesture{
    if (!self.isMoveSorting) {
        return; // 写到这里是因为可以支持实时设置参数
    }
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
            AxcFormPictureCell *cell_ = [[self.collectionView visibleCells] objectAtIndex:indexPath.row];
            if (indexPath == nil || cell_.model.imageShowType) break; // 添加图片不能移动
            // 移除最后一张添加图片
            AxcFormImagesModel *removeImage = self.images[self.images.count-1];
            if(removeImage.imageShowType == 1){
                self.mobileModel = removeImage;
                [self.images removeObjectAtIndex:self.images.count-1];
                [self.collectionView reloadData];
                [self upLoadCollectionViewHeight];
            }else{
                self.mobileModel = nil;
            }
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            //cell.layer添加抖动手势
            for (AxcFormPictureCell *cell in [self.collectionView visibleCells]) {
                if (!cell.model.imageShowType) {
                    [self starShake:cell];
                }
            }
        }break;
        case UIGestureRecognizerStateChanged:{
            [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:self.collectionView]];
        }break;
        case UIGestureRecognizerStateEnded:{
            self.photoCompleteBtn.hidden = NO;
            [self.collectionView endInteractiveMovement];
            for (AxcFormPictureCell *cell in [self.collectionView visibleCells]) {
                [self stopShake:cell];
            }
            if(self.mobileModel){
                [self.images addObject:self.mobileModel];
                [self upLoadCollectionViewHeight];
            }
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3/*延迟执行时间*/ * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
                [self BtnComplete]; // 完成编辑
            });
        }break;
        default: [self.collectionView cancelInteractiveMovement]; break;
    }
}
//3.设置可移动
-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//4.移动完成后的方法  －－ 交换数据
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    AxcFormImagesModel *sourceModel = [self.images objectAtIndex:sourceIndexPath.row];
    AxcFormImagesModel *destinationModel = [self.images objectAtIndex:destinationIndexPath.row];
    if (sourceModel.imageShowType || destinationModel.imageShowType) {
        [self.collectionView cancelInteractiveMovement];
    }else{
        AxcFormImagesModel *exModel1 = self.images[sourceIndexPath.row];
        [self.images removeObjectAtIndex:sourceIndexPath.row];
        [self.images insertObject:exModel1 atIndex:destinationIndexPath.row];
    }
}
#define photoCompleteBtnEditorStr @"编辑"
#define photoCompleteBtnCompleteStr @"完成"
- (void)click_photoCompleteBtn{
    // 点击需要编辑
    if ([self.photoCompleteBtn.titleLabel.text isEqualToString:photoCompleteBtnEditorStr]) {
        [self BtnEditor];
    }else{
        [self BtnComplete];
    }
}
// 完成
- (void)BtnComplete{
    [_photoCompleteBtn setTitle:photoCompleteBtnEditorStr forState:UIControlStateNormal];
    for (AxcFormPictureCell *cell in [self.collectionView visibleCells]) {
        if (!cell.model.imageShowType) {
            cell.delectedBtn.hidden = YES;
            [self stopShake:cell];
        }
    }
}
// 编辑
- (void)BtnEditor{
    [_photoCompleteBtn setTitle:photoCompleteBtnCompleteStr forState:UIControlStateNormal];
    for (AxcFormPictureCell *cell in [self.collectionView visibleCells]) {
        if (!cell.model.imageShowType) {
            cell.delectedBtn.hidden = NO;
            [self starShake:cell];
        }
    }
}
// 删除了某一个Cell
- (void)click_cellDelectedBtn:(UIButton *)sender{
    // 删除时候需要实时更新Btn的IndexPath
    [self.images removeObjectAtIndex:sender.indexPath.row];
    [self.collectionView deleteItemsAtIndexPaths:@[sender.indexPath]];
    if ([self isBeyondImage]) { // 删除后不足上限
        __block BOOL isAdd_Image = YES;
        [self.images enumerateObjectsUsingBlock:^(AxcFormImagesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.imageShowType == 1) {
                isAdd_Image = NO;
            }
        }];
        if (isAdd_Image) { // 正好又没有添加图片
            AxcFormImagesModel *model = [AxcFormImagesModel new];
            model.imageObj = self.addImagePic;
            model.imageShowType = 1;
            [self.images addObject:model];
            [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.images.count-1 inSection:0]]];
        }
    }
    [self upLoadCollectionViewHeight];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        [self valueChange]; // 更新存储
    });
}
// 让Cell高潮
- (void)starShake:(AxcFormPictureCell*)cell{
    CAKeyframeAnimation * keyAnimaion = [CAKeyframeAnimation animation];
    keyAnimaion.keyPath = @"transform.rotation";
    keyAnimaion.values = @[@(-3 / 180.0 * M_PI),@(3 /180.0 * M_PI),@(-3/ 180.0 * M_PI)];//度数转弧度
    keyAnimaion.removedOnCompletion = NO;
    keyAnimaion.fillMode = kCAFillModeForwards;
    keyAnimaion.duration = 0.3;
    keyAnimaion.repeatCount = MAXFLOAT;
    [cell.layer addAnimation:keyAnimaion forKey:@"cellShake"];
}
- (void)stopShake:(AxcFormPictureCell*)cell{
    [cell.layer removeAnimationForKey:@"cellShake"];
}

- (UIButton *)photoCompleteBtn{
    if (!_photoCompleteBtn) {
        _photoCompleteBtn = [UIButton new];
        _photoCompleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _photoCompleteBtn.hidden = YES;
        [_photoCompleteBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_photoCompleteBtn setTitle:photoCompleteBtnEditorStr forState:UIControlStateNormal];
        [_photoCompleteBtn addTarget:self action:@selector(click_photoCompleteBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photoCompleteBtn;
}



// 照片查看器
- (KSPhotoBrowser *)instantiationBrowserItems:(NSArray<KSPhotoItem *> *)photoItems selectedIndex:(NSUInteger)selectedIndex{
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:photoItems selectedIndex:selectedIndex];
    browser.delegate = self; // 属性全嫁接，指针停留
    browser.dismissalStyle = self.ksPhotoBrowser.dismissalStyle;
    browser.backgroundStyle = self.ksPhotoBrowser.backgroundStyle;
    browser.loadingStyle = self.ksPhotoBrowser.loadingStyle;
    browser.pageindicatorStyle = self.ksPhotoBrowser.pageindicatorStyle;
    browser.bounces = self.ksPhotoBrowser.bounces;
    return browser;
}
- (void)ks_photoBrowser:(KSPhotoBrowser *)browser didSelectItem:(KSPhotoItem *)item atIndex:(NSUInteger)index{
    
}
// 三方库照片选择器
- (ZLPhotoActionSheet *)zlImageActionSheet{
    if (!_zlImageActionSheet) {
        _zlImageActionSheet = [[ZLPhotoActionSheet alloc] init];
        //设置照片最大预览数
        _zlImageActionSheet.configuration.maxPreviewCount = 20;
        //设置照片最大选择数
        _zlImageActionSheet.configuration.maxSelectCount = self.pictureSelectNum;
        // 允许拖拽选择
        _zlImageActionSheet.configuration.allowDragSelect = YES;
        WeakSelf;
        _zlImageActionSheet.selectImageBlock = ^(NSArray<UIImage *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            weakSelf.selectImageBlock(images,assets,isOriginal,weakSelf);
        };
    }
    return _zlImageActionSheet;
}

// 自身元素懒加载

- (CGFloat)cellAllMargin{
    if (!_cellAllMargin) {
        _cellAllMargin = 10;
    }
    return _cellAllMargin;
}
- (UIColor *)backGroundColor{
    if (!_backGroundColor) {
        _backGroundColor = [UIColor whiteColor];
    }
    return _backGroundColor;
}

- (void)dealloc{ // 监听全部销毁
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [self.subtitleLabel removeObserver:self forKeyPath:@"text"];
}

@end
