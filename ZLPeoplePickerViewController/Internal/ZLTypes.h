//
//  ZLTypes.h
//  ZLPeoplePickerViewControllerDemo
//
//  Created by Zhixuan Lai on 11/11/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#ifndef ZLPeoplePickerViewControllerDemo_ZLTypes_h
#define ZLPeoplePickerViewControllerDemo_ZLTypes_h

typedef NS_ENUM(NSUInteger, ZLNumSelection) {
    ZLNumSelectionNone = 0,
    ZLNumSelectionMax = NSUIntegerMax
};

typedef NS_OPTIONS(NSUInteger, ZLContactField){
    ZLContactFieldPhones = 1 << 3, ZLContactFieldEmails = 1 << 4,
    ZLContactFieldPhoto = 1 << 5, ZLContactFieldAddresses = 1 << 9,
    ZLContactFieldDefault = ZLContactFieldPhones, ZLContactFieldAll = 0xFFFF};

#endif
