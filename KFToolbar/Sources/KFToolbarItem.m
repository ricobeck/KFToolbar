//
//  KFToolbarItem.m
//  KFJSON
//
//  Created by rick on 25.02.13.
//  Copyright (c) 2013 KF Interactive. All rights reserved.
//

#import "KFToolbarItem.h"
#import "KFToolbarItemButtonCell.h"

@implementation KFToolbarItem

+ (instancetype)toolbarItemWithType:(NSButtonType)type icon:(NSImage *)iconImage tag:(NSUInteger)itemTag
{
    return [[KFToolbarItem alloc] initWithButtonType:type icon:iconImage tag:itemTag];
}


+ (instancetype)toolbarItemWithIcon:(NSImage *)iconImage tag:(NSUInteger)itemTag
{
    return [[KFToolbarItem alloc] initWithIcon:iconImage tag:itemTag];
}

- (id)init
{
	[NSException raise:NSInternalInconsistencyException format:@"-init not allowed, use -initWithIcon:tag: or -initWithButtonType:icon:tag:"];
	return nil;
}

- (id)initWithTitle:(NSString *)title tag:(NSUInteger)itemTag
{
	self = [self initWithButtonType:NSMomentaryPushInButton icon:nil tag:itemTag];
	if (self) {
		[self setTitle:title];
	}
	return self;
}

- (id)initWithIcon:(NSImage *)iconImage tag:(NSUInteger)itemTag
{
	return [self initWithButtonType:NSMomentaryPushInButton icon:iconImage tag:itemTag];
}

- (id)initWithButtonType:(NSButtonType)type icon:(NSImage *)iconImage tag:(NSUInteger)itemTag
{
    self = [super initWithFrame:NSZeroRect];
    if (self)
    {
        KFToolbarItemButtonCell *cell = [[KFToolbarItemButtonCell alloc] initWithButtonType:type];
        cell.state = NSOffState;
        [self setCell:cell];
        [self setButtonType:type];
        [self setImage:iconImage];
        [self setTag:itemTag];
        [self sendActionOn:NSLeftMouseDownMask];
        [self setEnabled:YES];
		[self setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return self;
}

- (void)hideLeftShadow
{
	KFToolbarItemButtonCell *cell = [self cell];
    cell.showLeftShadow = NO;
}


- (void)hideRightShadow
{
    KFToolbarItemButtonCell *cell = [self cell];
	cell.showRightShadow = NO;
}

@end
