//
//  SZFormView.m
//  Form-iOS
//
//  Created by songzhou on 2018/6/18.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import "SZFormView.h"
#import "SZFormSectionView.h"

@interface SZFormView ()

@property (nonatomic) NSDictionary *json;

@property (nonatomic) UIStackView *stackView;

@property (nonatomic) NSArray<SZFormSectionView *> *sectionViews;

@end

@implementation SZFormView

- (instancetype)initWithJSON:(NSDictionary *)json {
    self = [super initWithFrame:CGRectZero];
    
    self.backgroundColor = [UIColor whiteColor];
    self.alwaysBounceVertical = YES;
    
    _json = json;
    
    _stackView = [UIStackView new];
//    _stackView.distribution = UIStackViewDistributionEqualSpacing;
    _stackView.spacing = 8;
    _stackView.axis = UILayoutConstraintAxisVertical;
    
    [self addSubview:_stackView];
    _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_stackView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
                                              [_stackView.rightAnchor constraintEqualToAnchor:self.rightAnchor],
                                              [_stackView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [_stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
                                              ]];
    [_stackView.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    NSLayoutConstraint *heightConstraint = [_stackView.heightAnchor constraintEqualToAnchor:self.heightAnchor];
    heightConstraint.priority = UILayoutPriorityDefaultLow;
    heightConstraint.active = YES;
    
    if (_json[@"sections"]) {
        [self _sectionView];
    }
    
    return self;
}

#pragma mark - private
- (void)_sectionView {
    NSArray<NSDictionary *> *sections = _json[@"sections"];
    [_sectionViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSMutableArray<SZFormSectionView *> *sectionViews = [NSMutableArray array];
    [sections enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SZFormSectionView *sectionView = [SZFormSectionView sectionViewFromJSON:obj];
        
        [sectionViews addObject:sectionView];;
    }];
    
    _sectionViews = [sectionViews copy];
    
    [_sectionViews enumerateObjectsUsingBlock:^(SZFormSectionView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.stackView addArrangedSubview:obj];
    }];
}

+ (UIView *)formFromJSON:(NSDictionary *)json {
    return [[SZFormView alloc] initWithJSON:json];
}
@end
