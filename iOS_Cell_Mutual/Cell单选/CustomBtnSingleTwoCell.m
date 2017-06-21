//
//  CustomBtnSingleTwoCell.m
//  LPCollection16822
//
//  Created by 咖达 on 2017/5/21.
//  Copyright © 2017年 咖达. All rights reserved.
//

#import "CustomBtnSingleTwoCell.h"

@implementation CustomBtnSingleTwoCell

{
    UIButton * button;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;


        button = [[UIButton alloc]init];
        [self.contentView addSubview:button];
        button.frame = CGRectMake(10, 10, 100, 30);
        [button setTitle:@"未选中" forState:UIControlStateNormal];
        [button setTitle:@"选中" forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}
- (void)setBtnSelected{
    button.selected = self.isBtnSelected;
}
@end
