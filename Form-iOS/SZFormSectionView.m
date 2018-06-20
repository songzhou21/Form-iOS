//
//  SZFormSectionView.m
//  Form-iOS
//
//  Created by songzhou on 2018/6/18.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import "SZFormSectionView.h"
#import "SZFormRowTextField.h"
#import "SZFormRowDatePicker.h"

@interface SZFormSectionView ()

@property (nonatomic) UIStackView *contentView;
@property (nonatomic) UIView *sectionHeader;

@end

@implementation SZFormSectionView {
    NSMutableArray<id<SZFormRowViewProtocol>> *__rowViews__;
}

- (instancetype)initWithJSON:(NSDictionary *)json {
    self = [super initWithFrame:CGRectZero];

    self.backgroundColor = [UIColor lightGrayColor];
    
    _sectionHeader = [UIView new];
    [self addSubview:_sectionHeader];
    
    _titleLabel = [UILabel new];
    [_sectionHeader addSubview:_titleLabel];
    
    _sectionHeader.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_sectionHeader.leftAnchor constraintEqualToAnchor:self.leftAnchor],
                                              [_sectionHeader.rightAnchor constraintEqualToAnchor:self.rightAnchor],
                                              [_sectionHeader.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [_sectionHeader.heightAnchor constraintEqualToConstant:30],
                                              ]];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_titleLabel.leftAnchor constraintEqualToAnchor:self.sectionHeader.leftAnchor constant:8],
                                              [_titleLabel.bottomAnchor constraintEqualToAnchor:self.sectionHeader.bottomAnchor],
                                              ]];
    
    NSString *title = json[@"title"] ?: json[@"key"];
    _titleLabel.text = title;
    
    _contentView = [UIStackView new];
    [self addSubview:_contentView];
    
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    _contentView.axis = UILayoutConstraintAxisVertical;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.contentView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
                                              [self.contentView.rightAnchor constraintEqualToAnchor:self.rightAnchor],
                                              
                                              [self.contentView.topAnchor constraintEqualToAnchor:self.sectionHeader.bottomAnchor constant:8],
                                              [self.contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
                                              ]];
    
    __rowViews__ = [NSMutableArray array];
    NSArray<NSDictionary *> *rows = json[@"rows"];
    [rows enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *type = obj[@"type"];
        NSString *key = obj[@"key"];
        
        if ([type isEqualToString:@"text-field"]) {
            SZFormRowTextField *view = [SZFormRowTextField new];
            view.key = obj[@"key"];
            view.backgroundColor = [UIColor whiteColor];
            
            [self.contentView addArrangedSubview:view];
            [self -> __rowViews__ addObject:view];
            
            view.titleLabel.text = key;
        } else if ([type isEqualToString:@"date-picker"]) {
            SZFormRowDatePicker *datePicker = [SZFormRowDatePicker new];
            datePicker.key = key;

            [self.contentView addArrangedSubview:datePicker];
            [self -> __rowViews__ addObject:datePicker];
            
            datePicker.titleLabel.text = key;
            
        } else {
            SZFormRowView *rowView = [SZFormRowView new];
            rowView.backgroundColor = [UIColor whiteColor];
            
            [self.contentView addArrangedSubview:rowView];
            [self -> __rowViews__ addObject:rowView];
            
            rowView.titleLabel.text = obj[@"key"];
        }
        
        
      
    }];
    
    return self;
}

+ (instancetype)sectionViewFromJSON:(NSDictionary *)json {
    return [[SZFormSectionView alloc] initWithJSON:json];
}

#pragma mark - getter
- (NSArray<SZFormRowView *> *)rows {
    return [__rowViews__ copy];
}
@end
