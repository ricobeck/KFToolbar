//
//  KFToolbarItemButtonCellSpec.m
//  KFToolbar
//
//  Created by Markus Müller on 08.02.14.
//  Copyright 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import "Kiwi.h"
#import "KFToolbarItemButtonCell.h"

SPEC_BEGIN(KFToolbarItemButtonCellSpec)

describe(@"KFToolbarItemButtonCell", ^{
	__block KFToolbarItemButtonCell *sut = nil;

	afterEach(^{
		sut = nil;
	});
	context(@"init", ^{
		it(@"should invoke designated initializer initWithButtonType:", ^{
			sut = [[KFToolbarItemButtonCell alloc] init];
			[[sut should] receive:@selector(initWithButtonType:) withArguments:theValue(NSMomentaryPushInButton)];
			sut = [sut init];
		});
	});
	context(@"new instance created with designated initalizer", ^{
		beforeEach(^{
			sut = [[KFToolbarItemButtonCell alloc] init];
		});
		it(@"should exist", ^{
			[[sut shouldNot] beNil];
		});
		it(@"should have a NSTexturedRoundedBezelStyle", ^{
			[[theValue([sut bezelStyle]) should] equal:theValue(NSTexturedRoundedBezelStyle)];
		});
		it(@"should return zero for showsStateBy", ^{
			[[theValue([sut showsStateBy]) should] beZero];
		});
		it(@"should highlight by NSPushInCellMask", ^{
			[[theValue([sut highlightsBy]) should] equal:theValue(NSPushInCellMask)];
		});
		it(@"should show the left shadow", ^{
			[[theValue(sut.showLeftShadow) should] beYes];
		});
		it(@"should show the right shadow", ^{
			[[theValue(sut.showRightShadow) should] beYes];
		});
		context(@"state", ^{
			it(@"should have an initial state of NSOffState", ^{
				[[theValue([sut state]) should] equal:theValue(NSOffState)];
			});
			context(@"nextState", ^{
				it(@"should return when on", ^{
					sut.state = NSOnState;
					[[theValue([sut nextState]) should] equal:theValue(NSOffState)];
				});
				it(@"should return when off", ^{
					sut.state = NSOffState;
					[[theValue([sut nextState]) should] equal:theValue(NSOffState)];
				});
				context(@"NSToggleButton", ^{
					beforeEach(^{
						sut.buttonType = NSToggleButton;
					});
					it(@"should return NSOnState when off", ^{
						[[theValue([sut nextState]) should] equal:theValue(NSOnState)];
					});
					it(@"should return NSOffState when on", ^{
						sut.state = NSOnState;
						[[theValue([sut nextState]) should] equal:theValue(NSOffState)];
					});
				});
			});
		});
	});
});

SPEC_END
