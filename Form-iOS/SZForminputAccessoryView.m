//
//  SZForminputAccessoryView.m
//  Form-iOS
//
//  Created by songzhou on 2018/6/20.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import "SZForminputAccessoryView.h"

@implementation SZForminputAccessoryView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, 0, 44)];
    if (self) {
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        self.items = @[flexItem, doneItem];
    }
    return self;
}

- (void)done {
    if (self.doneBlock) {
        self.doneBlock();
    }
}
@end
