//
//  HomeTableViewController.m
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/6/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "DemoTableViewController.h"
#import "ZLPeoplePickerViewController.h"

@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Demo";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return DemoTableViewControllerSectionsSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case DemoTableViewControllerSectionsSectionPicker:
            return 1;
            break;
        case DemoTableViewControllerSectionsSectionPickerNav:
            return 1;
            break;
        case DemoTableViewControllerSectionsSectionMultiPicker:
            return 1;
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
        case DemoTableViewControllerSectionsSectionPicker:
            cell.textLabel.text = @"People Picker";
            break;
        case DemoTableViewControllerSectionsSectionPickerNav:
            cell.textLabel.text = @"People Picker Navigation";
            break;
        case DemoTableViewControllerSectionsSectionMultiPicker:
            cell.textLabel.text = @"Multiple Picker";
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case DemoTableViewControllerSectionsSectionPicker:
        {
            ZLPeoplePickerViewController *peoplePVC = [[ZLPeoplePickerViewController alloc] initWithStyle:UITableViewStylePlain];
            [self.navigationController pushViewController:peoplePVC animated:YES];
        }
            break;
        case DemoTableViewControllerSectionsSectionPickerNav:
        {
            ZLPeoplePickerNavigationViewController *peoplePVCNav = [[ZLPeoplePickerNavigationViewController alloc] init];
            [self.navigationController presentViewController:peoplePVCNav animated:YES completion:nil];
        }
            break;
        case DemoTableViewControllerSectionsSectionMultiPicker:
        {
            
        }
            break;
        default:
            break;
    }
}

@end
