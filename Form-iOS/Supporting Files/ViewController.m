//
//  ViewController.m
//  Form-iOS
//
//  Created by songzhou on 2018/6/18.
//  Copyright © 2018年 songzhou. All rights reserved.
//

#import "ViewController.h"
#import "SZForm.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *form = [SZForm formFromJSON:@"sample"];
    [self.view addSubview:form];

    form.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [form.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
                                              [form.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                              [form.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
                                              [form.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                                              ]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
