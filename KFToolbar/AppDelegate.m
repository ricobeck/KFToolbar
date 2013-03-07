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
                break;

            case 2:
                break;

            case 3:
                break;
                
            default:
                break;
        }
    }];
}

@end
