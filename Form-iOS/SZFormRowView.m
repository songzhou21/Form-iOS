//
//  SZFormRowView.m
//  Form-iOS
//
//  Created by songzhou on 2018/6/18.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import "SZFormRowView.h"

@implementation SZFormRowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
                                                  [_titleLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8],
                                                  [_titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
                                                  ]];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric, _titleLabel.intrinsicContentSize.height + 16);
}
@end
