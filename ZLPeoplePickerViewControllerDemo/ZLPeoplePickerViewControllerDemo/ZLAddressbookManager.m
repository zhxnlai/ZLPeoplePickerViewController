//
//  ZLAddressbookManager.m
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/4/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "ZLAddressbookManager.h"
#import "APAddressBook.h"
#import "APContact.h"

@interface ZLAddressbookManager ()
@property (strong, nonatomic) APAddressBook *addressBook;
@end

@implementation ZLAddressbookManager

#pragma mark - Initialization

+ (id)sharedInstance {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (self) {
        // this is important
        self.addressBook = [[APAddressBook alloc] init];


    }
    return self;
}




@end
