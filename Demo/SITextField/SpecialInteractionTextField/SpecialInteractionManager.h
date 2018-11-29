//
//  SpecialInteractionManager.h
//  SITextField
//
//  Created by Sonia on 2018/11/16.
//  Copyright © 2018 Sonia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpecialInteractionTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface SpecialInteractionManager : NSObject

- (void)addItem:(SpecialInteractionTextField *)item;
//把所有的输入框添加到SpecialInteractionManager类后，再调用此方法
- (void)manageReturnKeyTypeWithLastKeyType:(UIReturnKeyType)returnKeyType;
- (void)resetAllValues;
- (NSDictionary *)checkAllKeyValues;
- (NSDictionary *)getAllKeyValues;

@end

NS_ASSUME_NONNULL_END
