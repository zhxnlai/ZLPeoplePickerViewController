//
//  ZLBaseTableViewController.h
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/5/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLTypes.h"

@class APContact;

static NSString *const kCellIdentifier = @"cellID";

@interface ZLBaseTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *partitionedContacts;
@property (strong, nonatomic) NSMutableSet *selectedPeople;
@property (assign, nonatomic) BOOL shouldHideUnmaskedContacts;

@property (nonatomic) ZLContactField fieldMask;

- (void)setPartitionedContactsWithContacts:(NSArray *)contacts;
- (void)configureCell:(UITableViewCell *)cell forContact:(APContact *)product;
- (BOOL)shouldEnableCellforContact:(APContact *)contact;
- (APContact *)contactForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
