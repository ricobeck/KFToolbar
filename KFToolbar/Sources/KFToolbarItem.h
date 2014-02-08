//
//  KFToolbarItem.h
//  KFJSON
//
//  Created by rick on 25.02.13.
//  Copyright (c) 2013 KF Interactive. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface KFToolbarItem : NSButton

+ (instancetype)toolbarItemWithType:(NSButtonType)type icon:(NSImage *)iconImage tag:(NSUInteger)itemTag;
+ (instancetype)toolbarItemWithIcon:(NSImage *)iconImage tag:(NSUInteger)itemTag;

- (id)initWithButtonType:(NSButtonType)type icon:(NSImage *)iconImage tag:(NSUInteger)itemTag;
- (id)initWithIcon:(NSImage *)iconImage tag:(NSUInteger)itemTag;
- (id)initWithTitle:(NSString*)title tag:(NSUInteger)itemTag;

- (void)hideLeftShadow;
- (void)hideRightShadow;

@end
