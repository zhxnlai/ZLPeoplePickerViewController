//
//  ZLAddressBook.m
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/11/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "ZLAddressBook.h"
#import "APAddressBook.h"
#import "APContact.h"

NSString *const ZLAddressBookDidChangeNotification =
    @"ZLAddressBookDidChangeNotification";

@interface ZLAddressBook ()
@property (strong, nonatomic) APAddressBook *addressBook;
@property (strong, nonatomic, readwrite) NSArray *contacts;
@end
@implementation ZLAddressBook

+ (instancetype)sharedInstance {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{ _sharedObject = [[self alloc] init]; });
    return _sharedObject;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.addressBook = [[APAddressBook alloc] init];
}

#pragma mark - APAddressBook

- (void)loadContacts:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    __weak __typeof(self) weakSelf = self;
    self.addressBook.fieldsMask =
        APContactFieldFirstName | APContactFieldLastName |
        APContactFieldCompositeName | APContactFieldPhones |
        APContactFieldThumbnail | APContactFieldRecordID |
        APContactFieldEmails | APContactFieldAddresses;
    self.addressBook.filterBlock = ^BOOL(APContact *contact) {
        return contact.compositeName != nil;
    };
    [self.addressBook loadContacts:^(NSArray *contacts, NSError *error) {
        if (!error) {
            weakSelf.contacts = contacts;
            if (completionBlock) {
                completionBlock(YES, nil);
            }
        } else {
            if (completionBlock) {
                completionBlock(NO, error);
            }
        }
    }];
    [self.addressBook startObserveChangesWithCallback:^{
        //        [weakSelf reloadData];
        [[NSNotificationCenter defaultCenter]
            postNotificationName:ZLAddressBookDidChangeNotification
                          object:nil];
    }];
}

@end
