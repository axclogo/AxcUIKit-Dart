//
//  AxcFormPictureCell.h
//  Fabric_Merchants
//
//  Created by Axc on 2018/4/1.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AxcFormImagesModel.h"

@interface AxcFormPictureCell : UICollectionViewCell

@property(nonatomic, strong)AxcFormImagesModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

// 编辑状态的删除按钮
@property(nonatomic, strong)UIButton *delectedBtn;

@end
