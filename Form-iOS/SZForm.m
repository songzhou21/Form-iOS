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
@property (nonatomic) NSMutableDictionary *requiredParameters;
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

#pragma mark - getter
- (NSDictionary *)parameters {
    return [_requiredParameters copy];
}
#pragma mark - SZFormViewDelegate
- (void)formView:(SZFormView *)formView key:(NSString *)key value:(NSString *)value {
    _requiredParameters[key]= value;
}
@end
