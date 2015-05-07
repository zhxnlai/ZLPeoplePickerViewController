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
#import <MessageUI/MessageUI.h>

static int numSelectionSliderMaxValue = 10;

@interface DemoTableViewController () <
    ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate,
    ZLPeoplePickerViewControllerDelegate, MFMailComposeViewControllerDelegate>
@property (nonatomic, assign) ABAddressBookRef addressBookRef;

@property (nonatomic, strong) ZLPeoplePickerViewController *peoplePicker;

@property (strong, nonatomic) UISegmentedControl *presentationSegmentedControl;
@property (strong, nonatomic) UISegmentedControl *numSelectionSegmentedControl;
@property (strong, nonatomic) UISlider *numSelectionSlider;
@property (strong, nonatomic) UILabel *numSelectionLabel;
@property (strong, nonatomic) UISegmentedControl *fieldMaskSegmentedControl;
@property (strong, nonatomic)
    UISegmentedControl *selectionActionSegmentedControl;
@property (strong, nonatomic) UISegmentedControl *returnActionSegmentedControl;
@end

@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ZLPeoplePickerViewController";

    _addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    [ZLPeoplePickerViewController initializeAddressBook];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self numSelectionSegmentedControlAction:self.numSelectionSegmentedControl];
}

- (void)numSelectionSegmentedControlAction:(UISegmentedControl *)control {
    self.selectionActionSegmentedControl.enabled =
        control.selectedSegmentIndex ==
        DemoTableViewControllerSectionNumSelectionTypeNone;
    self.returnActionSegmentedControl.enabled =
        control.selectedSegmentIndex ==
        DemoTableViewControllerSectionNumSelectionTypeMax;
    self.numSelectionSlider.enabled =
        control.selectedSegmentIndex ==
        DemoTableViewControllerSectionNumSelectionTypeCustom;

    if (self.numSelectionSlider.enabled) {
        [self numSelectionSliderAction:self.numSelectionSlider];
    }
}

- (void)numSelectionSliderAction:(UISlider *)slider {
    self.numSelectionLabel.text = [self customNumSelectionTypeDescription];

    self.selectionActionSegmentedControl.enabled =
        [self customNumSelectionType] == ZLNumSelectionNone;
    self.returnActionSegmentedControl.enabled =
        [self customNumSelectionType] != ZLNumSelectionNone;
}

