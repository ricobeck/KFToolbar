//
//  KFToolbar.h
//  KFJSON
//
//  Created by rick on 25.02.13.
//  Copyright (c) 2013 KF Interactive. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KFToolbarItem.h"

#define kKFToolbarGradientColorTop [NSColor colorWithCalibratedRed:0.9f green:0.9f blue:0.9f alpha:1.0f]
#define kKFToolbarGradientColorBottom [NSColor colorWithCalibratedRed:0.700f green:0.700f blue:0.700f alpha:1.0f]

#define kKFToolbarBorderColorTop [NSColor colorWithCalibratedRed:0.6f green:0.6f blue:0.6f alpha:1.0f]
#define kKFToolbarBorderColorBottom [NSColor colorWithCalibratedRed:0.8f green:0.8f blue:0.8f alpha:1.0f]


typedef NS_ENUM(NSUInteger, KFToolbarItemSelectionType)
{
    KFToolbarItemSelectionTypeWillSelect,
    KFToolbarItemSelectionTypeDidSelect
};


typedef void (^KFToolbarEventsHandler)(KFToolbarItemSelectionType selectionType, KFToolbarItem *targetToolbarItem, NSUInteger tag);


@interface KFToolbar : NSView


@property (nonatomic,strong) NSColor *gradientColorTop;
@property (nonatomic,strong) NSColor *gradientColorBottom;
@property (nonatomic,strong) NSColor *borderColorTop;
@property (nonatomic,strong) NSColor *borderColorBottom;

@property (nonatomic, strong) NSArray *leftItems;
@property (nonatomic, strong) NSArray *rightItems;

@property (nonatomic, getter = isEnabled) BOOL enabled;
@property (nonatomic, assign) NSUInteger selectedIndex;


- (void)setItemSelectionHandler:(KFToolbarEventsHandler)itemSelectionHandler;


@end
