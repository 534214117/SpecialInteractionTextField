//
//  SpecialInteractionTextField.m
//  SITextField
//
//  Created by Sonia on 2018/11/16.
//  Copyright © 2018 Sonia. All rights reserved.
//

#import "SpecialInteractionTextField.h"
#import "KeepRemindingAnimationView.h"
#import "EnhancedInteractionTextField.h"
#import <POP.h>

#define DefaultFont [UIFont systemFontOfSize:16]
#define DefaultTintFont [UIFont systemFontOfSize:12]
#define DefaultPlaceholderColor [UIColor lightGrayColor]
#define DefaultPlaceholderTintColor [UIColor colorWithRed:0 green:122/255.f blue:1 alpha:1]
#define DefaultPlaceholder @"placeholder"
#define DefaultShowFocusAnimation YES
#define DefaultClearButtonMode UITextFieldViewModeWhileEditing
#define DefaultSpecialTypeInputCheck YES
#define DefaultNonEmpty NO


@interface SpecialInteractionTextField () <UITextFieldDelegate>

@property (nonatomic, strong) EnhancedInteractionTextField  *eiTextField;
@property (nonatomic, strong) KeepRemindingAnimationView    *kraView;
@property (nonatomic, strong) NSString                      *prefixString;
@property (nonatomic, assign) BOOL                           animating;

@end

@implementation SpecialInteractionTextField


#pragma mark - Public Func

- (void)beFirstResponder {
    [self.eiTextField becomeFirstResponder];
}


#pragma mark- Func
- (void)specialInputCheck {
    if (self.expectedInputType == ExpectedInputTypeEmail && ![self checkEmail:self.eiTextField.text]) {
        [self inputNonconformityAnimation];
    }
    else if (self.expectedInputType == ExpectedInputTypeNumber && ![self checkNumber:self.eiTextField.text]) {
        [self inputNonconformityAnimation];
    }
    else if (self.expectedInputType == ExpectedInputTypeIntegralNumber && ![self checkIntegralNumber:self.eiTextField.text]) {
        [self inputNonconformityAnimation];
    }
    else if (self.expectedInputType == ExpectedInputTypeCustom && self.customInputCheck) {
        if (self.customInputCheck && !self.customInputCheck(self.inputValue)) {
            [self inputNonconformityAnimation];
        }
    }
}

- (BOOL)checkEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)checkNumber:(NSString *)number {
    NSScanner* scan = [NSScanner scannerWithString:number];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

- (BOOL)checkIntegralNumber:(NSString *)integralNumber {
    NSScanner* scan = [NSScanner scannerWithString:integralNumber];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd] && [[integralNumber substringToIndex:1] intValue] != 0;
}

- (void)defaultSetting {
    self.eiTextField.secureTextEntry = NO;
    self.eiTextField.clearButtonMode = DefaultClearButtonMode;
}

- (void)emailSetting {
    [self defaultSetting];
    self.eiTextField.keyboardType = UIKeyboardTypeEmailAddress;
}

- (void)numberSetting {
    [self defaultSetting];
    self.eiTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}

- (void)integralNumberSetting {
    [self defaultSetting];
    self.eiTextField.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)passwordSetting {
    self.eiTextField.secureTextEntry = YES;
    self.eiTextField.clearButtonMode = UITextFieldViewModeNever;
}


#pragma mark - Animation
- (void)beginFocusAnimation {
    CGRect startFrame = CGRectMake(CGRectGetMinX(self.eiTextField.frame) + 5, CGRectGetHeight(self.eiTextField.frame)/2.f, 0, 0);
    __block UIView *focusAnimatView = [[UIView alloc] initWithFrame:startFrame];
    focusAnimatView.layer.backgroundColor = [UIColor darkGrayColor].CGColor;
    focusAnimatView.layer.cornerRadius = 0;
    focusAnimatView.alpha = 0.5;
    
    [self.eiTextField addSubview:focusAnimatView];
    
    CGPoint center = focusAnimatView.center;
    
    [UIView animateWithDuration:0.3 animations:^{
        focusAnimatView.frame = CGRectMake(0, 0, CGRectGetHeight(self.eiTextField.frame) * 2, CGRectGetHeight(self.eiTextField.frame) * 2);
        focusAnimatView.layer.cornerRadius = focusAnimatView.frame.size.height / 2.f;
        focusAnimatView.center = center;
        focusAnimatView.alpha = 0;
    } completion:^(BOOL finished) {
        [focusAnimatView removeFromSuperview];
        focusAnimatView = nil;
    }];
}

- (void)inputTextAnimation {
    [self.kraView hideFakePlaceholderAndShowSmallTip];
}

- (void)clearTextAnimation {
    [self.kraView hideSmallTipAndShowFakePlaceholder];
}

