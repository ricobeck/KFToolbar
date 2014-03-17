#A Toolbar for NSWindows
![Travis Status](https://travis-ci.org/ricobeck/KFToolbar.png?branch=master)

An easy to setup and use toolbar that can contain KFToolbarItems (what is actually a wrapper for NSButtons).

![<Display Name>](<http://dl.dropbox.com/u/18869578/Screenshots/11lh8w2d~22s.png>)

## Installation

KFAboutWindow is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "KFToolbar"

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
    
## Author

Rico Becker, [@ricobeck][1]

## Contributors

Gunnar Herzog, [@trispo][2]  
Markus Müller, [@m_mlr][3]

## License

KFToolbar is available under the MIT license. See the LICENSE file for more info.

[1]: http://twitter.com/ricobeck        "@ricobeck"
[2]: http://twitter.com/trispo          "@trispo"
[3]: http://twitter.com/m_mlr          "@m_mlr"