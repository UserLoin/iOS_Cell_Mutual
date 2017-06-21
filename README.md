# iOS_Cell_Mutual
Cell互斥事件
*本文仅提供Cell互斥的三种思路，代码变换无穷，可以灵活运用到自己的项目中*
![效果图](http://upload-images.jianshu.io/upload_images/4881197-b4764d92e5e26663.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
# 第一种方法：点击Cell互斥
使用系统方法：

    - (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    }
    //此方法点击Cell时，会使离开Cell的selected = NO，点击Cell的selected = YES

#### 使用：

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
 # 第二种方法：点击Button互斥
    
    #import <UIKit/UIKit.h>
    typedef void (^CustomButtonSingleOneCellBlock)();
    @interface CustomButtonSingleOneCell : UITableViewCell
    @property(nonatomic,copy)CustomButtonSingleOneCellBlock SingleBtnBlock;
    @property(nonatomic,strong) UIButton * button;;
    @end

    #import "CustomButtonSingleOneCell.h"
    @implementation CustomButtonSingleOneCell
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

### ViewController使用
    @implementation LPSingleViewController
    {
    UIButton *tempBtn;
    }

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
        
# 第三种方法：点击Button或者Cell互斥、本文提供点击Cell原理相同

    #import <UIKit/UIKit.h>
    @interface CustomBtnSingleTwoCell : UITableViewCell
    @property(nonatomic,assign)BOOL isBtnSelected;
    - (void)setBtnSelected;
    @end
    #import "CustomBtnSingleTwoCell.h"
    @implementation CustomBtnSingleTwoCell{
    UIButton * button;
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
    
### ViewController使用

    boolArray = [NSMutableArray arrayWithArray:@[@(YES),@(NO),@(NO),@(NO),@(NO)]] ;
    CustomBtnSingleTwoCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CustomBtnSingleTwoCell" forIndexPath:indexPath];
                cell.backgroundColor = [UIColor yellowColor];
        cell.isBtnSelected = [boolArray[indexPath.row] boolValue];
        [cell setBtnSelected];
        return cell;

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

[简书地址](http://www.jianshu.com/p/3acbb7a748d3)
