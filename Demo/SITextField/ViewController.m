//
//  ViewController.m
//  SITextField
//
//  Created by Sonia on 2018/11/16.
//  Copyright © 2018 Sonia. All rights reserved.
//

#import "ViewController.h"
#import "SpecialInteractionTextField.h"
#import "SpecialInteractionManager.h"
#import <SDAutoLayout.h>

#define KScreenWidth [[UIScreen mainScreen] bounds].size.width
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define K_iPhoneX (KScreenWidth == 375.f && KScreenHeight == 812.f ? YES : NO)
#define KNavigationBarHeight (K_iPhoneX ? 88.f : 64.f)

@interface ViewController ()

@property (nonatomic, strong) SpecialInteractionManager *siManager;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *reset = [[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStylePlain target:self action:@selector(reset:)];
    self.navigationItem.rightBarButtonItem = reset;
    
    UIBarButtonItem *send = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(send:)];
    self.navigationItem.leftBarButtonItem = send;
    
    UIButton *location = [UIButton buttonWithType:UIButtonTypeCustom];
    location.layer.cornerRadius = 25;
    location.layer.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1].CGColor;
    location.layer.borderColor = [UIColor colorWithRed:199/255.f green:199/255.f blue:199/255.f alpha:1].CGColor;
    location.layer.borderWidth = 1;
    location.titleLabel.font = [UIFont systemFontOfSize:16];
    [location setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [location setTitle:@"Location" forState:UIControlStateNormal];
    [self.view addSubview:location];
    
    UIButton *category = [UIButton buttonWithType:UIButtonTypeCustom];
    category.layer.cornerRadius = 25;
    category.layer.backgroundColor = [UIColor colorWithRed:249/255.f green:249/255.f blue:249/255.f alpha:1].CGColor;
    category.layer.borderColor = [UIColor colorWithRed:199/255.f green:199/255.f blue:199/255.f alpha:1].CGColor;
    category.layer.borderWidth = 1;
    category.titleLabel.font = [UIFont systemFontOfSize:16];
    [category setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [category setTitle:@"Category" forState:UIControlStateNormal];
    [self.view addSubview:category];
    
    location.sd_layout
    .topSpaceToView(self.view, 10 + KNavigationBarHeight)
    .leftSpaceToView(self.view, 20)
    .heightIs(50)
    .widthIs((KScreenWidth-50)/2);
    
    category.sd_layout
    .topSpaceToView(self.view, 10 + KNavigationBarHeight)
    .rightSpaceToView(self.view, 20)
    .heightIs(50)
    .widthRatioToView(location, 1);
    
    self.siManager = [SpecialInteractionManager new];
    
    
    SpecialInteractionTextField *siTitleTextField = [[SpecialInteractionTextField alloc] init];
    siTitleTextField.placeholder = @"Title";
    siTitleTextField.tagName = @"title";
    siTitleTextField.inputValue = @"title";
    [self.view addSubview:siTitleTextField];
    
    SpecialInteractionTextField *siPriceTextField = [[SpecialInteractionTextField alloc] init];
    siPriceTextField.placeholder = @"Price";
    siPriceTextField.tagName = @"price";
    siPriceTextField.expectedInputType = ExpectedInputTypeIntegralNumber;
    [self.view addSubview:siPriceTextField];
    
    SpecialInteractionTextField *siLocationTextField = [[SpecialInteractionTextField alloc] init];
    siLocationTextField.placeholder = @"Specific Location (optional)";
    siLocationTextField.tagName = @"location";
    [self.view addSubview:siLocationTextField];
    
    SpecialInteractionTextField *siDescriptionTextField = [[SpecialInteractionTextField alloc] init];
    siDescriptionTextField.placeholder = @"Description";
    siDescriptionTextField.tagName = @"description";
    siDescriptionTextField.expectedInputType = ExpectedInputTypeCustom;
    siDescriptionTextField.customInputCheck = ^BOOL(NSString * _Nonnull text) {
        // custom check func . return BOOL
        if ([text isEqualToString:@"123"]) {
            return YES;
        }
        return NO;
    };
    [self.view addSubview:siDescriptionTextField];
    
    SpecialInteractionTextField *siPasswordTextField = [[SpecialInteractionTextField alloc] init];
    siPasswordTextField.placeholder = @"Password";
    siPasswordTextField.tagName = @"password";
    siPasswordTextField.expectedInputType = ExpectedInputTypePassword;
    siPasswordTextField.nonEmpty = YES;
    [self.view addSubview:siPasswordTextField];
    
    SpecialInteractionTextField *siEmailTextField = [[SpecialInteractionTextField alloc] init];
    siEmailTextField.placeholder = @"Email";
    siEmailTextField.tagName = @"email";
    siEmailTextField.expectedInputType = ExpectedInputTypeEmail;
    [self.view addSubview:siEmailTextField];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:199/255.f green:199/255.f blue:199/255.f alpha:1];
    [self.view addSubview:line1];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:199/255.f green:199/255.f blue:199/255.f alpha:1];
    [self.view addSubview:line2];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor colorWithRed:199/255.f green:199/255.f blue:199/255.f alpha:1];
    [self.view addSubview:line3];
    
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = [UIColor colorWithRed:199/255.f green:199/255.f blue:199/255.f alpha:1];
    [self.view addSubview:line4];
    
    UIView *line5 = [[UIView alloc] init];
    line5.backgroundColor = [UIColor colorWithRed:199/255.f green:199/255.f blue:199/255.f alpha:1];
    [self.view addSubview:line5];
    
    UIView *line6 = [[UIView alloc] init];
    line6.backgroundColor = [UIColor colorWithRed:199/255.f green:199/255.f blue:199/255.f alpha:1];
    [self.view addSubview:line6];
    
    
    siTitleTextField.sd_layout
    .leftSpaceToView(self.view, 20)
    .topSpaceToView(location, 20)
    .heightIs(50)
    .widthIs(KScreenWidth-20);
    
    siPriceTextField.sd_layout
    .leftSpaceToView(self.view, 20)
    .topSpaceToView(siTitleTextField, 0)
    .heightIs(50)
    .widthIs((KScreenWidth-20)/3);
    
    siLocationTextField.sd_layout
    .leftSpaceToView(siPriceTextField, 10)
    .topSpaceToView(siTitleTextField, 0)
    .heightIs(50)
    .widthIs((KScreenWidth-20)/3*2);
    
    siDescriptionTextField.sd_layout
    .leftSpaceToView(self.view, 20)
    .topSpaceToView(siPriceTextField, 0)
    .heightIs(50)
    .widthIs(KScreenWidth-20);
    
    siPasswordTextField.sd_layout
    .leftSpaceToView(self.view, 20)
    .topSpaceToView(siDescriptionTextField, 0)
    .heightIs(50)
    .widthIs(KScreenWidth-20);
    
    siEmailTextField.sd_layout
    .leftSpaceToView(self.view, 20)
    .topSpaceToView(siPasswordTextField, 0)
    .heightIs(50)
    .widthIs(KScreenWidth-20);
    
    line1.sd_layout
    .leftEqualToView(siTitleTextField)
    .topEqualToView(siPriceTextField)
    .heightIs(1)
    .widthRatioToView(siTitleTextField, 1);
    
    line2.sd_layout
    .leftEqualToView(siTitleTextField)
    .topEqualToView(siDescriptionTextField)
    .heightIs(1)
    .widthRatioToView(siTitleTextField, 1);
    
    line3.sd_layout
    .leftSpaceToView(siPriceTextField, 0)
    .topEqualToView(siPriceTextField)
    .widthIs(1)
    .heightRatioToView(siPriceTextField, 1);
    
    line4.sd_layout
    .leftEqualToView(siTitleTextField)
    .topSpaceToView(siDescriptionTextField, 0)
    .heightIs(1)
    .widthRatioToView(siTitleTextField, 1);
    
    line5.sd_layout
    .leftEqualToView(siTitleTextField)
    .topSpaceToView(siPasswordTextField, 0)
    .heightIs(1)
    .widthRatioToView(siTitleTextField, 1);
    
    line6.sd_layout
    .leftEqualToView(siTitleTextField)
    .topSpaceToView(siEmailTextField, 0)
    .heightIs(1)
    .widthRatioToView(siTitleTextField, 1);
    
    [self.siManager addItem:siTitleTextField];
    [self.siManager addItem:siPriceTextField];
    [self.siManager addItem:siLocationTextField];
    [self.siManager addItem:siDescriptionTextField];
    [self.siManager addItem:siPasswordTextField];
    [self.siManager addItem:siEmailTextField];
    
    [self.siManager manageReturnKeyTypeWithLastKeyType:UIReturnKeyDone];
    
}

- (void)reset:(UIBarButtonItem *)sender {
    [self.siManager resetAllValues];
}

- (void)send:(UIBarButtonItem *)sender {
    NSLog(@"%@", [self.siManager getAllKeyValues]);
}


@end
