//
//  KFToolbarItem.h
//  KFJSON
//
//  Created by rick on 25.02.13.
//  Copyright (c) 2013 KF Interactive. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KFToolbarItem : NSButtonCell


@property (nonatomic, readonly) NSButton* tabBarItemButton;


+ (instancetype)toolbarItemWithType:(NSButtonType)type icon:(NSImage *)iconImage tag:(NSUInteger)itemTag;

+ (instancetype)toolbarItemWithIcon:(NSImage *)iconImage tag:(NSUInteger)itemTag;


- (instancetype)initWithButtonType:(NSButtonType)type icon:(NSImage *)iconImage tag:(NSUInteger)itemTag;

- (instancetype)initWithIcon:(NSImage *)iconImage tag:(NSUInteger)itemTag;


- (void)removeFromSuperview;


@end
