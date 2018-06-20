//
//  SZForminputAccessoryView.h
//  Form-iOS
//
//  Created by songzhou on 2018/6/20.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZForminputAccessoryView : UIToolbar

@property (nonatomic, copy) void(^doneBlock)(void);

@end
