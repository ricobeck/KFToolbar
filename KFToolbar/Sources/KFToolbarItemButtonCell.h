//
//  KFToolbarItemButtonCell.h
//  KFToolbar
//
//  Created by Markus Müller on 08.02.14.
//  Copyright (c) 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface KFToolbarItemButtonCell : NSButtonCell

@property (nonatomic) NSButtonType buttonType;
@property (nonatomic, assign) BOOL showLeftShadow;
@property (nonatomic, assign) BOOL showRightShadow;

- (id)initWithButtonType:(NSButtonType)buttonType;

@end
