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
        
        _contentLabel = [UILabel new];
        [self addSubview:_contentLabel];
        
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow+1 forAxis:UILayoutConstraintAxisHorizontal];
        [NSLayoutConstraint activateConstraints:@[
                                                  [_titleLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8],
                                                  [_titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
                                                  ]];
        
        _contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [NSLayoutConstraint activateConstraints:@[
                                                  [_contentLabel.leftAnchor constraintEqualToAnchor:self.titleLabel.rightAnchor constant:8],
                                                  [_contentLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor],
                                                  [_contentLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
                                                  ]];
        
        _gestureRecognizer = [[UITapGestureRecognizer alloc] init];
        [self addGestureRecognizer:_gestureRecognizer];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric, _titleLabel.intrinsicContentSize.height + 16);
}

- (void)setText:(NSString *)text forKey:(NSString *)key {}
@end
