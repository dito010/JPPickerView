//
//  JPPickerView.m
//  JPPickerView
//
//  Created by Chris on 16/6/2.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "JPPickerView.h"

@interface JPPickerView()<UIPickerViewDataSource, UIPickerViewDelegate>
// 数组
@property(nonatomic, strong)NSArray<NSString *> *arr;
// pickView
@property(nonatomic, strong)UIPickerView *pickView;

@end
@implementation JPPickerView
-(instancetype)initWithArr:(NSArray<NSString *> *)arr{
    
    if (self = [super init]) {
        self.arr = arr;
        [self setUp];
    }
    return self;
}


-(void)setUp{
    // **********************************************************************************************
    // 这四行代码至关重要,意思是,在当前View的左上角原点创建一个pickView, 让pickView的左右上下自由伸缩;如果不这么设置,你下面设置的frame就没有效果,不信自己注掉试试看
    UIPickerView *pickView = [[UIPickerView alloc]initWithFrame:CGRectZero];
    pickView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    pickView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    pickView.showsSelectionIndicator = YES;
    // **********************************************************************************************
    
    pickView.dataSource = self;
    pickView.delegate = self;
    self.pickView = pickView;
    pickView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:pickView];
}

#pragma mark -----------------------------------------
#pragma mark UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.arr.count;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    // 这里用label来展示要显示的文字, 然后可以用label的textAlignment来设置文字的对齐模式
    UILabel *myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 35)];
    myView.font = [UIFont systemFontOfSize:18];
    myView.backgroundColor = [UIColor clearColor];
    myView.textAlignment = NSTextAlignmentCenter;
    
    myView.text = self.arr[row];
    
    return myView;
}

#pragma mark -----------------------------------------
#pragma mark UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 70;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35.0;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
   
    NSString *selectedText = self.arr[row];
    if ([self.delegate respondsToSelector:@selector(JPPickerView:SelectedText:)]) {
        [self.delegate JPPickerView:self SelectedText:selectedText];
    }
}

#pragma mark -----------------------------------------
#pragma mark 自定义的接口
// 滚动到指定的文字行，一般用作初始化
-(void)scrollWithDestiText:(NSString *)destiText{
    NSInteger index = [self.arr indexOfObject:destiText];
    [self.pickView selectRow:index inComponent:0 animated:YES];
}

@end
