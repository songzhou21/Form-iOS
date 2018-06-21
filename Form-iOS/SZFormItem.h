//
//  SZFormItem.h
//  Form-iOS
//
//  Created by songzhou on 2018/6/20.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SZFormItem : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *rule;
@property (nonatomic, copy, nullable) NSString *reason;
@property (nonatomic) BOOL required;

@property (nonatomic, copy, nullable) NSString *value;

- (BOOL)valid;

@end

NS_ASSUME_NONNULL_END
