//
//  SZForm.m
//  Form-iOS
//
//  Created by songzhou on 2018/6/18.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import "SZForm.h"

@interface SZForm () <SZFormViewDelegate>

@property (nonatomic) NSDictionary *json;
@property (nonatomic) NSMutableDictionary<NSString *, SZFormItem *> *requiredParameters;
@property (nonatomic) NSMutableDictionary<NSString *, SZFormItem *> *optionalParameters;

@property (nonatomic) NSMutableDictionary<NSString *, SZFormItem *> *inputParameters;

@property (nonatomic) SZFormView *formView;


@end

@implementation SZForm

- (instancetype)initWithJSON:(NSString *)fileName {
    self = [super init];
    if (self) {
        NSError *jsonError;
        _json = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:@"json"]] options:NSJSONReadingAllowFragments error:&jsonError];
        
        if (jsonError) {
            return nil;
        }
        
        _requiredParameters = [NSMutableDictionary dictionary];
        _optionalParameters = [NSMutableDictionary dictionary];
        _inputParameters = [NSMutableDictionary dictionary];
        
        [self _parseParameters:_json];
    }
    return self;
}

#pragma mark - private
- (SZFormView *)formView {
    SZFormView *view = [SZFormView formFromJSON:_json];
    view.formDelegate = self;
    
    return view;
}

+ (instancetype)formFromJSON:(NSString *)fileName {
    return [[SZForm alloc] initWithJSON:fileName];
}

- (void)_parseParameters:(NSDictionary *)json {
    if (json[@"sections"]) {
        [self _parseParametersInSections:json[@"sections"]];
    }
}

- (void)_parseParametersInSections:(NSArray<NSDictionary *> *)sections {
    [sections enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [(NSArray *)obj[@"rows"] enumerateObjectsUsingBlock:^(NSDictionary  *row, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *key = row[@"key"];
            NSString *rule = row[@"rule"];
            BOOL required = [row[@"required"] boolValue];
            
            SZFormItem *item = [SZFormItem new];
            item.type = row[@"type"];
            item.title = row[@"title"];
            item.key = key;
            
            if (required || rule) {
                item.rule = rule;
                item.reason = row[@"reason"];
                item.required = required;
                self.requiredParameters[key] = item;
            } else {
                self.optionalParameters[key] = item;
            }
        }];
    }];
}

- (void)_calculateParameters {
    [_inputParameters enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, SZFormItem * _Nonnull obj, BOOL * _Nonnull stop) {
        if (self.requiredParameters[key]) {
            self.requiredParameters[key].value = obj.value;
        } else {
            self.optionalParameters[key].value = obj.value;
        }
    }];
}


#pragma mark - API
- (BOOL)validParameters {
    [self _calculateParameters];
    
    __block BOOL valid = YES;
    [_requiredParameters enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, SZFormItem * _Nonnull obj, BOOL * _Nonnull stop) {
        if (![obj valid]) {
            *stop = YES;
            valid = NO;
        }
    }];

    return valid;
}

- (NSString * _Nullable)firstNotValidReason {
    __block SZFormItem *item;
    [_requiredParameters enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, SZFormItem * _Nonnull obj, BOOL * _Nonnull stop) {
        if (![obj valid]) {
            item = obj;
            *stop = YES;
        }
    }];
    
    return item.reason;
}

#pragma mark - getter
- (NSDictionary<NSString *,SZFormView *> *)parameters {
    [self _calculateParameters];
    
    NSMutableDictionary *ret = [NSMutableDictionary dictionary];
    [ret addEntriesFromDictionary:_requiredParameters];
    [ret addEntriesFromDictionary:_optionalParameters];
    
    return [ret copy];
}

#pragma mark - SZFormViewDelegate
- (void)formView:(SZFormView *)formView key:(NSString *)key value:(NSString *)value {
    SZFormItem *item = _inputParameters[key];
    if (!item) {
        item = [SZFormItem new];
        _inputParameters[key] = item;
    }
    
    item.key = key;
    item.value = value;
}

@end
