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

@property (nonatomic) SZForm *form;

@property (nonatomic) UIButton *confirmButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _form = [SZForm formFromJSON:@"sample"];
    SZFormView *formView = [_form formView];
    [self.view addSubview:formView];
    
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmButton setTitle:@"confirm" forState:UIControlStateNormal];
    [self.view addSubview:_confirmButton];

    // layout
    formView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [formView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
                                              [formView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                              [formView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
                                              [formView.bottomAnchor constraintEqualToAnchor:self.confirmButton.topAnchor],
                                              ]];

    
    _confirmButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_confirmButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [_confirmButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
                                              [_confirmButton.heightAnchor constraintEqualToConstant:44]
                                              ]];
    
    [_confirmButton addTarget:self action:@selector(tapOnConfrim) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapOnConfrim {
    BOOL valid = [_form validParameters];
    if (valid) {
        NSLog(@"%@", self.form.parameters);
    } else {
        NSLog(@"%@, reason:%@", self.form.parameters, [self.form firstNotValidReason]);
    }

}

@end
