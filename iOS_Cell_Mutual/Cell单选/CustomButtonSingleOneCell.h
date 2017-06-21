//
//  CustomButtonSingleOneCell.h
//  LPCollection16822
//
//  Created by 咖达 on 2017/5/21.
//  Copyright © 2017年 咖达. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CustomButtonSingleOneCellBlock)();
@interface CustomButtonSingleOneCell : UITableViewCell
@property(nonatomic,copy)CustomButtonSingleOneCellBlock SingleBtnBlock;
@property(nonatomic,strong) UIButton * button;;

@end
