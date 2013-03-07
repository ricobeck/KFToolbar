//
//  KFToolbat.m
//  KFJSON
//
//  Created by rick on 25.02.13.
//  Copyright (c) 2013 KF Interactive. All rights reserved.
//

#import "KFToolbar.h"
#import "KFToolbarItem.h"


#define kKFToolbarItemWidth 32.0f


@interface KFToolbar()


@property (nonatomic, copy) KFToolbarEventsHandler selectionHandler;
@property (nonatomic) BOOL itemsAreHidden;


@end



@implementation KFToolbar


- (id)initWithFrame:(NSRect)frameRect
{
    if (self = [super initWithFrame:frameRect])
    {
        [self setupDefaults];
    }
    
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setupDefaults];
    }
    return self;
}


- (void)setupDefaults
{
    self.gradientColorTop = kKFToolbarGradientColorTop;
    self.gradientColorBottom = kKFToolbarGradientColorBottom;
    self.borderColorTop = kKFToolbarBorderColorTop;
    self.borderColorBottom = kKFToolbarBorderColorBottom;
    
    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:NULL];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"] && self.leftItems.count > 0 && self.rightItems.count > 0)
    {
        KFToolbarItem *lastLeftItem = self.leftItems.lastObject;
        KFToolbarItem *firstRightItem = self.rightItems[0];
        if (CGRectIntersectsRect(lastLeftItem.tabBarItemButton.frame, firstRightItem.tabBarItemButton.frame))
        {
            if (!self.itemsAreHidden)
            {
                [[self allItems] enumerateObjectsUsingBlock:^(KFToolbarItem *item, NSUInteger idx, BOOL *stop)
                {
                    [NSAnimationContext beginGrouping];
                    [[NSAnimationContext currentContext] setCompletionHandler:^{
                        item.tabBarItemButton.hidden = YES;
                    }];
                    [[NSAnimationContext currentContext] setDuration:.05f];
                    [[item.tabBarItemButton animator] setAlphaValue:.0f];
                    [NSAnimationContext endGrouping];
                }];
                self.itemsAreHidden = YES;
            }
        }
        else if (self.itemsAreHidden)
        {
            [[self allItems] enumerateObjectsUsingBlock:^(KFToolbarItem *item, NSUInteger idx, BOOL *stop)
             {
                 item.tabBarItemButton.hidden = NO;
                 [[item.tabBarItemButton animator] setAlphaValue:1.0f];
             }];
            self.itemsAreHidden = NO;
        }
    }
}


- (NSArray *)allItems
{
    NSMutableArray *items = [self.leftItems mutableCopy];
    [items addObjectsFromArray:self.rightItems];
    return [items copy];
}



- (BOOL)postsBoundsChangedNotifications
{
    return YES;
}


- (void)drawRect:(NSRect)dirtyRect
{
    if (self.gradientColorTop && self.gradientColorBottom)
    {
        [[[NSGradient alloc] initWithStartingColor:self.gradientColorTop endingColor:self.gradientColorBottom] drawInRect:self.bounds angle:-90.0];
    }
    
    [NSBezierPath setDefaultLineWidth:0.0f];
    
    if (self.borderColorTop)
    {
        [self.borderColorTop setStroke];
        [NSBezierPath strokeLineFromPoint:NSMakePoint(NSMinX(self.bounds), NSMaxY(self.bounds)) toPoint:NSMakePoint(NSMaxX(self.bounds), NSMaxY(self.bounds))];
    }
    
    if (self.borderColorBottom)
    {
        [self.borderColorBottom setStroke];
        
        [NSBezierPath strokeLineFromPoint:NSMakePoint(NSMinX(self.bounds), NSMinY(self.bounds)) toPoint:NSMakePoint(NSMaxX(self.bounds), NSMinY(self.bounds))];
    }
}


#pragma mark - Adding Items