#pragma mark - ZLPeoplePickerViewControllerDelegate
- (void)peoplePickerViewController:(ZLPeoplePickerViewController *)peoplePicker
                   didSelectPerson:(NSNumber *)recordId {
    if (peoplePicker.numberOfSelectedPeople == ZLNumSelectionNone) {
        if (self.selectionActionSegmentedControl.selectedSegmentIndex ==
            DemoTableViewControllerSectionSelectionActionTypePersonViewController) {
            [self showPersonViewController:[recordId intValue]
                    onNavigationController:peoplePicker.navigationController];
        } else {
            [peoplePicker
                presentViewController:
                    [self alertControllerWithTitle:@"You have selected:"
                                           Message:[self firstNameForPerson:
                                                             recordId]]
                             animated:YES
                           completion:nil];
        }
    }
}
- (void)peoplePickerViewController:(ZLPeoplePickerViewController *)peoplePicker
       didReturnWithSelectedPeople:(NSArray *)people {
    if (!people || people.count == 0) {
        return;
    }

    if (self.returnActionSegmentedControl.selectedSegmentIndex ==
        DemoTableViewControllerSectionReturnActionTypeEmail) {
        NSArray *toRecipients = [self emailsForPeople:people];
        [self showMailPicker:toRecipients];
    } else {
        [self
            presentViewController:
                [self alertControllerWithTitle:@"Return with selected people:"
                                       Message:
                                           [[self firstNameForPeople:people]
                                               componentsJoinedByString:@", "]]
                         animated:YES
                       completion:nil];
    }
}
- (void)newPersonViewControllerDidCompleteWithNewPerson:
        (nullable ABRecordRef)person {
    NSLog(@"Added a new person");
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return DemoTableViewControllerSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
    if (section == DemoTableViewControllerSectionNumSelectionType) {
        return DemoTableViewControllerSectionNumSelectionTypeRowCount;
    }
    if (section == DemoTableViewControllerSectionActionType) {
        return DemoTableViewControllerSectionActionTypeRowCount;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier =
        [NSString stringWithFormat:@"s%li-r%li", (long)indexPath.section,
                                   (long)indexPath.row];
    UITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellIdentifier];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    switch (indexPath.section) {
    case DemoTableViewControllerSectionPresentationType: {
        cell.textLabel.text = @"Segue Type";
        UISegmentedControl *control =
            [[UISegmentedControl alloc] initWithItems:@[ @"Push", @"Modal" ]];
        control.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        control.selectedSegmentIndex = 0;
        cell.accessoryView = control;
        self.presentationSegmentedControl = control;
    } break;
    case DemoTableViewControllerSectionNumSelectionType: {
        switch (indexPath.row) {
        case DemoTableViewControllerSectionNumSelectionTypeRowSegmentedControl: {
            cell.textLabel.text = @"NumSelectedPeople";
            UISegmentedControl *control = [[UISegmentedControl alloc]
                initWithItems:@[ @"None", @"Max", @"Custom" ]];
            control.selectedSegmentIndex = 0;
            cell.accessoryView = control;
            [control addTarget:self
                          action:@selector(numSelectionSegmentedControlAction:)
                forControlEvents:UIControlEventValueChanged];
            self.numSelectionSegmentedControl = control;
        } break;
        case DemoTableViewControllerSectionNumSelectionTypeRowSlider: {
            cell.textLabel.text = [self customNumSelectionTypeDescription];
            self.numSelectionLabel = cell.textLabel;
            UISlider *control = [[UISlider alloc] init];
            control.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            cell.accessoryView = control;
            [control addTarget:self
                          action:@selector(numSelectionSliderAction:)
                forControlEvents:UIControlEventValueChanged];
            self.numSelectionSlider = control;
        }
        default:
            break;
        }

    } break;
    case DemoTableViewControllerSectionFieldMaskType: {
        cell.textLabel.text = @"FieldMask";
        UISegmentedControl *control = [[UISegmentedControl alloc]
            initWithItems:@[ @"All", @"Phones", @"Emails", @"Photo" ]];
        control.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        control.selectedSegmentIndex = 0;
        cell.accessoryView = control;
        self.fieldMaskSegmentedControl = control;
    } break;
    case DemoTableViewControllerSectionActionType: {
        switch (indexPath.row) {
        case DemoTableViewControllerSectionActionTypeRowSelection: {
            cell.textLabel.text = @"DidSelectAction";
            UISegmentedControl *control = [[UISegmentedControl alloc]
                initWithItems:@[ @"PersonVC", @"Alert" ]];
            control.selectedSegmentIndex = 0;
            control.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            cell.accessoryView = control;
            self.selectionActionSegmentedControl = control;
        } break;
        case DemoTableViewControllerSectionActionTypeRowReturn: {
            cell.textLabel.text = @"DidReturnAction";
            UISegmentedControl *control = [[UISegmentedControl alloc]
                initWithItems:@[ @"Send Emails", @"Alert" ]];
            control.selectedSegmentIndex = 0;
            control.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            cell.accessoryView = control;
            self.returnActionSegmentedControl = control;
        }
        default:
            break;
        }

    } break;
    case DemoTableViewControllerSectionShowButton:
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.text = @"Show People Picker";
        cell.textLabel.textColor = self.view.tintColor;
        break;
    default:
        break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section != DemoTableViewControllerSectionShowButton) {
        return;
    }

    if (self.presentationSegmentedControl.selectedSegmentIndex ==
        DemoTableViewControllerSectionPresentationTypeNormal) {
        self.peoplePicker = [[ZLPeoplePickerViewController alloc] init];
        self.peoplePicker.delegate = self;
        [self.navigationController pushViewController:self.peoplePicker
                                             animated:YES];
    } else {
        self.peoplePicker = [ZLPeoplePickerViewController
            presentPeoplePickerViewControllerForParentViewController:self];
    }

    if (self.fieldMaskSegmentedControl.selectedSegmentIndex ==
        DemoTableViewControllerSectionFieldMaskTypeAll) {
        self.peoplePicker.filedMask = ZLContactFieldAll;
    } else if (self.fieldMaskSegmentedControl.selectedSegmentIndex ==
        DemoTableViewControllerSectionFieldMaskTypePhones) {
        self.peoplePicker.filedMask = ZLContactFieldPhones;
    } else if (self.fieldMaskSegmentedControl.selectedSegmentIndex ==
               DemoTableViewControllerSectionFieldMaskTypeEmails) {
        self.peoplePicker.filedMask = ZLContactFieldEmails;
    } else {
        self.peoplePicker.filedMask = ZLContactFieldPhoto;
    }

    if (self.numSelectionSegmentedControl.selectedSegmentIndex ==
        DemoTableViewControllerSectionNumSelectionTypeNone) {
        self.peoplePicker.numberOfSelectedPeople = ZLNumSelectionNone;
    } else if (self.numSelectionSegmentedControl.selectedSegmentIndex ==
               DemoTableViewControllerSectionNumSelectionTypeMax) {
        self.peoplePicker.numberOfSelectedPeople = ZLNumSelectionMax;
    } else {
        self.peoplePicker.numberOfSelectedPeople =
            [self customNumSelectionType];
    }
}

