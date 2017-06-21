//
//  CustomButtonSingleOneCell.m
//  LPCollection16822
//
//  Created by 咖达 on 2017/5/21.
//  Copyright © 2017年 咖达. All rights reserved.
//

#import "CustomButtonSingleOneCell.h"

@implementation CustomButtonSingleOneCell

{
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.button = [[UIButton alloc]init];
        [self.contentView addSubview:self.button];
        self.button.frame = CGRectMake(10, 10, 100, 30);
        [self.button setTitle:@"未选中" forState:UIControlStateNormal];
        [self.button setTitle:@"选中" forState:UIControlStateSelected];
        [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self.button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)onClick:(UIButton *)btn{
    
    self.SingleBtnBlock(btn);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
