//
//  KFToolbar.m
//
//  Created by rick on 25.02.13.
//  Copyright (c) 2013 KF Interactive. All rights reserved.
//

#import "KFToolbar.h"
#import "KFToolbarItem.h"
#import "KFToolBarConstraintBuilder.h"
#import "KFToolBarPrivate.h"
#import "NSArray+KFIAdditions.h"

@implementation KFToolbar
{
	NSMutableArray *_leftItems;
	NSMutableArray *_rightItems;
}

@dynamic leftItems;
@dynamic rightItems;
@dynamic items;
@dynamic allowOverlappingItems;

#pragma mark class methods

+ (BOOL)requiresConstraintBasedLayout
{
	return YES;
}

#pragma mark init/cleanup

- (id)initWithFrame:(NSRect)frameRect
{
	self = [super initWithFrame:frameRect];
    if (self)
    {
		_leftItems = [NSMutableArray new];
		_rightItems = [NSMutableArray new];
        [self setupDefaults];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupDefaults];
    }
    return self;
}

- (void)setupDefaults
{
	[self setTranslatesAutoresizingMaskIntoConstraints:NO];
}

#pragma mark - NSView overrides

- (void)viewWillMoveToWindow:(NSWindow *)newWindow
{
	BOOL inWindow = [self window] != nil;
	BOOL willBeInWindow = newWindow != nil;
	
	if (willBeInWindow && !inWindow) {
		[newWindow setContentBorderThickness:NSHeight([self bounds])
									 forEdge:NSMinYEdge];
	}
	[super viewWillMoveToWindow:newWindow];
}

- (void)layout
{
	[super layout];
	[self updateItemVisibility];
}

- (void)updateConstraints
{
	NSString *formatString = self.constraintsBuilder.visualFormatString;
	if (formatString) {
		self.horizontalItemConstraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString options:NSLayoutFormatAlignAllCenterY metrics:nil views:self.constraintsBuilder.viewBindings];
	}
	[super updateConstraints];
}

- (void)setHorizontalItemConstraints:(NSArray *)horizontalItemConstraints
{
	if (![_horizontalItemConstraints isEqualToArray:horizontalItemConstraints]) {
		if (_horizontalItemConstraints) {
			[self removeConstraints:_horizontalItemConstraints];
		}
		_horizontalItemConstraints = horizontalItemConstraints;
		[self addConstraints:horizontalItemConstraints];
	}
}

#pragma mark - layout

- (void)fadeOut
{
	if (self.visibilityTransitionState == kKFToolbarVisibilityTransitionStateFadeOut) {
		return;
	}
	[NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
		self.visibilityTransitionState = kKFToolbarVisibilityTransitionStateFadeOut;
		[[self animator] setAlphaValue:0];
	} completionHandler:^{
		[self setHidden:YES];
		self.visibilityTransitionState = kKFToolbarVisibilityTransitionStateNone;
	}];
}

- (void)fadeIn
{
	if (self.visibilityTransitionState == kKFToolbarVisibilityTransitionStateFadeIn) {
		return;
	}
	[NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
		self.visibilityTransitionState = kKFToolbarVisibilityTransitionStateFadeIn;
		[[self animator] setAlphaValue:1];
		[self setHidden:NO];
	} completionHandler:^{
		self.visibilityTransitionState = kKFToolbarVisibilityTransitionStateNone;
	}];
}

- (void)updateItemVisibility
{
    KFToolbarItem *lastLeftItem = self.leftItems.lastObject;
    KFToolbarItem *firstRightItem = [_rightItems count] ? self.rightItems[0] : nil;
	
	if (!lastLeftItem && !firstRightItem) {
		return;
	}
    BOOL intersecting = CGRectIntersectsRect(lastLeftItem.frame, firstRightItem.frame);
	
	if (intersecting && ![self isHidden]) {
		[self fadeOut];
	}
	else if (!intersecting && [self isHidden]) {
		[self fadeIn];
	}
}

#pragma mark - items

- (NSArray *)items
{
	return [self.leftItems arrayByAddingObjectsFromArray:self.rightItems];
}

- (void)setEnabled:(BOOL)enabled
{
	_enabled = enabled;
	[self.items enumerateObjectsUsingBlock:^(KFToolbarItem *item, NSUInteger idx, BOOL *stop) {
		[item setEnabled:enabled];
	}];
}

- (void)prepareItem:(KFToolbarItem *)item
{
	[item removeConstraints:[item constraints]];
	item.action = @selector(selectToolbarItem:);
	item.target = self;
	[item invalidateIntrinsicContentSize];
	[self addSubview:item];
	// center horizontally
	[self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
	
}

- (void)prepareItemsForRemoval:(NSArray*)items
{
	if (!items) {
		return;
	}
	[items makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (NSArray*)leftItems
{
	return _leftItems ? [_leftItems copy] : @[];
}

- (void)setLeftItems:(NSArray *)leftItems
{
    if (![leftItems isEqualToArray:_leftItems])
    {
        [self prepareItemsForRemoval:_leftItems];
		[_leftItems removeAllObjects];

		for (KFToolbarItem *item in leftItems) {
			if (![item isKindOfClass:[KFToolbarItem class]]) {
				continue;
			}
			[_leftItems addObject:item];
			[self prepareItem:item];
		}
		[[_leftItems firstObject] performSelector:@selector(hideLeftShadow)];

		self.rightItems = [self.rightItems kfi_minusArray:leftItems];
		self.constraintsBuilder = [[KFToolBarConstraintBuilder alloc] initWithLeftItems:_leftItems rightItems:self.rightItems];

		[self setNeedsUpdateConstraints:YES];
    }
}

- (NSArray*)rightItems
{
	return _rightItems ? [_rightItems copy] : @[];
}

- (void)setRightItems:(NSArray *)rightItems
{
    if (![rightItems isEqualToArray:_rightItems])
    {
       [self prepareItemsForRemoval:_rightItems];
		[_rightItems removeAllObjects];
		
		for (KFToolbarItem *item in rightItems) {
			if (![item isKindOfClass:[KFToolbarItem class]]) {
				continue;
			}
			[_rightItems addObject:item];
			[self prepareItem:item];
			
		}
		[[_rightItems lastObject] performSelector:@selector(hideRightShadow)];
		self.leftItems = [self.leftItems kfi_minusArray:rightItems];
		self.constraintsBuilder = [[KFToolBarConstraintBuilder alloc] initWithLeftItems:self.leftItems rightItems:_rightItems];
       	[self setNeedsUpdateConstraints:YES];
    }
}

- (BOOL)allowOverlappingItems
{
	return self.constraintsBuilder ? self.constraintsBuilder.allowOverlappingItems : YES;
}

- (void)setAllowOverlappingItems:(BOOL)allowOverlappingItems
{
	self.constraintsBuilder.allowOverlappingItems = allowOverlappingItems;
	[self setNeedsUpdateConstraints:YES];
}

#pragma mark - Selection Handling

- (void)setItemSelectionHandler:(KFToolbarEventsHandler)itemSelectionHandler
{
    self.selectionHandler = itemSelectionHandler;
}

- (void)selectToolbarItem:(id)sender
{
    KFToolbarItem *item = (KFToolbarItem *)sender;

	self.selectedIndex = [self.items indexOfObject:item];
    if (self.selectionHandler)
    {
        self.selectionHandler(KFToolbarItemSelectionTypeWillSelect, item, item.tag);
    }
}

@end
