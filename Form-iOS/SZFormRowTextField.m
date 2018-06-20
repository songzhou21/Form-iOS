//
//  SZFormRowTextField.m
//  Form-iOS
//
//  Created by songzhou on 2018/6/18.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import "SZFormRowTextField.h"

@implementation SZFormRowTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        
        _textField = [UITextField new];
        [self addSubview:_textField];
        
        
        // layout
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.layoutMargins = UIEdgeInsetsMake(0, 8, 0, 0);
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:self.titleLabel.layoutMargins.left],
                                                  [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
                                                  ]];
        
        
        _textField.translatesAutoresizingMaskIntoConstraints = NO;
        _textField.layoutMargins = UIEdgeInsetsMake(0, 8, 0, 8);
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.textField.leadingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor constant:self.textField.layoutMargins.left],
                                                  [self.textField.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-self.textField.layoutMargins.right],
                                                  [self.textField.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
                                                  ]];
    }
    return self;
}

@end
