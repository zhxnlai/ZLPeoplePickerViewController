//
//  ZLPeoplePickerViewController.m
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/4/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "ZLPeoplePickerViewController.h"
#import "LRIndexedCollationWithSearch.h"

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import "APAddressBook.h"
#import "APContact.h"

@interface ZLPeoplePickerViewController ()

@property (strong, nonatomic) APAddressBook *addressBook;


@property(nonatomic, strong) UISearchBar *searchBar;
//@property(nonatomic, strong) UISearchDisplayController *searchDisplayController;

@property (strong, nonatomic) NSArray *partitionedContacts;
@property (strong, nonatomic) NSArray *searchResults;
@end

@implementation ZLPeoplePickerViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup {
    self.addressBook = [[APAddressBook alloc] init];
    
    [self resetContactArrays];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self loadContacts:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"loaded contacts");
            [self.tableView reloadData];
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
#pragma mark - Parse.com Logic
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.partitionedContacts.count>0) {
        return [[[LRIndexedCollationWithSearch currentCollation] sectionTitles] count];
    } else return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView]) {
        //        DLog(@"tableview contacts: %@", self.partitionedContacts);
        if ((NSInteger) [[self.partitionedContacts objectAtIndex:(NSUInteger) section] count]==0) {
            return @"";
        }
    } else {
        if ((NSInteger) [[self.searchResults objectAtIndex:(NSUInteger) section] count]==0) {
            return @"";
        }
    }
    
    return [[[LRIndexedCollationWithSearch currentCollation] sectionTitles] objectAtIndex:section];
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [[LRIndexedCollationWithSearch currentCollation] sectionIndexTitles];
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger ret = [[LRIndexedCollationWithSearch currentCollation] sectionForSectionIndexTitleAtIndex:index];
    if (ret == NSNotFound) {
        [self.tableView setContentOffset:CGPointMake(0.0, -self.tableView.contentInset.top)];
    }
    
    return ret;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableView]) {
        return (NSInteger) [[self.partitionedContacts objectAtIndex:(NSUInteger) section] count];
    } else {
        return (NSInteger) [[self.searchResults objectAtIndex:(NSUInteger) section] count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryView = nil;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    APContact *contact = [[self.partitionedContacts objectAtIndex:(NSUInteger) indexPath.section] objectAtIndex:(NSUInteger) indexPath.row];
    if (![tableView isEqual:self.tableView]) {
        contact = [[self.searchResults objectAtIndex:(NSUInteger) indexPath.section] objectAtIndex:(NSUInteger) indexPath.row];
    }
    
    cell.textLabel.text = contact.compositeName;
    
    return cell;
    
}

#pragma mark - APAddressBook

- (void)loadContacts:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    __weak __typeof(self) weakSelf = self;
    self.addressBook.fieldsMask = APContactFieldFirstName | APContactFieldLastName | APContactFieldCompositeName | APContactFieldPhones | APContactFieldThumbnail |APContactFieldRecordID;
    //    addressBook.sortDescriptors = @[
    //                                    [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES],
    //                                    [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES]];
    self.addressBook.filterBlock = ^BOOL(APContact *contact)
    {
        return contact.phones.count > 0 && contact.compositeName != nil;
    };
    [self.addressBook loadContacts:^(NSArray *contacts, NSError *error) {
        if (!error)
        {
            [self resetContactArrays];
            
            for (APContact *contact in contacts) {
                
                
                // add new contact
                SEL selector = @selector(lastName);
                if (contact.lastName.length==0) {
                    selector = @selector(compositeName);
                }
                NSInteger index = [[LRIndexedCollationWithSearch currentCollation] sectionForObject:contact collationStringSelector:selector];
                //                     contact.sectionIndex = index;
                [self.partitionedContacts[index] addObject:contact];
                
            }
       
        
        
        //sort sections
        //         NSUInteger sectionCount = [[[LRIndexedCollationWithSearch currentCollation] sectionTitles] count];
        //         int sectionCountInt = [[NSNumber numberWithUnsignedInt:sectionCount] intValue];
        //         for (NSInteger i = 0; i < sectionCountInt; i++) {
        //
        //             RLMArray *contactsForSection = [BLContact objectsWhere:@"sectionIndex == %d",i];
        //             NSMutableArray *section = [NSMutableArray array];
        //             for (BLContact *contact in contactsForSection) {
        //                 [section addObject:contact];
        //             }
        //             NSArray *sortedSection = [[LRIndexedCollationWithSearch currentCollation]  sortedArrayFromArray:section collationStringSelector:@selector(firstName)];
        //
        //             for (NSInteger i=0; i<sortedSection.count; i++) {
        //                 ((BLContact *)sortedSection[i]).rowIndex = i;
        //             }
        //
        //         }
        
        
        
        
            if (completionBlock) {
                completionBlock(YES,nil);
            }
        }
        else {
            if (completionBlock) {
                completionBlock(NO,error);
            }
        }
    }];
    //    [self.addressBook startObserveChangesWithCallback:^{
    //         //         NSLog(@"Address book changed!");
    //         [[NSNotificationCenter defaultCenter] postNotificationName:BLAddressBookDidChangeNotification object:nil ];
    //     }];
    
    
}

#pragma mark - ()
- (void)resetContactArrays {
    NSArray *sections = [self emptyPartitionedArray];
    self.partitionedContacts = [sections copy];
    self.searchResults = [sections copy];
}
- (NSArray *)emptyPartitionedArray {
    NSUInteger sectionCount = [[[LRIndexedCollationWithSearch currentCollation] sectionTitles] count];
    NSMutableArray *sections = [NSMutableArray arrayWithCapacity:sectionCount];
    for (int i=0; i<sectionCount; i++) {
        [sections addObject:[NSMutableArray array]];
    }
    return sections;
}

@end
