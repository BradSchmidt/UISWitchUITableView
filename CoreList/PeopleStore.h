//
//  PeopleStore.h
//  CoreList
//
//  Created by Bradley Robert Schmidt on 3/17/15.
//  Copyright (c) 2015 Bradley Robert Schmidt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class People;

@interface PeopleStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (People *)createItem;
- (void)removeItem:(People *)item;

- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex;

- (NSString *)itemArchivePath;

- (BOOL)saveChanges;

@end
