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
@property (nonatomic) NSMutableDictionary<NSString *, id> *requiredParameters;
@property (nonatomic) NSMutableDictionary<NSString *, id> *optionalParameters;

@property (nonatomic) NSMutableDictionary<NSString *, id> *inputParameters;

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
        
        [self _parseRequriedParameters:_json];
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

- (void)_parseRequriedParameters:(NSDictionary *)json {
    if (json[@"sections"]) {
        [self _parseRequiredParametersInSections:json[@"sections"]];
    }
}

- (void)_parseRequiredParametersInSections:(NSArray<NSDictionary *> *)sections {
    [sections enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [(NSArray *)obj[@"rows"] enumerateObjectsUsingBlock:^(NSDictionary  *row, NSUInteger idx, BOOL * _Nonnull stop) {
            if (row[@"required"]) {
                self.requiredParameters[row[@"key"]] = [NSNull null];
            }
        }];
    }];
}

- (void)_calculateParameters {
    [_inputParameters enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (self.requiredParameters[key]) {
            self.requiredParameters[key] = obj;
        } else {
            self.optionalParameters[key] = obj;
        }
    }];
}


#pragma mark - API
- (BOOL)validParameters {
    [self _calculateParameters];
    
    __block BOOL valid = YES;
    [_requiredParameters enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqual:[NSNull null]]) {
            valid = NO;
        }
        
        if ([obj isKindOfClass:[NSString class]]) {
            valid = [(NSString *)obj length] != 0;
        }
        
        if (!valid) {
            *stop = YES;
        }
    }];
    
    return valid;
}

#pragma mark - getter
- (NSDictionary *)parameters {
    [self _calculateParameters];
    
    NSMutableDictionary *ret = [NSMutableDictionary dictionary];
    [ret addEntriesFromDictionary:_requiredParameters];
    [ret addEntriesFromDictionary:_optionalParameters];
    
    return [ret copy];
}

#pragma mark - SZFormViewDelegate
- (void)formView:(SZFormView *)formView key:(NSString *)key value:(NSString *)value {
    _inputParameters[key]= value;
}
@end
