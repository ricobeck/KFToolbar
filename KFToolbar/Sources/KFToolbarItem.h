//
//  KFToolbarItem.h
//  KFJSON
//
//  Created by rick on 25.02.13.
//  Copyright (c) 2013 KF Interactive. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface KFToolbarItem : NSButtonCell


@property (nonatomic, readonly) NSButton* button;


@property (nonatomic, strong) NSImage *icon;
@property (nonatomic, strong) NSString *toolTip;
@property (nonatomic, strong) NSString *keyEquivalent;
@property (nonatomic) NSUInteger keyEquivalentModifierMask;
@property (nonatomic) NSInteger state;
@property (nonatomic) NSInteger tag;
@property (nonatomic, getter = isEnabled) BOOL enabled;


+ (instancetype)toolbarItemWithType:(NSButtonType)type icon:(NSImage *)iconImage tag:(NSUInteger)itemTag;

+ (instancetype)toolbarItemWithIcon:(NSImage *)iconImage tag:(NSUInteger)itemTag;


- (instancetype)initWithButtonType:(NSButtonType)type icon:(NSImage *)iconImage tag:(NSUInteger)itemTag;

- (instancetype)initWithIcon:(NSImage *)iconImage tag:(NSUInteger)itemTag;


- (void)setIsInKeyWindow:(BOOL)isKey;

- (void)removeFromSuperview;


@end
