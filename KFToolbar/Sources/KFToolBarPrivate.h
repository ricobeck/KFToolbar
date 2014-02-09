//
//  KFToolBarPrivate.h
//  KFToolbar
//
//  Created by Markus Müller on 09.02.14.
//  Copyright (c) 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSUInteger, KFToolbarVisibilityTransitionState)
{
	kKFToolbarVisibilityTransitionStateNone = 0,
    kKFToolbarVisibilityTransitionStateFadeOut,
    kKFToolbarVisibilityTransitionStateFadeIn
};

@class KFToolBarConstraintBuilder;

@interface KFToolbar()

@property (nonatomic, copy) KFToolbarEventsHandler selectionHandler;
@property (strong) KFToolBarConstraintBuilder *constraintsBuilder;
@property KFToolbarVisibilityTransitionState visibilityTransitionState;
@property (nonatomic, strong) NSArray *horizontalItemConstraints;

@end

