//
//  ZLPeoplePickerViewController.h
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/4/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLBaseTableViewController.h"

typedef NS_ENUM(NSInteger, ZLPeoplePickerViewControllerType) {
    ZLPeoplePickerViewControllerTypeSingle,
    ZLPeoplePickerViewControllerTypeMultiple,
};

@class ZLPeoplePickerViewController;

@protocol ZLPeoplePickerViewControllerDelegate <NSObject>

/**
 *  Tells the delegate that the people picker has selected a person.
 *
 *  @param peoplePicker The people picker object providing this information.
 *  @param recordId     The person's recordId in ABAddressBook
 */
- (void)peoplePickerViewControllerTypeSingle:(ZLPeoplePickerViewController *)peoplePicker didSelectPerson:(NSNumber *)recordId;

///**
// *  Tells the delegate that the people picker has returned.
// *
// *  @param peoplePicker The people picker object providing this information.
// */
//- (void)peoplePickerViewControllerTypeSingleDidReturn:(ZLPeoplePickerViewController *)peoplePicker;

/**
 *  Tells the delegate that the people picker has returned and, if the type is multiple, selected contacts.
 *
 *  @param peoplePicker The people picker object providing this information.
 *  @param people     An array of recordIds
 */
- (void)peoplePickerViewControllerTypeMultiple:(ZLPeoplePickerViewController *)peoplePicker didReturnWithSelectedPeople:(NSArray *)people;

@end

@interface ZLPeoplePickerViewController : ZLBaseTableViewController
@property (weak, nonatomic) id<ZLPeoplePickerViewControllerDelegate> delegate;
@property (nonatomic) ZLPeoplePickerViewControllerType type;

- (id)init __attribute__((unavailable("-init is not allowed, use -initWithType: instead")));
- (id)initWithStyle:(UITableViewStyle)style __attribute__((unavailable("-initWithStyle is not allowed, use -initWithType: instead")));

- (instancetype)initWithType:(ZLPeoplePickerViewControllerType)type;
+ (void)presentPeoplePickerViewControllerWithType:(ZLPeoplePickerViewControllerType)type forParentViewController:(UIViewController *)parentViewController;
@end

