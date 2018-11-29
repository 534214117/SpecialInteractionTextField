//
//  KeepRemindingAnimationView.h
//  SITextField
//
//  Created by Sonia on 2018/11/16.
//  Copyright © 2018 Sonia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeepRemindingAnimationView : UIView

@property (nonatomic, strong) NSString      *placeholder;
@property (nonatomic, strong) UIColor       *placeholderColor;
@property (nonatomic, strong) UIColor       *placeholderTintColor;
@property (nonatomic, strong) UIFont        *font;
@property (nonatomic, strong) UIFont        *tintFont;

- (void)hideFakePlaceholderAndShowSmallTip;
- (void)hideSmallTipAndShowFakePlaceholder;

@end

NS_ASSUME_NONNULL_END
