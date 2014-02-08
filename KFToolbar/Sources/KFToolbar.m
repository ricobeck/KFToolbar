//
//  KFToolbar.m
//
//  Created by rick on 25.02.13.
//  Copyright (c) 2013 KF Interactive. All rights reserved.
//

#import "KFToolbar.h"
#import "KFToolbarItem.h"
#import "KFToolBarConstraintBuilder.h"

@interface KFToolbar()

@property (nonatomic, copy) KFToolbarEventsHandler selectionHandler;

@property BOOL itemsIntersecting;

@end

@implementation KFToolbar
{
	NSMutableArray *_leftItems;
	NSMutableArray *_rightItems;
}

@dynamic leftItems;
@dynamic rightItems;
@dynamic items;

+ (BOOL)requiresConstraintBasedLayout
{
	return YES;
}

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

- (void)updateItemVisibility
{
    KFToolbarItem *lastLeftItem = self.leftItems.lastObject;
    KFToolbarItem *firstRightItem = [_rightItems count] ? self.rightItems[0] : nil;
    BOOL shouldHide = CGRectIntersectsRect(lastLeftItem.frame, firstRightItem.frame);

	if (shouldHide != self.itemsIntersecting) {
		[NSAnimationContext beginGrouping];
		[[NSAnimationContext currentContext] setDuration:.25];
		[[NSAnimationContext currentContext] setCompletionHandler:^{
			[self setHidden:shouldHide];
		}];
		[[self animator] setAlphaValue:shouldHide ? 0 : 1];
		[NSAnimationContext endGrouping];
		self.itemsIntersecting = !self.itemsIntersecting;
	}
}

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

- (void)prepareItem:(KFToolbarItem *)item
{
	[item removeConstraints:[item constraints]];
	item.action = @selector(selectToolbarItem:);
	item.target = self;
	[item invalidateIntrinsicContentSize];
	[self addSubview:item];
}

- (NSArray*)leftItems
{
	return [_leftItems copy];
}

- (void)setLeftItems:(NSArray *)leftItems
{
    if (![leftItems isEqualToArray:_leftItems])
    {
        [_leftItems makeObjectsPerformSelector:@selector(removeFromSuperview)];
		[_leftItems removeAllObjects];

		for (KFToolbarItem *item in leftItems) {
			if (![item isKindOfClass:[KFToolbarItem class]]) {
				continue;
			}
			[_leftItems addObject:item];
			[self prepareItem:item];
			
		}
		[[_leftItems firstObject] performSelector:@selector(hideLeftShadow)];
       	[self setNeedsUpdateConstraints:YES];
    }
}

- (NSArray*)rightItems
{
	return [_rightItems copy];
}

- (void)setRightItems:(NSArray *)rightItems
{
    if (![rightItems isEqualToArray:_rightItems])
    {
        [_rightItems makeObjectsPerformSelector:@selector(removeFromSuperview)];
		[_rightItems removeAllObjects];
		
		for (KFToolbarItem *item in rightItems) {
			if (![item isKindOfClass:[KFToolbarItem class]]) {
				continue;
			}
			[_rightItems addObject:item];
			[self prepareItem:item];
			
		}
		[[_rightItems lastObject] performSelector:@selector(hideRightShadow)];
       	[self setNeedsUpdateConstraints:YES];
    }}

#pragma mark - Layout

- (void)layout
{
	[super layout];
	[self updateItemVisibility];
}

- (void)updateConstraints
{
	KFToolBarConstraintBuilder *constraintsBuilder = [[KFToolBarConstraintBuilder alloc] initWithLeftItems:self.leftItems rightItems:self.rightItems];
	NSString *formatString = constraintsBuilder.visualFormatString;
	if (formatString) {
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:formatString options:NSLayoutFormatAlignAllCenterY metrics:nil views:constraintsBuilder.viewBindings]];
	}
	// center horizontally
	[self.items enumerateObjectsUsingBlock:^(KFToolbarItem *item, NSUInteger idx, BOOL *stop) {
		[self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
	}];
	[super updateConstraints];
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
