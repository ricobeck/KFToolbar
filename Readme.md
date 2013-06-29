#A Toolbar for NSWindows

An easy to setup and use toolbar that can contain KFToolbarItems (what is actually a wrapper for NSButtons).

![<Display Name>](<http://dl.dropbox.com/u/18869578/Screenshots/11lh8w2d~22s.png>)

##Usage
Actions are handled inside a block.
An exhaustive example is included.


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
    
##Licence
This code is licenced under MIT.