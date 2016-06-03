//
//  ViewController.m
//  JPPickerView
//
//  Created by Chris on 16/6/2.
//  Copyright © 2016年 Chris. All rights reserved.
//

/*
 使用说明:
 1.导入#import "JPPickerView.h"头文件
 2.建议使用懒加载的方式创建JPPickerView, 在创建的时候的构造方法里传入一个字符串数组,运行的时候就会显示数组中的内容
 3.注意在viewDidLoad方法中初始化JPPickerView组件,[self.containView addSubview:self.demoPickerView];
 4.在代理方法中能够拿到用户选中行的文字
 5.还提供一个对象方法-(void)scrollWithDestiText:(NSString *)destiText;可以指定滚动到对应行
 */



#import "ViewController.h"
#import "JPPickerView.h"

@interface ViewController ()<JPPickerViewDelegate>

/** 容器 */
@property (weak, nonatomic) IBOutlet UIView *containView;
/** 容器高度约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containViewHeightCons;
/** 选中文字label */
@property (weak, nonatomic) IBOutlet UILabel *selectedLabel;
/** pickerview */
@property(nonatomic, strong)JPPickerView *demoPickerView;
/** 展示容器是否打开 */
@property(nonatomic, assign)BOOL isContainViewOPen;

@end


const CGFloat containViewHeightOpen = 150;
@implementation ViewController
-(JPPickerView *)demoPickerView{
    if (!_demoPickerView) {
        NSArray *arr = @[@"凤姐", @"凤姐", @"凤姐", @"凤姐", @"凤姐", @"凤姐", @"凤姐", @"凤姐", @"凤姐", @"凤姐", @"凤姐", @"凤姐", @"凤姐", @"凤姐"];
        _demoPickerView = [[JPPickerView alloc]initWithArr:arr];
        _demoPickerView.delegate = self;
        _demoPickerView.frame = CGRectMake(0, 0, self.containView.bounds.size.width, containViewHeightOpen);
        self.containView.clipsToBounds = YES;
    }
    return _demoPickerView;
}

#pragma mark -----------------------------------------
#pragma mark 系统回调函数
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.containViewHeightCons.constant = 0;
    [self.containView addSubview:self.demoPickerView];
}

#pragma mark -----------------------------------------
#pragma mark 点击事件
- (IBAction)showMe:(UIButton *)sender {

    if (!self.isContainViewOPen) { // 打开
        self.containViewHeightCons.constant = containViewHeightOpen;
        self.isContainViewOPen = YES;
        [sender setTitle:@"合上" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{ // 动画
            [self.view layoutIfNeeded];
        }];
    }
    else{ // 合上
        self.containViewHeightCons.constant = 0;
        self.isContainViewOPen = NO;
        [sender setTitle:@"打开" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

#pragma mark -----------------------------------------
#pragma mark JPPickerViewDelegate
-(void)JPPickerView:(JPPickerView *)pickerView SelectedText:(NSString *)selectedText{
    self.selectedLabel.text = selectedText;
}

@end
