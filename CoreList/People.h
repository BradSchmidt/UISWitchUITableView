//
//  People.h
//  CoreList
//
//  Created by Bradley Robert Schmidt on 3/17/15.
//  Copyright (c) 2015 Bradley Robert Schmidt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject <NSCoding>

- (id)initWithFirstName:(NSString *)first LastName:(NSString *)last;

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;

@property (nonatomic, assign) BOOL isSelected;
@end
