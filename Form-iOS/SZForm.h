//
//  SZForm.h
//  Form-iOS
//
//  Created by songzhou on 2018/6/18.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZFormView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SZForm : NSObject

+ (instancetype)formFromJSON:(NSString *)fileName;

@property (nonatomic, readonly) NSDictionary *parameters;

- (SZFormView *)formView;
- (BOOL)validParameters;

@end

NS_ASSUME_NONNULL_END