#pragma mark Display and edit a person
- (void)showPersonViewController:(ABRecordID)recordId
          onNavigationController:
              (UINavigationController *)navigationController {
    ABRecordRef person = (ABRecordRef)(
        ABAddressBookGetPersonWithRecordID(self.addressBookRef, recordId));

    if (person != NULL) {
        ABPersonViewController *picker = [[ABPersonViewController alloc] init];
        picker.personViewDelegate = self;
        picker.displayedPerson = person;
        // Allow users to edit the person’s information
        picker.allowsEditing = YES;
        picker.allowsActions = NO;
        picker.shouldShowLinkedPeople = YES;
        [navigationController pushViewController:picker animated:YES];
    } else {
        // Show an alert if "Appleseed" is not in Contacts
        UIAlertView *alert =
            [[UIAlertView alloc] initWithTitle:@"Error"
                                       message:@"Could not find the person in "
                                       @"the Contacts application"
                                      delegate:nil
                             cancelButtonTitle:@"Cancel"
                             otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark ABPersonViewControllerDelegate methods
// Does not allow users to perform default actions such as dialing a phone
// number, when they select a contact property.
- (BOOL)personViewController:(ABPersonViewController *)personViewController
    shouldPerformDefaultActionForPerson:(ABRecordRef)person
                               property:(ABPropertyID)property
                             identifier:
                                 (ABMultiValueIdentifier)identifierForValue {
    return NO;
}

#pragma mark - Compose Mail/SMS
- (void)displayMailComposerSheet:(NSArray *)recipients {
    MFMailComposeViewController *picker =
        [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setToRecipients:recipients];
    [picker setSubject:@"Check Out ZLPeoplePickerViewController!"];
    NSString *emailBody = @"Check Out ZLPeoplePickerViewController at "
        @"https://github.com/zhxnlai/" @"ZLPeoplePickerViewController";
    [picker setMessageBody:emailBody isHTML:NO];

    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)showMailPicker:(NSArray *)recipients {
    // You must check that the current device can send email messages before you
    // attempt to create an instance of MFMailComposeViewController.  If the
    // device can not send email messages,
    // [[MFMailComposeViewController alloc] init] will return nil.  Your app
    // will crash when it calls -presentViewController:animated:completion: with
    // a nil view controller.
    if ([MFMailComposeViewController canSendMail])
    // The device can send email.
    {
        [self displayMailComposerSheet:recipients];
    } else
    // The device can not send email.
    {
        UIAlertView *alert = [[UIAlertView alloc]
                initWithTitle:@"Cannot send text"
                      message:@"Device not configured to send email."
                     delegate:self
            cancelButtonTitle:@"OK"
            otherButtonTitles:nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    // Notifies users about errors associated with the interface
    switch (result) {
    case MFMailComposeResultCancelled:
        break;
    case MFMailComposeResultSaved:
        break;
    case MFMailComposeResultSent:
        break;
    case MFMailComposeResultFailed:
        break;
    default:
        //            self.feedbackMsg.text = @"Result: Mail not sent";
        break;
    }

    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - ()
- (NSString *)customNumSelectionTypeDescription {
    return [NSString stringWithFormat:@"Custom: %lu Selected People",
                                      [self customNumSelectionType]];
}
- (ZLNumSelection)customNumSelectionType {
    return self.numSelectionSlider.value * numSelectionSliderMaxValue;
}
- (UIAlertController *)alertControllerWithTitle:(NSString *)title
                                        Message:(NSString *)message {
    UIAlertController *alert = [UIAlertController
        alertControllerWithTitle:title
                         message:message
                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction
        actionWithTitle:@"OK"
                  style:UIAlertActionStyleDefault
                handler:^(UIAlertAction *action) {
                  [alert dismissViewControllerAnimated:YES completion:nil];
                }];
    [alert addAction:ok];
    return alert;
}
- (NSArray *)emailsForPeople:(NSArray *)recordIds {
    NSMutableArray *emails = [NSMutableArray array];
    for (NSNumber *recordId in recordIds) {
        [emails addObjectsFromArray:[self emailsForPerson:recordId]];
    }
    return emails;
}
- (NSArray *)emailsForPerson:(NSNumber *)recordId {
    return [self arrayProperty:kABPersonEmailProperty
                    fromRecord:[self recordRefFromRecordId:recordId]];
}
- (NSArray *)firstNameForPeople:(NSArray *)recordIds {
    NSMutableArray *firstNames = [NSMutableArray array];
    for (NSNumber *recordId in recordIds) {
        NSString *firstName = [self firstNameForPerson:recordId];
        if (firstName) {
            [firstNames addObject:firstName];
        }
    }
    return firstNames;
}
- (NSString *)firstNameForPerson:(NSNumber *)recordId {
    NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(
        [self recordRefFromRecordId:recordId], kABPersonFirstNameProperty);
    return firstName;
}
- (ABRecordRef)recordRefFromRecordId:(NSNumber *)recordId {
    return ABAddressBookGetPersonWithRecordID(self.addressBookRef,
                                              [recordId intValue]);
}
- (NSArray *)arrayProperty:(ABPropertyID)property
                fromRecord:(ABRecordRef)recordRef {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self enumerateMultiValueOfProperty:property
                             fromRecord:recordRef
                              withBlock:^(ABMultiValueRef multiValue,
                                          NSUInteger index) {
                                CFTypeRef value = ABMultiValueCopyValueAtIndex(
                                    multiValue, index);
                                NSString *string =
                                    (__bridge_transfer NSString *)value;
                                if (string) {
                                    [array addObject:string];
                                }
                              }];
    return array.copy;
}
- (void)enumerateMultiValueOfProperty:(ABPropertyID)property
                           fromRecord:(ABRecordRef)recordRef
                            withBlock:(void (^)(ABMultiValueRef multiValue,
                                                NSUInteger index))block {
    ABMultiValueRef multiValue = ABRecordCopyValue(recordRef, property);
    NSUInteger count = (NSUInteger)ABMultiValueGetCount(multiValue);
    for (NSUInteger i = 0; i < count; i++) {
        block(multiValue, i);
    }
    CFRelease(multiValue);
}

@end
