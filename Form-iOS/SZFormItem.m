//
//  SZFormItem.m
//  Form-iOS
//
//  Created by songzhou on 2018/6/20.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import "SZFormItem.h"

@implementation SZFormItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        _required = NO;
    }
    return self;
}

- (BOOL)required {
    if (_rule) {
        return YES;
    }
    
    return _required;
}

- (NSString *)reason {
    if (_reason) {
        return _reason;
    }
    
    if (self.required) {
        return [NSString stringWithFormat:@"%@ is requierd", _title ?: _key];
    }
    
    return nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@>:%@", NSStringFromClass(self.class), _value];
}

#pragma mark - API
- (BOOL)valid {
    if (self.value.length > 0) {
        return YES;
    }
    
    return NO;
}
@end
