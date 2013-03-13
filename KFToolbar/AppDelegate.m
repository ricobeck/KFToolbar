//
//  AppDelegate.m
//  KFToolbar
//
//  Created by Gunnar Herzog on 04.03.13.
//  Copyright (c) 2013 com.kf-interactive.toolbar. All rights reserved.
//

#import "AppDelegate.h"
#import "KFToolbar.h"

@interface AppDelegate ()

@property (weak) IBOutlet KFToolbar *toolbar;

@end


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    KFToolbarItem *addItem = [KFToolbarItem toolbarItemWithType:NSToggleButton icon:[NSImage imageNamed:NSImageNameAddTemplate] tag:0];
    addItem.toolTip = @"Add";
    addItem.keyEquivalent = @"q";
    KFToolbarItem *removeItem = [KFToolbarItem toolbarItemWithIcon:[NSImage imageNamed:NSImageNameRemoveTemplate] tag:1];
    removeItem.toolTip = @"Remove";
    
    self.toolbar.leftItems = @[addItem, removeItem];
    self.toolbar.rightItems = @[[KFToolbarItem toolbarItemWithIcon:[NSImage imageNamed:NSImageNameEnterFullScreenTemplate] tag:2], [KFToolbarItem toolbarItemWithIcon:[NSImage imageNamed:NSImageNameExitFullScreenTemplate] tag:3]];
    [self.toolbar setItemSelectionHandler:^(KFToolbarItemSelectionType selectionType, KFToolbarItem *toolbarItem, NSUInteger tag)
    {
        switch (tag)
        {
            case 0:
                break;
            
            case 1:
                addItem.enabled = !addItem.isEnabled;
                break;

            case 2:
            {
                [self setControlsEnabled:NO forView:self.toolbar.superview];
                double delayInSeconds = 2.0;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                {
                    [self setControlsEnabled:YES forView:self.toolbar.superview];
                });
                break;
            }
                
            case 3:
            {
                self.toolbar.enabled = NO;
                double delayInSeconds = 2.0;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                {
                    self.toolbar.enabled = YES;
                });
                break;
            }

            default:
                break;
        }
    }];
}


- (void)setControlsEnabled:(BOOL)enabled forView:(NSView *)view
{
    static NSMutableArray *previouslyDisabledControls;
    if (!previouslyDisabledControls || !enabled)
    {
        previouslyDisabledControls = [NSMutableArray new];
    }

    for (NSView *subview in view.subviews)
    {
        if ([subview respondsToSelector:@selector(setEnabled:)])
        {
            if (enabled)
            {
                if (![previouslyDisabledControls containsObject:subview])
                {
                    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[subview methodSignatureForSelector:@selector(setEnabled:)]];
                    [inv setSelector:@selector(setEnabled:)];
                    [inv setTarget:subview];
                    [inv setArgument:&enabled atIndex:2];
                    [inv performSelector:@selector(invoke) withObject:nil];
                }
            }
            else
            {
                if (![subview valueForKey:@"isEnabled"])
                {
                    [previouslyDisabledControls addObject:subview];
                }
                NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[subview methodSignatureForSelector:@selector(setEnabled:)]];
                [inv setSelector:@selector(setEnabled:)];
                [inv setTarget:subview];
                [inv setArgument:&enabled atIndex:2];
                [inv performSelector:@selector(invoke) withObject:nil];
            }
        }
    }
}

@end
