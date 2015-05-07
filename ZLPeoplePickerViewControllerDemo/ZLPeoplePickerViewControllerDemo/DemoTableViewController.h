//
//  HomeTableViewController.h
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/6/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

// UITableView
typedef NS_ENUM(NSInteger, DemoTableViewControllerSections) {
    DemoTableViewControllerSectionPresentationType,
    DemoTableViewControllerSectionNumSelectionType,
    DemoTableViewControllerSectionFieldMaskType,
    DemoTableViewControllerSectionActionType,
    DemoTableViewControllerSectionShowButton,
    DemoTableViewControllerSectionCount,
};

typedef NS_ENUM(NSInteger, DemoTableViewControllerSectionNumSelectionTypeRows) {
    DemoTableViewControllerSectionNumSelectionTypeRowSegmentedControl,
    DemoTableViewControllerSectionNumSelectionTypeRowSlider,
    DemoTableViewControllerSectionNumSelectionTypeRowCount,
};

typedef NS_ENUM(NSInteger, DemoTableViewControllerSectionActionTypeRows) {
    DemoTableViewControllerSectionActionTypeRowSelection,
    DemoTableViewControllerSectionActionTypeRowReturn,
    DemoTableViewControllerSectionActionTypeRowCount,
};

// UISegmentedControl
typedef NS_ENUM(NSInteger, DemoTableViewControllerSectionPresentationTypes) {
    DemoTableViewControllerSectionPresentationTypeNormal,
    DemoTableViewControllerSectionPresentationTypeNav,
    DemoTableViewControllerSectionPresentationTypeCount,
};

typedef NS_ENUM(NSInteger, DemoTableViewControllerSectionNumSelectionTypes) {
    DemoTableViewControllerSectionNumSelectionTypeNone,
    DemoTableViewControllerSectionNumSelectionTypeMax,
    DemoTableViewControllerSectionNumSelectionTypeCustom,
    DemoTableViewControllerSectionNumSelectionTypeCount
};

typedef NS_ENUM(NSInteger, DemoTableViewControllerSectionFieldMaskTypes) {
    DemoTableViewControllerSectionFieldMaskTypeAll,
    DemoTableViewControllerSectionFieldMaskTypePhones,
    DemoTableViewControllerSectionFieldMaskTypeEmails,
    DemoTableViewControllerSectionFieldMaskTypePhoto,
    DemoTableViewControllerSectionFieldMaskTypeCount
};

typedef NS_ENUM(NSInteger, DemoTableViewControllerSectionSelectionActionTypes) {
    DemoTableViewControllerSectionSelectionActionTypePersonViewController,
    DemoTableViewControllerSectionSelectionActionTypeAlert,
    DemoTableViewControllerSectionSelectionActionTypeCount,
};

typedef NS_ENUM(NSInteger, DemoTableViewControllerSectionReturnActionTypes) {
    DemoTableViewControllerSectionReturnActionTypeEmail,
    DemoTableViewControllerSectionReturnActionTypeAlert,
    DemoTableViewControllerSectionReturnActionTypeCount,
};

@interface DemoTableViewController : UITableViewController

@end