- (void)setLeftItems:(NSArray *)leftItems
{
    if (![leftItems isEqualToArray:self.leftItems])
    {
        [self clearLeftItems];
        _leftItems = leftItems;
        
        [self.leftItems enumerateObjectsUsingBlock:^(KFToolbarItem *item, NSUInteger idx, BOOL *stop)
         {
             NSButton *itemButton = item.tabBarItemButton;
             itemButton.frame = NSMakeRect(0.0f, 0.0f, kKFToolbarItemWidth, NSHeight(self.bounds));
             itemButton.action = @selector(selectToolbarItem:);
             itemButton.target = self;
             [self addSubview:itemButton];
         }];
        
        [self layoutSubviews];
    }
}


- (void)setRightItems:(NSArray *)rightItems
{
    if (![rightItems isEqualToArray:self.rightItems])
    {
        [self clearRightItems];
        _rightItems = rightItems;
        
        [self.rightItems enumerateObjectsUsingBlock:^(KFToolbarItem *item, NSUInteger idx, BOOL *stop)
         {
             NSButton *itemButton = item.tabBarItemButton;
             itemButton.frame = NSMakeRect(0.0f, 0.0f, kKFToolbarItemWidth, NSHeight(self.bounds));
             itemButton.action = @selector(selectToolbarItem:);
             itemButton.target = self;
             [self addSubview:itemButton];
         }];
        
        [self layoutSubviews];
    }
}


#pragma mark - Layout


- (void)resizeSubviewsWithOldSize:(NSSize)oldSize
{
    [super resizeSubviewsWithOldSize:oldSize];
    [self layoutSubviews];
}


- (void)layoutSubviews
{
    __block CGFloat offset_x = 0;
    
    [self.leftItems enumerateObjectsUsingBlock:^(KFToolbarItem *item, NSUInteger idx, BOOL *stop)
    {
        item.tabBarItemButton.frame = NSMakeRect(offset_x, NSMinY(self.bounds), kKFToolbarItemWidth, NSHeight(self.bounds));
        offset_x += kKFToolbarItemWidth;
    }];
    
    offset_x = 0;
    CGFloat totalWidth = self.rightItems.count * kKFToolbarItemWidth;
    
    [self.rightItems enumerateObjectsUsingBlock:^(KFToolbarItem *item, NSUInteger idx, BOOL *stop)
     {
         item.tabBarItemButton.frame = NSMakeRect(NSMaxX(self.bounds) - totalWidth + offset_x, NSMinY(self.bounds), kKFToolbarItemWidth, NSHeight(self.bounds));
         offset_x += kKFToolbarItemWidth;
     }];
}


#pragma mark - Selection Handling


- (void)setItemSelectionHandler:(KFToolbarEventsHandler)itemSelectionHandler
{
    self.selectionHandler = itemSelectionHandler;
}


- (void)selectToolbarItem:(id)sender
{
    NSButton *button = (NSButton *)sender;
    
    NSMutableArray *allItems = [NSMutableArray arrayWithArray:self.leftItems];
    [allItems addObjectsFromArray:self.rightItems];
    
    __block KFToolbarItem *foundItem;
    [allItems enumerateObjectsUsingBlock:^(KFToolbarItem *item, NSUInteger idx, BOOL *stop) {
        if (item.tag == button.tag)
        {
            foundItem = item;
            *stop = YES;
        }
    }];
    
    if (self.selectionHandler)
    {
        self.selectionHandler(KFToolbarItemSelectionTypeWillSelect, foundItem, button.tag);
        
        //self.selectionHandler(KFToolbarItemSelectionTypeDidSelect, item, button.tag);
    }
}


#pragma mark - Clearing Items


- (void)clearLeftItems
{
    [self.leftItems enumerateObjectsUsingBlock:^(KFToolbarItem *item, NSUInteger idx, BOOL *stop) {
        [item removeFromSuperview];
    }];
    _leftItems = nil;
}


- (void)clearRightItems
{
    [self.rightItems enumerateObjectsUsingBlock:^(KFToolbarItem *item, NSUInteger idx, BOOL *stop) {
        [item removeFromSuperview];
    }];
    _rightItems = nil;
}


- (void)clearAllItems
{
    [self clearLeftItems];
    [self clearRightItems];
}


@end
