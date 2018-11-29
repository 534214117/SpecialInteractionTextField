//
//  SpecialInteractionManager.m
//  SITextField
//
//  Created by Sonia on 2018/11/16.
//  Copyright © 2018 Sonia. All rights reserved.
//

#import "SpecialInteractionManager.h"

@interface SpecialInteractionManager ()

@property (nonatomic, strong) NSMutableArray<SpecialInteractionTextField *> *subviewArray;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *>   *formDictionary;

@end

@implementation SpecialInteractionManager

- (void)manageReturnKeyTypeWithLastKeyType:(UIReturnKeyType)returnKeyType {
    for (int i = 1; i < self.subviewArray.count; i++) {
        SpecialInteractionTextField *siTextField1 = self.subviewArray[i-1];
        SpecialInteractionTextField *siTextField2 = self.subviewArray[i];
        siTextField1.nextSITextField = siTextField2;
        siTextField1.returnKeyType = UIReturnKeyNext;
        siTextField2.returnKeyType = returnKeyType ? returnKeyType : UIReturnKeyDone;
    }
}

- (SpecialInteractionManager *(^)(SpecialInteractionTextField *))addItem {
    if (!_subviewArray) {
        _subviewArray = [NSMutableArray new];
    }
    return ^SpecialInteractionManager *(SpecialInteractionTextField *item){
        if (![self->_subviewArray containsObject:item]) {
            [self->_subviewArray addObject:item];
        }
        //block块内部再返回一个instance实例
        return self;
    };
}

- (void)addItem:(SpecialInteractionTextField *)item {
    if (![self.subviewArray containsObject:item]) {
        [self.subviewArray addObject:item];
    }
}

- (void)resetAllValues {
    for (SpecialInteractionTextField *siTextField in self.subviewArray) {
        siTextField.inputValue = @"";
    }
    [self getAllKeyValues];
}

- (NSDictionary *)getAllKeyValues {
    for (SpecialInteractionTextField *siTextField in self.subviewArray) {
        if (siTextField.tagName && siTextField.tagName.length > 0) {
            [self.formDictionary setObject:siTextField.inputValue ? siTextField.inputValue : @"" forKey:siTextField.tagName];
        }
    }
    return self.formDictionary;
}
    
- (NSDictionary *)checkAllKeyValues {
    for (SpecialInteractionTextField *siTextField in self.subviewArray) {
        if (siTextField.tagName && siTextField.tagName.length > 0) {
            [self.formDictionary setObject:siTextField.inputValue ? siTextField.inputValue : @"" forKey:siTextField.tagName];
            if (siTextField.nonEmpty && (!siTextField.inputValue || siTextField.inputValue.length <= 0)) {
                [siTextField inputNonconformityAnimation];
            }
        }
    }
    return self.formDictionary;
}

- (NSMutableArray<SpecialInteractionTextField *> *)subviewArray {
    if (!_subviewArray) {
        _subviewArray = [NSMutableArray new];
    }
    return _subviewArray;
}

- (NSMutableDictionary<NSString *,NSString *> *)formDictionary {
    if (!_formDictionary) {
        _formDictionary = [NSMutableDictionary new];
    }
    return _formDictionary;
}

@end
