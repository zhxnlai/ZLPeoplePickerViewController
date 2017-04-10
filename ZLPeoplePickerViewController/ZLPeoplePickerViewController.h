//
//  ZLPeoplePickerViewController.h
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/4/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import "ZLBaseTableViewController.h"

@class ZLPeoplePickerViewController;

@protocol ZLPeoplePickerViewControllerDelegate <NSObject>

/**
 *  Tells the delegate that the people picker has selected a person.
 *
 *  @param peoplePicker The people picker object providing this information.
 *  @param recordId     The person's recordId in ABAddressBook
 */
- (void)peoplePickerViewController:(nonnull ZLPeoplePickerViewController *)peoplePicker
                   didSelectPerson:(nonnull NSNumber * )recordId;

/**
 *  Tells the delegate that the people picker has returned and, if the type is
 *multiple, selected contacts.
 *
 *  @param peoplePicker The people picker object providing this information.
 *  @param people     An set of recordIds
 */
- (void)peoplePickerViewController:(nonnull ZLPeoplePickerViewController *)peoplePicker
       didReturnWithSelectedPeople:(nonnull NSSet *)people;

/**
 *  Tells the delegate that the people picker's ABNewPersonViewController did complete
 *  with a new person (can be NULL)
 *
 *  @param person     A valid person that was saved into the Address Book, otherwise NULL
 */

-(void)newPersonViewControllerDidCompleteWithNewPerson:(nullable ABRecordRef)person;

@end

@interface ZLPeoplePickerViewController : ZLBaseTableViewController
@property (weak, nonatomic, nullable) id<ZLPeoplePickerViewControllerDelegate> delegate;
@property (nonatomic) ZLNumSelection numberOfSelectedPeople;
@property (nonatomic, assign) BOOL allowAddPeople;
@property (nonatomic, strong) UISearchController *searchController;

+ (void)initializeAddressBook;
//- (id)init __attribute__((unavailable("-init is not allowed, use
//-initWithType: instead")));
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style __attribute__((unavailable(
                        "-initWithStyle is not allowed, use -init instead")));
+ (nonnull instancetype)presentPeoplePickerViewControllerForParentViewController:
        (nullable __kindof id<ZLPeoplePickerViewControllerDelegate>)parentViewController;
@end
