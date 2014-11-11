//
//  HomeTableViewController.h
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/6/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger, DemoTableViewControllerSections) {
//    DemoTableViewControllerSectionsSectionPicker,
//    DemoTableViewControllerSectionsSectionPickerNav,
//    DemoTableViewControllerSectionsSectionMultiPicker,
//    DemoTableViewControllerSectionsSectionCount,
//};

// UITableView
typedef NS_ENUM(NSInteger, DemoTableViewControllerSections) {
    DemoTableViewControllerSectionPresentationType,
    DemoTableViewControllerSectionNumSelectionType,
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

// seg: nav or not
// selection type: single, multiple, custom(slider 0(test case)-10)
// alert, msg
// present



@interface DemoTableViewController : UITableViewController

@end
