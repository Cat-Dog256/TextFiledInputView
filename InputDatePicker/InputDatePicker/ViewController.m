//
//  ViewController.m
//  InputDatePicker
//
//  Created by MoGo on 16/4/11.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "ViewController.h"
#import "LCInputDatePicker.h"
@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet LCInputDatePicker *dateTextFiled;


@property (nonatomic , strong) UITextField *textFiled;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateTextFiled.startDate = [NSDate date];
    [self.dateTextFiled resultSelectedDate:^(NSDate *resultDate) {
        NSLog(@"%@",resultDate);
    }];
    
    
    _textFiled = [[UITextField alloc] initWithFrame:CGRectMake(120.0f, 200.0f, 150.0f, 30.0f)];
    [_textFiled setBorderStyle:UITextBorderStyleBezel]; //外框类型
    [self.view addSubview:self.textFiled];
    _textFiled.placeholder = @"password"; //默认显示的字
    
//    _textFiled.secureTextEntry = YES; //密码
    
    
#warning 这两个属性不明白
    _textFiled.autocorrectionType = UITextAutocorrectionTypeYes;
    _textFiled.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    
    
    /**
     *  设置键盘return键
     */
    _textFiled.returnKeyType = UIReturnKeyDone;
    _textFiled.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    
    _textFiled.delegate = self;
//    [self isPartialStringValid:self.textFiled.text proposedSelectedRange:<#(NSRangePointer)#> originalString:<#(NSString *)#> originalSelectedRange:<#(NSRange)#> errorDescription:<#(NSString *__autoreleasing *)#>];
//    [_textFiled delete: nil];

    // Do any additional setup after loading the view, typically from a nib.
}
/**
 *  关闭键盘
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textFiled resignFirstResponder];
    return YES;
}

//-(IBAction) textFieldDone:(id) sender
//{
//    [textFieldName resignFirstResponder];
//}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



//如何限制文本框只能输入数字:
//建立NSNumberFormatter的子类，增加这个方法，将formatter链接至文本框。

- (BOOL) isPartialStringValid: (NSString **) partialStringPtr
        proposedSelectedRange: (NSRangePointer) proposedSelRangePtr
               originalString: (NSString *) origString
        originalSelectedRange: (NSRange) origSelRange
             errorDescription: (NSString **) error
{
    NSCharacterSet *nonDigits;
    NSRange newStuff;
    NSString *newStuffString;
    
    nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    newStuff = NSMakeRange(origSelRange.location,
                           proposedSelRangePtr->location
                           - origSelRange.location);
    newStuffString = [*partialStringPtr substringWithRange: newStuff];
    
    if ([newStuffString rangeOfCharacterFromSet: nonDigits
                                        options: NSLiteralSearch].location != NSNotFound) {
        *error = @"不是数字";
        return (NO);
    } else {
        *error = nil;
        return (YES);
    }
    
}


/**
 *  http://www.cnblogs.com/wengzilin/archive/2012/03/13/2393985.html
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
