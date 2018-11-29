//
//  SpecialInteractionTextField.h
//  SITextField
//
//  Created by Sonia on 2018/11/16.
//  Copyright © 2018 Sonia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ExpectedInputType) {
    ExpectedInputTypeDefault,
    ExpectedInputTypePassword,
    ExpectedInputTypeEmail,
    ExpectedInputTypeNumber,
    ExpectedInputTypeIntegralNumber,
    ExpectedInputTypeCustom,
};


@interface SpecialInteractionTextField : UIView

//建议初始化高度50
//高度变化时 请自行调整font/tintFont大小

@property (nonatomic, strong) NSString      *inputValue;
@property (nonatomic, strong) NSString      *placeholder;
@property (nonatomic, strong) UIColor       *placeholderColor;
@property (nonatomic, strong) UIColor       *placeholderTintColor;
@property (nonatomic, strong) NSString      *tagName;
@property (nonatomic, strong) UIFont        *font;
@property (nonatomic, strong) UIFont        *tintFont;
@property (nonatomic) UITextFieldViewMode    clearButtonMode;
@property (nonatomic) ExpectedInputType      expectedInputType;
@property (nonatomic) UIKeyboardType         keyboardType;
@property (nonatomic, assign) BOOL           showFocusAnimation;
@property (nonatomic, assign) BOOL           specialTypeInputCheck;
@property (nonatomic, assign) BOOL           nonEmpty;


@property (nonatomic, copy)  BOOL  (^customInputCheck)(NSString *text);


// 最好用SpecialInteractionManager操作该值
@property (nonatomic) UIReturnKeyType        returnKeyType;
@property (nonatomic, strong) SpecialInteractionTextField *nextSITextField;

- (void)beFirstResponder;
- (void)inputNonconformityAnimation;

@end

NS_ASSUME_NONNULL_END
