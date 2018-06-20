//
//  SZFormRowDatePicker.m
//  Form-iOS
//
//  Created by songzhou on 2018/6/20.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import "SZFormRowDatePicker.h"
#import "SZForminputAccessoryView.h"

@interface SZFormRowDatePicker () <UITextFieldDelegate>

@end

@implementation SZFormRowDatePicker

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //
        [self.textField removeTarget:self action:nil forControlEvents:UIControlEventEditingChanged];
        self.textField.delegate = self;
    }
    return self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    SZForminputAccessoryView *inputAccessoryView = [SZForminputAccessoryView new];
    
    UIDatePicker *datePicker = [UIDatePicker new];
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    textField.inputView = datePicker;
    
    __weak typeof(self) wself = self;
    __weak typeof(textField) weak_textField = textField;
    __weak typeof(datePicker) weak_datePicker = datePicker;
    
    inputAccessoryView.doneBlock = ^{
        __strong typeof(wself) self = wself;
        __strong typeof(weak_textField) textField = weak_textField;
        __strong typeof(weak_datePicker) datePicker = weak_datePicker;
        
        [textField resignFirstResponder];
        [self _date:[datePicker date]];
    };
    
  
    textField.inputAccessoryView = inputAccessoryView;
    
    return YES;
}

- (void)dateChange:(UIDatePicker *)sender {
    [self _date:sender.date];
}

- (void)_date:(NSDate *)date {
    if ([self.rowDelegate respondsToSelector:@selector(formRowView:didEndEditingWithText:key:)]) {
        [self.rowDelegate formRowView:self didEndEditingWithText:[date description] key:self.key];
    }
}

@end
