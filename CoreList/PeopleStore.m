//
//  PeopleStore.m
//  CoreList
//
//  Created by Bradley Robert Schmidt on 3/17/15.
//  Copyright (c) 2015 Bradley Robert Schmidt. All rights reserved.
//

#import "PeopleStore.h"
#import "People.h"

@interface PeopleStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation PeopleStore

+ (id)sharedStore  //instancetype
{
    static PeopleStore *sharedStore;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

- (id)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[PeopleStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        NSString *path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (!_privateItems) {
            _privateItems = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (NSArray *)allItems
{
    return [self.privateItems copy];
}

- (People *)createItem
{
    People *item = [[People alloc] init];
    item.isSelected = YES;
    [self.privateItems addObject:item];
    
    return item;
}

- (void)removeItem:(People *)item
{
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    People *item = self.privateItems[fromIndex];
    
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    [self.privateItems insertObject:item atIndex:toIndex];
}

- (NSString *)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return[documentDirectory stringByAppendingPathComponent:@"contacts.archive"];
}

- (BOOL)saveChanges
{
    NSString *path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:_privateItems toFile:path];
}

@end
