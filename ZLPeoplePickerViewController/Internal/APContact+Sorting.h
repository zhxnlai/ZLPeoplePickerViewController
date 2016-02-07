//
//  APContact+Sorting.h
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/5/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import <APAddressBook/APContact.h>

@interface APContact (Sorting)

//@property (strong,nonatomic) NSArray *santrizedPhones;

- (NSString *)firstName;
- (NSString *)lastName;
- (NSString *)compositeName;

- (NSString *)firstNameOrCompositeName;
- (NSString *)lastNameOrCompositeName;
//- (NSArray *)linkedContacts;

@end
