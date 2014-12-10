//
//  APContact+Sorting.m
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/5/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "APContact+Sorting.h"

@implementation APContact (Sorting)
- (NSString *)firstNameOrCompositeName {
    if (self.firstName) {
        return self.firstName;
    }
    return self.compositeName;
}

- (NSString *)lastNameOrCompositeName {
    if (self.lastName) {
        return self.lastName;
    }
    return self.compositeName;
}

- (NSArray *)linkedContacts {
    return nil;
}

- (NSArray *)sanitizedPhones {
    NSMutableArray *mutableArray = [self.phones mutableCopy];
    for (int i = 0; i < mutableArray.count; i++) {
        NSString *phone = mutableArray[i];
        NSCharacterSet *setToRemove =
            [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *setToKeep = [setToRemove invertedSet];

        mutableArray[i] =
            [[phone componentsSeparatedByCharactersInSet:setToKeep]
                componentsJoinedByString:@""];
    }
    //        NSLog(@"san phones: %@", mutableArray);

    return [mutableArray copy];

    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    //        NSMutableArray *mutableArray = [self.phones mutableCopy];
    //        for (int i=0;i<mutableArray.count;i++) {
    //            NSString *phone = mutableArray[i];
    //            NSCharacterSet *setToRemove =
    //            [NSCharacterSet
    //            characterSetWithCharactersInString:@"0123456789"];
    //            NSCharacterSet *setToKeep = [setToRemove invertedSet];
    //
    //            mutableArray[i] = [[phone
    //            componentsSeparatedByCharactersInSet:setToKeep]
    //            componentsJoinedByString:@""];
    //        }
    //        sanPhones = [mutableArray copy];
    //
    //        NSLog(@"san phones: %@", sanPhones);
    //    });

    //    return sanPhones;
}

@end
