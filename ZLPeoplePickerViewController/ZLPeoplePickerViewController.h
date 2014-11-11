//
//  ZLPeoplePickerViewController.h
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/4/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLBaseTableViewController.h"

@class ZLPeoplePickerViewController;

@protocol ZLPeoplePickerViewControllerDelegate <NSObject>

/**
 *  Tells the delegate that the people picker has selected a person.
 *
 *  @param peoplePicker The people picker object providing this information.
 *  @param recordId     The person's recordId in ABAddressBook
 */
- (void)peoplePickerViewController:(ZLPeoplePickerViewController *)peoplePicker didSelectPerson:(NSNumber *)recordId;

/**
 *  Tells the delegate that the people picker has returned and, if the type is multiple, selected contacts.
 *
 *  @param peoplePicker The people picker object providing this information.
 *  @param people     An array of recordIds
 */
- (void)peoplePickerViewController:(ZLPeoplePickerViewController *)peoplePicker didReturnWithSelectedPeople:(NSArray *)people;

@end

@interface ZLPeoplePickerViewController : ZLBaseTableViewController
@property (weak, nonatomic) id<ZLPeoplePickerViewControllerDelegate> delegate;
@property (nonatomic) ZLNumSelection numberOfSelectedPeople;

+ (void)initializeAddressBook;
//- (id)init __attribute__((unavailable("-init is not allowed, use -initWithType: instead")));
- (id)initWithStyle:(UITableViewStyle)style __attribute__((unavailable("-initWithStyle is not allowed, use -init instead")));
+ (instancetype)presentPeoplePickerViewControllerForParentViewController:(UIViewController *)parentViewController;
@end