- (void)inputNonconformityAnimation {
    self.animating = YES;
    [self.eiTextField.layer pop_removeAllAnimations];
    UIColor *color = self.backgroundColor ? self.backgroundColor : [UIColor clearColor];
    
    POPSpringAnimation *colorResetSpringAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    colorResetSpringAnimation.beginTime = CACurrentMediaTime();
    colorResetSpringAnimation.toValue = color;
    [colorResetSpringAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [self.eiTextField.layer pop_removeAllAnimations];
        self.animating = NO;
    }];
    
    POPSpringAnimation *colorSpringAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    colorSpringAnimation.beginTime = CACurrentMediaTime();
    colorSpringAnimation.toValue = [UIColor colorWithRed:220/255.f green:53/255.f blue:69/255.f alpha:0.5];
    [colorSpringAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [self.eiTextField.layer pop_addAnimation:colorResetSpringAnimation forKey:@"colorResetSpringAnimation"];
    }];
    [self.eiTextField.layer pop_addAnimation:colorSpringAnimation forKey:@"colorSpringAnimation"];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.showFocusAnimation && !self.animating) {
        [self beginFocusAnimation];
        self.kraView.placeholderTintColor = self.placeholderTintColor;
    }
    return !self.animating;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text && textField.text.length > 0) {
        self.kraView.placeholderTintColor = self.kraView.placeholderColor;
        if (self.specialTypeInputCheck) {
            [self specialInputCheck];
        }
    }
    else if (self.nonEmpty) {
        [self inputNonconformityAnimation];
    }
    
    // mark 当UITextField scurety == YES 时，诡异的问题
    // 用户输入密码endEditing后 重新focus该TextField然后按键盘输出键，会直接删除所有密码 （到这里都没什么问题）
    // 但是这样的操作在下面的Delegate方法中，竟然判定是只删了一个字符，所以这里对password模式做了特殊处理
    if (self.expectedInputType == ExpectedInputTypePassword && (!textField.text || textField.text.length == 0)) {
        [self clearTextAnimation];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    _inputValue = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ((!textField.text || textField.text.length == 0) && (string && string.length > 0)) {
        [self inputTextAnimation];
    }
    if (textField.text.length == range.length && string.length == 0) {
        [self clearTextAnimation];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [self clearTextAnimation];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.returnKeyType == UIReturnKeyNext && self.nextSITextField) {
        [self.nextSITextField beFirstResponder];
    }
    else if (textField.returnKeyType == UIReturnKeyDone) {
        [self.eiTextField resignFirstResponder];
    }
    return YES;
}


#pragma mark - Initialize & FrameSet
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if (!self.eiTextField || !self.kraView) {
        CGRect textFieldFrame = frame;
        textFieldFrame.origin.x = 0;
        textFieldFrame.origin.y = frame.size.height * 1 / 3.f;
        textFieldFrame.size.height = frame.size.height * 2 / 3.f;
        self.kraView        = [[KeepRemindingAnimationView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.eiTextField    = [[EnhancedInteractionTextField alloc] initWithFrame:textFieldFrame];
        self.eiTextField.clearButtonMode = DefaultClearButtonMode;
        self.eiTextField.delegate = self;
        self.font = DefaultFont;
        self.tintFont = DefaultTintFont;
        self.placeholderColor = DefaultPlaceholderColor;
        self.placeholderTintColor = DefaultPlaceholderTintColor;
        self.placeholder = DefaultPlaceholder;
        self.showFocusAnimation = DefaultShowFocusAnimation;
        self.specialTypeInputCheck = DefaultSpecialTypeInputCheck;
        self.nonEmpty = DefaultNonEmpty;
        [self addSubview:self.kraView];
        [self addSubview:self.eiTextField];
    }
    else {
        CGRect textFieldFrame = frame;
        textFieldFrame.origin.x = 0;
        textFieldFrame.origin.y = frame.size.height * 1 / 3.f;
        textFieldFrame.size.height = frame.size.height * 2 / 3.f;
        self.kraView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.eiTextField.frame = textFieldFrame;
    }
}


#pragma mark - Override

- (void)setInputValue:(NSString *)inputValue {
    _inputValue = inputValue;
    _eiTextField.text = inputValue;
    if (!inputValue || inputValue.length == 0) {
        [self clearTextAnimation];
    }
    else {
        [self inputTextAnimation];
    }
}

- (void)setFont:(UIFont *)font {
    _font = font;
    _eiTextField.font = font;
    _kraView.font = font;
}

- (void)setTintFont:(UIFont *)tintFont {
    _tintFont = tintFont;
    _kraView.tintFont = tintFont;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _kraView.placeholder = placeholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    _kraView.placeholderColor = placeholderColor;
}

- (void)setPlaceholderTintColor:(UIColor *)placeholderTintColor {
    _placeholderTintColor = placeholderTintColor;
    _kraView.placeholderTintColor = placeholderTintColor;
}

- (void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode {
    _clearButtonMode = clearButtonMode;
    _eiTextField.clearButtonMode = clearButtonMode;
}

- (void)setExpectedInputType:(ExpectedInputType)expectedInputType {
    _expectedInputType = expectedInputType;
    int type = expectedInputType;
    switch (type) {
        case ExpectedInputTypeDefault:
            [self defaultSetting];
            break;
        case ExpectedInputTypePassword:
            [self passwordSetting];
            break;
        case ExpectedInputTypeEmail:
            [self emailSetting];
            break;
        case ExpectedInputTypeNumber:
            [self numberSetting];
            break;
        case ExpectedInputTypeIntegralNumber:
            [self integralNumberSetting];
            break;
        case ExpectedInputTypeCustom:
            [self defaultSetting];
            break;
            
        default:
            break;
    }
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    _keyboardType = keyboardType;
    _eiTextField.keyboardType = keyboardType;
}

- (void)setReturnKeyType:(UIReturnKeyType)returnKeyType {
    _returnKeyType = returnKeyType;
    _eiTextField.returnKeyType = returnKeyType;
}

@end
