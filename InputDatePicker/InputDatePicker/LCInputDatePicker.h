//
//  LCInputDatePicker.h
//  InputDatePicker
//
//  Created by MoGo on 16/4/11.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCInputDatePicker : UITextField
@property (nonatomic , strong) NSDate *startDate;

- (void)resultSelectedDate:(void(^)(NSDate *resultDate))resultDateBlock;
@end
