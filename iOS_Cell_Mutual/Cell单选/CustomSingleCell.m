//
//  CustomSingleCell.m
//  LPCollection16822
//
//  Created by 咖达 on 2017/5/21.
//  Copyright © 2017年 咖达. All rights reserved.
//

#import "CustomSingleCell.h"

@implementation CustomSingleCell

{
    UIButton * button;
}
- (void)awakeFromNib {
    [super awakeFromNib];
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
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)onClick:(UIButton *)btn{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    /*在此处设置*/
    button.selected =  selected;
}

@end
