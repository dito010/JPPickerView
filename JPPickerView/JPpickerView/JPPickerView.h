//
//  JPPickerView.h
//  JPPickerView
//
//  Created by Chris on 16/6/2.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JPPickerView;

@protocol JPPickerViewDelegate <NSObject>

@optional
-(void)JPPickerView:(JPPickerView *)pickerView SelectedText:(NSString *)selectedText;

@end

@interface JPPickerView : UIView

/** 代理 */
@property(nonatomic, weak)id<JPPickerViewDelegate> delegate;
/**
 *  根据给定的数组创建该类(构造方法)
 *
 *  @param arr 数组
 *
 *  @return 该类实例对象
 */
-(instancetype)initWithArr:(NSArray<NSString *> *)arr;
/**
 *  滚动到指定的文字行
 */
-(void)scrollWithDestiText:(NSString *)destiText;

@end
