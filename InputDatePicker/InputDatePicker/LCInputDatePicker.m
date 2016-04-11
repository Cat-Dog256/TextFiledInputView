//
//  LCInputDatePicker.m
//  InputDatePicker
//
//  Created by MoGo on 16/4/11.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCInputDatePicker.h"

@interface LCInputDatePicker ()
@property (nonatomic , copy) void(^selectedDateBlock)(NSDate *date);
@property (nonatomic , strong) UIDatePicker *datePicker;
@end

@implementation LCInputDatePicker
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupLCInputDatepicker];
    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        [self setupLCInputDatepicker];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLCInputDatepicker];
    }
    return self;
}
- (void)setupLCInputDatepicker{
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
    /**
     *  设置光标的颜色  ,设置成clearColor就会呈现隐藏光标的效果
     */
    self.tintColor = [UIColor clearColor];
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    /**
     设置语言 默认英文
     */
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en"]];
    //        [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_cn"]];
    /**
     *  设置选中时间
     */
    datePicker.date = [NSDate dateWithTimeIntervalSince1970:0];
    
    self.datePicker = datePicker;
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    /**
     *  键盘
     */
    self.inputView = datePicker;
    [self dateChanged:datePicker];
    UIView *accessView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    accessView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 7, 50, 30)];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitle:@"Done" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickDoneButton:) forControlEvents:UIControlEventTouchUpInside];
    [accessView addSubview:button];
    /**
     *  ToolBar
     */
    self.inputAccessoryView = accessView;

}

- (void)setStartDate:(NSDate *)startDate{
    _startDate = startDate;
    self.datePicker.date = startDate;
    [self dateChanged:self.datePicker];
}
- (void)dateChanged:(UIDatePicker *)datePicker
{
    
    if (self.selectedDateBlock) {
        self.selectedDateBlock([NSDate date]);
    }

    // 需要将日期选择的结果转换成字符串
    // 1. 实例化日期格式器
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    // 2. 设置日期格式器的“格式字符串”
    [formatter setDateFormat:@"yyyy-MM-dd"];
    // 3. 将日期转换成文本
    NSString *dateString = [formatter stringFromDate:datePicker.date];
    // 4. 设置文字
    [self setText:dateString];
    
}
- (void)clickDoneButton:(UIButton *)button{
    [self endEditing:YES];
}

- (void)resultSelectedDate:(void (^)(NSDate *))resultDateBlock{
    [self setSelectedDateBlock:^(NSDate *selecteddMyDate) {
        resultDateBlock(selecteddMyDate);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
