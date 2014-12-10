//
//  LRIndexedCollationWithSearch.h
//  ContactListDemo
//
//  Created by Zhixuan Lai on 9/6/14.
//  Copyright (c) 2014 Jacky Li. All rights reserved.
//

#import <Foundation/Foundation.h>

//
//  LRSearchableIndexCollation.m
//
//
//  Copyright (c) 2010 Luke Redpath
//  Licensed under the MIT License
//

#import <UIKit/UIKit.h>

/*
 A simple decorator around UILocalizedIndexedCollation that inserts the
 {{search}} magnifying glass icon into the section index titles and adjusts
 the section index as necessary to account for the extra index item.

 Use as a direct replacement for UILocalizedIndexedCollation in indexed
 table views that have a search interface.
 */
@interface LRIndexedCollationWithSearch : NSObject

@property (nonatomic, readonly) NSArray *sectionTitles;
@property (nonatomic, readonly) NSArray *sectionIndexTitles;

+ (id)currentCollation;
- (id)initWithCollation:(UILocalizedIndexedCollation *)collation;

- (NSInteger)sectionForObject:(id)object collationStringSelector:(SEL)selector;
- (NSInteger)sectionForSectionIndexTitleAtIndex:(NSInteger)indexTitleIndex;
- (NSArray *)sortedArrayFromArray:(NSArray *)array
          collationStringSelector:(SEL)selector;

@end