//
//  SZFormSectionView.h
//  Form-iOS
//
//  Created by songzhou on 2018/6/18.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZFormRowView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SZFormSectionView : UIView

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic, readonly) NSArray<SZFormRowView *> *rows;

+ (instancetype)sectionViewFromJSON:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
