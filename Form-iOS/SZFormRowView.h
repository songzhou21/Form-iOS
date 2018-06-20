//
//  SZFormRowView.h
//  Form-iOS
//
//  Created by songzhou on 2018/6/18.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SZFormRowView;
@protocol SZFormRowViewProtocol;

@protocol SZFormRowViewDelegate <NSObject>

@optional
- (void)formRowView:(id<SZFormRowViewProtocol>)view didEndEditingWithText:(NSString *)text key:(NSString *)key;

@end

@protocol SZFormRowViewProtocol <NSObject>

@required
@property (nonatomic, weak) id<SZFormRowViewDelegate> rowDelegate;
@property (nonatomic, copy) NSString *key;

- (void)setText:(NSString *)text forKey:(NSString *)key;

@end

@interface SZFormRowView : UIView <SZFormRowViewProtocol>

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *contentLabel;

@property (nonatomic, weak) id<SZFormRowViewDelegate> rowDelegate;
@property (nonatomic, copy) NSString *key;
- (void)setText:(NSString *)text forKey:(NSString *)key;

@property (nonatomic) UITapGestureRecognizer *gestureRecognizer;

@end

NS_ASSUME_NONNULL_END
