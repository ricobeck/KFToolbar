//
//  KFToolbarItemButtonCell.m
//  KFToolbar
//
//  Created by Markus Müller on 08.02.14.
//  Copyright (c) 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import "KFToolbarItemButtonCell.h"

static CGFloat kKFToolbarItemGradientLocations[] =     {0.0f, 0.5f, 1.0f};

#define kKFToolbarItemGradientColorTop [NSColor colorWithCalibratedWhite:0.7f alpha:0.0f]
#define kKFToolbarItemGradientColorBottom [NSColor colorWithCalibratedWhite:0.7f alpha:1.0f]
#define kKFToolbarItemGradient [[NSGradient alloc] initWithColors: [NSArray arrayWithObjects: \
kKFToolbarItemGradientColorTop, \
kKFToolbarItemGradientColorBottom, \
kKFToolbarItemGradientColorTop, nil] \
atLocations: kKFToolbarItemGradientLocations \
colorSpace: [NSColorSpace genericGrayColorSpace]]

@implementation KFToolbarItemButtonCell

- (id)init
{
	return [self initWithButtonType:NSMomentaryPushInButton];
}

- (id)initWithButtonType:(NSButtonType)buttonType
{
    self = [super init];
    if (self)
    {
		_showLeftShadow = YES;
		_showRightShadow = YES;
		_buttonType = buttonType;
        self.state = NSOffState;
        self.bezelStyle = NSTexturedRoundedBezelStyle;
    }
    return self;
}


- (NSInteger)showsStateBy
{
    return 0;
}


- (NSInteger)highlightsBy
{
    return NSPushInCellMask;
}


- (NSInteger)nextState
{
    switch (self.buttonType)
    {
        case NSToggleButton:
            return self.state == NSOnState ? NSOffState : NSOnState;
            break;
        default:
            return NSOffState;
            break;
    }
}

- (void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView
{
    if (self.isHighlighted || self.state == NSOnState)
    {
        [[NSGraphicsContext currentContext] saveGraphicsState];
        
        // Draw light vertical gradient
        [kKFToolbarItemGradient drawInRect:frame angle:90.0f];
        
        // Draw shadow on the left border of the item
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = NSMakeSize(1.0f, 0.0f);
        shadow.shadowBlurRadius = 2.0f;
        shadow.shadowColor = [NSColor darkGrayColor];
        if (self.showLeftShadow)
        {
            [shadow set];
        }
		
        [[NSColor blackColor] set];
        CGFloat radius = 50.0;
        NSPoint center = NSMakePoint(NSMinX(frame) - radius, NSMidY(frame));
        NSBezierPath *path = [NSBezierPath bezierPath];
        [path moveToPoint:center];
        [path appendBezierPathWithArcWithCenter:center radius:radius startAngle:-90.0f endAngle:90.0f];
        [path closePath];
        [path fill];
		
        // shadow of the right border
        if (self.showRightShadow)
        {
            shadow.shadowOffset = NSMakeSize(-1.0f, 0.0f);
            [shadow set];
        }
        center = NSMakePoint(NSMaxX(frame) + radius, NSMidY(frame));
        path = [NSBezierPath bezierPath];
        [path moveToPoint:center];
        [path appendBezierPathWithArcWithCenter:center radius:radius startAngle:90.0f  endAngle:270.0f];
        [path closePath];
        [path fill];
        
        // Restore context
        [[NSGraphicsContext currentContext] restoreGraphicsState];
    }
}


@end
