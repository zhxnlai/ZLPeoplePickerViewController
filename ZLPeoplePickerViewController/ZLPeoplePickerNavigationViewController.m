//
//  ZLPeoplePickerNavigationViewController.m
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/5/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "ZLPeoplePickerNavigationViewController.h"
#import "ZLPeoplePickerViewController.h"
@implementation ZLPeoplePickerNavigationViewController
- (instancetype)init {
    self = [super init];
    if (self) {
        ZLPeoplePickerViewController *peoplePicker = [[ZLPeoplePickerViewController alloc] initWithStyle:UITableViewStylePlain];
        [self pushViewController:peoplePicker animated:NO];
        peoplePicker.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonAction:)];
    }
    return self;
}

- (void)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
