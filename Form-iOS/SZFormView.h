//
//  SZFormView.h
//  Form-iOS
//
//  Created by songzhou on 2018/6/18.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SZFormView;
@protocol SZFormViewDelegate <NSObject>

@optional
- (void)formView:(SZFormView *)formView key:(NSString *)key value:(NSString *)value;

@end

@interface SZFormView : UIScrollView

+ (SZFormView *)formFromJSON:(NSDictionary *)json;

@property (nonatomic, weak) id<SZFormViewDelegate> formDelegate;

@end

NS_ASSUME_NONNULL_END
