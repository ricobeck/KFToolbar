//
//  KFToolbar.h
//  KFJSON
//
//  Created by rick on 25.02.13.
//  Copyright (c) 2013 KF Interactive. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KFToolbarItem.h"

typedef NS_ENUM(NSUInteger, KFToolbarItemSelectionType)
{
    KFToolbarItemSelectionTypeWillSelect,
    KFToolbarItemSelectionTypeDidSelect
};

typedef void (^KFToolbarEventsHandler)(KFToolbarItemSelectionType selectionType, KFToolbarItem *targetToolbarItem, NSUInteger tag);

@interface KFToolbar : NSView

@property (nonatomic, readonly) NSArray *items;
@property (nonatomic, strong) NSArray *leftItems;
@property (nonatomic, strong) NSArray *rightItems;
@property (nonatomic, getter = isEnabled) BOOL enabled;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic) BOOL allowOverlappingItems;

- (void)setItemSelectionHandler:(KFToolbarEventsHandler)itemSelectionHandler;
- (void)updateItemVisibility;

@end
