//
//  SZFormView.h
//  Form-iOS
//
//  Created by songzhou on 2018/6/18.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SZFormView : UIScrollView

+ (UIScrollView *)formFromJSON:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
