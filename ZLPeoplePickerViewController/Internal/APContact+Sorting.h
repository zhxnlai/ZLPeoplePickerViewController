//
//  APContact+Sorting.h
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/5/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "APContact.h"

@interface APContact (Sorting)

//@property (strong,nonatomic) NSArray *santrizedPhones;

- (NSString *)firstNameOrCompositeName;
- (NSString *)lastNameOrCompositeName;
//- (NSArray *)linkedContacts;

@end
