//
//  ZLAddressBook.h
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/11/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const ZLAddressBookDidChangeNotification;

@interface ZLAddressBook : NSObject
@property (strong, nonatomic, readonly) NSArray *contacts;

+ (instancetype)sharedInstance;
- (void)loadContacts:(void (^)(BOOL succeeded, NSError *error))completionBlock;

@end
