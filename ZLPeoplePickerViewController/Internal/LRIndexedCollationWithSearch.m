//
//  LRIndexedCollationWithSearch.m
//  ContactListDemo
//
//  Created by Zhixuan Lai on 9/6/14.
//  Copyright (c) 2014 Jacky Li. All rights reserved.
//

#import "LRIndexedCollationWithSearch.h"

@implementation LRIndexedCollationWithSearch {
    UILocalizedIndexedCollation *_collation;
}

@dynamic sectionTitles;
@dynamic sectionIndexTitles;

+ (id)currentCollation;
{
    UILocalizedIndexedCollation *collation =
        [UILocalizedIndexedCollation currentCollation];
    return [[self alloc] initWithCollation:collation];
}

- (id)initWithCollation:(UILocalizedIndexedCollation *)collation;
{
    if (self = [super init]) {
        _collation = collation;
    }
    return self;
}

#pragma mark -

- (NSInteger)sectionForObject:(id)object collationStringSelector:(SEL)selector {
    return
        [_collation sectionForObject:object collationStringSelector:selector];
}

- (NSInteger)sectionForSectionIndexTitleAtIndex:(NSInteger)indexTitleIndex {
    if (indexTitleIndex == 0) {

        return NSNotFound;
    }
    return [_collation sectionForSectionIndexTitleAtIndex:indexTitleIndex - 1];
}

- (NSArray *)sortedArrayFromArray:(NSArray *)array
          collationStringSelector:(SEL)selector {
    return [_collation sortedArrayFromArray:array
                    collationStringSelector:selector];
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)sectionTitles;
{ return [_collation sectionTitles]; }

- (NSArray *)sectionIndexTitles;
{
    return [[NSArray arrayWithObject:UITableViewIndexSearch]
        arrayByAddingObjectsFromArray:[_collation sectionIndexTitles]];
}

@end