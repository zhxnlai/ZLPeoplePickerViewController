//
//  HomeTableViewController.m
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/6/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "DemoTableViewController.h"
#import "ZLPeoplePickerViewController.h"

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface DemoTableViewController () <ABPeoplePickerNavigationControllerDelegate,ABPersonViewControllerDelegate, ZLPeoplePickerViewControllerDelegate>

@property (nonatomic, assign) ABAddressBookRef addressBookRef;

@end
@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);

    self.navigationItem.title = @"Demo";
}

#pragma mark - ZLPeoplePickerViewControllerDelegate
- (void)peoplePickerViewController:(ZLPeoplePickerViewController *)peoplePicker didSelectPerson:(NSNumber *)recordId {
    if (peoplePicker.numberOfSelectedPeople==ZLNumSelectionNone) {
        
        [self showPersonViewController:[recordId intValue]];
    }
}
- (void)peoplePickerViewController:(ZLPeoplePickerViewController *)peoplePicker didReturnWithSelectedPeople:(NSArray *)people {
    
        NSLog(@"llllog");
    
    
    NSLog(@"llllogl");

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return DemoTableViewControllerSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case DemoTableViewControllerSectionPresentationType:
            return DemoTableViewControllerSectionPresentationTypeCount;
            break;
        case DemoTableViewControllerSectionNumSelectionType:
            return DemoTableViewControllerSectionNumSelectionTypeCount;
            break;
        case DemoTableViewControllerSectionNumSelectionSlider:
            return 1;
            break;
        case DemoTableViewControllerSectionSelectionActionType:
            return DemoTableViewControllerSectionSelectionActionTypeCount;
            break;
        case DemoTableViewControllerSectionReturnActionType:
            return DemoTableViewControllerSectionReturnActionTypeCount;
            break;
        case DemoTableViewControllerSectionShowButton:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [NSString stringWithFormat:@"s%li-r%li", (long)indexPath.section, (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];}

    switch (indexPath.section) {
        case DemoTableViewControllerSectionPresentationType:
            ;
            break;
        case DemoTableViewControllerSectionNumSelectionType:

            break;
        case DemoTableViewControllerSectionNumSelectionSlider:
//            return 1;
            break;
        case DemoTableViewControllerSectionSelectionActionType:

            break;
        case DemoTableViewControllerSectionReturnActionType:
            ;
            break;
        case DemoTableViewControllerSectionShowButton:

            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    switch (indexPath.section) {
//        case DemoTableViewControllerSectionsSectionPicker:
//        {
//            ZLPeoplePickerViewController *peoplePVC = [[ZLPeoplePickerViewController alloc] init];
//            peoplePVC.delegate = self;
//            [self.navigationController pushViewController:peoplePVC animated:YES];
//        }
//            break;
//        case DemoTableViewControllerSectionsSectionPickerNav:
//        {
////            ZLPeoplePickerNavigationViewController *peoplePVCNav = [[ZLPeoplePickerNavigationViewController alloc] init];
////            [self.navigationController presentViewController:peoplePVCNav animated:YES completion:nil];
//            [ZLPeoplePickerViewController presentPeoplePickerViewControllerForParentViewController:self];
//        }
//            break;
//        case DemoTableViewControllerSectionsSectionMultiPicker:
//        {
//            [ZLPeoplePickerViewController presentPeoplePickerViewControllerForParentViewController:self];
//
//        }
//            break;
//        default:
//            break;
//    }
}

#pragma mark Display and edit a person
// Called when users tap "Display and Edit Contact" in the application. Searches for a contact named "Appleseed" in
// in the address book. Displays and allows editing of all information associated with that contact if
// the search is successful. Shows an alert, otherwise.
-(void)showPersonViewController: (ABRecordID) recordId
{
    // Search for the person named "Appleseed" in the address book
    //    NSArray *people = (NSArray *)CFBridgingRelease(ABAddressBookCopyPeopleWithName(self.addressBook, CFSTR("Appleseed")));
    ABRecordRef person = ( ABRecordRef)(ABAddressBookGetPersonWithRecordID(self.addressBookRef, recordId));
    
    //    DLog(@"record id: %i", recordId);
    // Display "Appleseed" information if found in the address book
    //    if ((people != nil) && [people count])
    if (person != NULL)
    {
        //        ABRecordRef person = (__bridge ABRecordRef)[people objectAtIndex:0];
        ABPersonViewController *picker = [[ABPersonViewController alloc] init];
        picker.personViewDelegate = self;
        picker.displayedPerson = person;
        // Allow users to edit the person’s information
        picker.allowsEditing = YES;
        picker.allowsActions = NO;
        picker.shouldShowLinkedPeople = YES;
        //        picker.displayedProperties = @[@(kABPersonPhoneProperty)];
        //        [picker setHighlightedItemForProperty:kABPersonPhoneProperty withIdentifier:0];
        [self.navigationController pushViewController:picker animated:YES];
    }
    else
    {
        // Show an alert if "Appleseed" is not in Contacts
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Could not find the person in the Contacts application"
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark ABPersonViewControllerDelegate methods
// Does not allow users to perform default actions such as dialing a phone number, when they select a contact property.
- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person
                    property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifierForValue {
    return NO;
}


@end
