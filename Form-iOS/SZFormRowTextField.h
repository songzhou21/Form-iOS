//
//  SZFormRowTextField.h
//  Form-iOS
//
//  Created by songzhou on 2018/6/18.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZFormRowView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SZFormRowTextField : UIView <SZFormRowViewProtocol>

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UITextField *textField;

@property (nonatomic, weak) id<SZFormRowViewDelegate> rowDelegate;
@property (nonatomic, copy) NSString *key;
- (void)setText:(NSString *)text forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
