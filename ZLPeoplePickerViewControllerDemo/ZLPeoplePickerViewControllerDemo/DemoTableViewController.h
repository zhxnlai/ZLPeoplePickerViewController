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


typedef NS_ENUM(NSInteger, DemoTableViewControllerSections) {
    DemoTableViewControllerSectionPresentationType,
    DemoTableViewControllerSectionNumSelectionType,
    DemoTableViewControllerSectionNumSelectionSlider,
    DemoTableViewControllerSectionSelectionActionType,
    DemoTableViewControllerSectionReturnActionType,
    DemoTableViewControllerSectionShowButton,
    DemoTableViewControllerSectionCount,
};

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
    DemoTableViewControllerSectionSelectionActionTypeAlert,
    DemoTableViewControllerSectionSelectionActionTypeEmail,
    DemoTableViewControllerSectionSelectionActionTypeCount,
};

typedef NS_ENUM(NSInteger, DemoTableViewControllerSectionReturnActionTypes) {
    DemoTableViewControllerSectionReturnActionTypeAlert,
    DemoTableViewControllerSectionReturnActionTypePersonViewController,
    DemoTableViewControllerSectionReturnActionTypeCount,
};


// seg: nav or not
// selection type: single, multiple, custom(slider 0(test case)-10)
// alert, msg
// present



@interface DemoTableViewController : UITableViewController

@end
