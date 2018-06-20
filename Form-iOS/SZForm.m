//
//  SZForm.m
//  Form-iOS
//
//  Created by songzhou on 2018/6/18.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import "SZForm.h"
#import "SZFormView.h"


@interface SZForm ()

@property (nonatomic) NSDictionary *json;

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
        
    }
    return self;
}

#pragma mark - private
- (UIView *)form {
    return [SZFormView formFromJSON:_json];
}

+ (UIView *)formFromJSON:(NSString *)fileName {
    SZForm *form = [[SZForm alloc] initWithJSON:fileName];
    
    return [form form];
}

@end
