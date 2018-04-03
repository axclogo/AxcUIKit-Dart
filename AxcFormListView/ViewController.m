//
//  ViewController.m
//  AxcFormListView
//
//  Created by Axc on 2018/4/2.
//  Copyright © 2018年 AxcLogo. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<AxcFormListViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *collectionBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [collectionBtn setTitle:@"获取表单数据" forState:UIControlStateNormal];
    [collectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [collectionBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [collectionBtn addTarget:self
                      action:@selector(click_switchC)
            forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc]initWithCustomView:collectionBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    self.formView = [[AxcFormListView alloc] initWithFrame:self.view.bounds];
    self.formView.delegate = self;
    self.formView.formTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.formView.formTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
    [self.view addSubview:self.formView];
    [self.formView mas_makeConstraints:^(MASConstraintMaker *make) {
        AxcWholeFrameLayout;
    }];
    [self createItem];
}
- (void)click_switchC{
    // 或者
    NSArray *arr = [self.formView GetFormListViewAllData];
    for (int i = 0; i < arr.count; i ++) {
        AxcFormConfigurationModel *resultsModel = arr[i];
        NSLog(@"%@",resultsModel); // 已重写description函数，可直接打印
    }
}
- (void)createItem{
    // 创建展示行对象构造器
    NSMutableArray *rowArray = [NSMutableArray array];
    [self.itemsArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AxcFormItemConfiguration *item = [[AxcFormItemConfiguration alloc] initWithStyle:AxcFormItemConfigurationStyleCustomAction];
        item.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        item.titleLabel.text = [obj objectForKey:@"title"];
        item.titleLabel.font = [UIFont systemFontOfSize:15];
        item.subtitleLabel.text = [obj objectForKey:@"subTitle"];
        item.subtitleLabel.textColor = [UIColor AxcUI_OrangeColor];
        item.subtitleLabel.textAlignment = NSTextAlignmentRight;
        item.subtitleLabel.font = [UIFont systemFontOfSize:14];
        [rowArray addObject:item];
    }];
    // 组对象构造器
    AxcFormItemSectionConfiguration *sectionC = [[AxcFormItemSectionConfiguration alloc] init];
    sectionC.items = rowArray;
    
    [self.formView.formCollectionArray addObject:sectionC];
    [self.formView.formTableView reloadData];
   
}
#pragma mark - 懒加载
- (NSArray *)itemsArray{
    if (!_itemsArray) {
        _itemsArray = @[@{@"title":@"text文本输入演示",@"subTitle":@"",@"VCName":@"TextInputDemonstrationVC"},
                        @{@"title":@"text内容输入演示",@"subTitle":@"",@"VCName":@"TextContentInputVC"},
                        @{@"title":@"时间/滚轮类型的选择器",@"subTitle":@"",@"VCName":@"SelectedVC"},
                        @{@"title":@"其他类型的选择器",@"subTitle":@"",@"VCName":@"OtherSelectedVC"},
                        @{@"title":@"带Switch的演示",@"subTitle":@"",@"VCName":@"SwitchOnVC"},
                        @{@"title":@"系统照片选择器的演示",@"subTitle":@"",@"VCName":@"SystemPicSelectedVC"},
                        @{@"title":@"第三方照片选择器的演示",@"subTitle":@"",@"VCName":@"LibPicSelectedVC"},
                        @{@"title":@"综合使用演示",@"subTitle":@"",@"VCName":@"ComprehensiveUseOfVC"}
                        ];
    }
    return _itemsArray;
}
- (void)AxcFormListView:(AxcFormListView *)axcFormListView didSelectRowAtIndexPath:(NSIndexPath *)indexPath style:(AxcFormItemConfigurationStyle)style{
    NSDictionary *dic = [self.itemsArray objectAtIndex:indexPath.row];
    Class class = NSClassFromString([dic objectForKey:@"VCName"]);
    UIViewController *vc = [[class alloc] init];
    vc.title = [dic objectForKey:@"title"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
