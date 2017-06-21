//
//  LPSingleViewController.m
//  LPCollection16822
//
//  Created by 咖达 on 2017/5/21.
//  Copyright © 2017年 咖达. All rights reserved.
//

#import "LPSingleViewController.h"
#import "CustomSingleCell.h"

#import "CustomButtonSingleOneCell.h"
#import "CustomBtnSingleTwoCell.h"


@interface LPSingleViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation LPSingleViewController
{
    UIButton *tempBtn;
    NSMutableArray *boolArray;
}
#pragma mark - 懒加载
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (UITableView *)tableView{
    if (!_tableView) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
#pragma mark- 页面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    [self createTableView];
    [self createData];
}

#pragma mark- 加载数据
- (void)createData{
    NSArray *array = @[@"清除缓存",@"查看详情",@"系统通知"];
    _dataArray = [NSMutableArray arrayWithArray:array];
    boolArray = [NSMutableArray arrayWithArray:@[@(YES),@(NO),@(NO),@(NO),@(NO)]] ;
    [_tableView reloadData];
}
- (void)createTableView{
    
    [self.tableView registerClass:[CustomSingleCell class] forCellReuseIdentifier:@"CustomCell"];
    [self.tableView registerClass:[CustomButtonSingleOneCell class] forCellReuseIdentifier:@"CustomButtonSingleOneCell"];
    
    [self.tableView registerClass:[CustomBtnSingleTwoCell class] forCellReuseIdentifier:@"CustomBtnSingleTwoCell"];

}


#pragma mark- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CustomSingleCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
        
        //设置默认的cell处于选中状态
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        cell.backgroundColor = [UIColor yellowColor];
        return cell;
    }else if (indexPath.section == 1){
        CustomButtonSingleOneCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CustomButtonSingleOneCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.button.selected = YES;
        }
        cell.SingleBtnBlock = ^(UIButton *btn){
            tempBtn.selected = NO;
            tempBtn = btn;
            btn.selected = YES;
        };
        return cell;
    }else if (indexPath.section == 2){
        
        CustomBtnSingleTwoCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CustomBtnSingleTwoCell" forIndexPath:indexPath];
                cell.backgroundColor = [UIColor yellowColor];
        cell.isBtnSelected = [boolArray[indexPath.row] boolValue];
        [cell setBtnSelected];
        return cell;
    }
    
    CustomSingleCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    //设置默认的cell处于选中状态
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 66;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    UILabel *label = [[UILabel alloc]init];
    label.font= [UIFont systemFontOfSize:14];
    label.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    label.textColor = [UIColor grayColor];
    label.numberOfLines = 0;
    switch (section) {
        case 0:
        {
            label.text = @"第一种点击Cell互斥事件\n利用系统- (void)setSelected:(BOOL)selected animated:(BOOL)animated方法";
        }
            break;
        case 1:
        {
            label.text = @"第二种点击Button互斥事件\n利用中间变量暂时保存button";
        }
            break;
        case 2:
        {
            label.text = @"第三种点击Cell互斥事件\n利用bool值记录,点击改变bool值得状态";
        }
            break;
            
        default:
            break;
    }
    [view addSubview:label];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        
        //点击的时候确定点击状态。最好有model设置
        [boolArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == indexPath.row) {
                boolArray[indexPath.row] = @(YES);
            }else{
                boolArray[idx] = @(NO);
            }
        }];
        
        [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    }
}
@end
