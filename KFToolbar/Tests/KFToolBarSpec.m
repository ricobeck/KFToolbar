//
//  KFToolBarSpec.m
//  KFToolbar
//
//  Created by Markus Müller on 08.02.14.
//  Copyright 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import "Kiwi.h"
#import "KFToolBar.h"
#import "KFToolbarItem.h"
#import "KFToolbarItemButtonCell.h"
#import "KFToolBarPrivate.h"
#import "KFToolBarConstraintBuilder.h"

SPEC_BEGIN(KFToolBarSpec)

describe(@"KFToolBar", ^{
	__block KFToolbar *sut = nil;

	context(@"new instance", ^{
		beforeEach(^{
			sut = [[KFToolbar alloc] initWithFrame:NSMakeRect(0, 0, 500, 40)];
		});
		afterEach(^{
			sut = nil;
		});
		it(@"should have emtpy left items", ^{
			[[sut.leftItems should] beEmpty];
		});
		it(@"should have emtpy right items", ^{
			[[sut.rightItems should] beEmpty];
		});
		it(@"should not translate autoresizing masks into constraints", ^{
			[[theValue([sut translatesAutoresizingMaskIntoConstraints]) should] beNo];
		});
		it(@"should require auto layout", ^{
			[[theValue([[sut class] requiresConstraintBasedLayout]) should] beYes];
		});
		it(@"should allow overlapping items", ^{
			[[theValue(sut.allowOverlappingItems) should] beYes];
		});
		context(@"when inserting into a window", ^{
			__block id windowMock = nil;

			beforeEach(^{
				windowMock = [NSWindow nullMock];
			});
			it(@"should set the windows content border to its height", ^{
				[[windowMock should] receive:@selector(setContentBorderThickness:forEdge:) withArguments:theValue(NSHeight([sut bounds])), theValue(NSMinYEdge)];

				[sut viewWillMoveToWindow:windowMock];
			});
		});
		context(@"tool bar with items", ^{
			context(@"when setting valid items", ^{
				__block NSArray *leftItems = nil;
				__block NSArray *rightItems = nil;
				
				beforeEach(^{
					id mockImage = [NSImage nullMock];
					leftItems = @[[[KFToolbarItem alloc] initWithIcon:mockImage tag:0], [[KFToolbarItem alloc] initWithIcon:mockImage tag:1], [[KFToolbarItem alloc] initWithIcon:mockImage tag:2]];
					[sut setLeftItems:leftItems];
					rightItems = @[[[KFToolbarItem alloc] initWithIcon:mockImage tag:3], [[KFToolbarItem alloc] initWithIcon:mockImage tag:4], [[KFToolbarItem alloc] initWithIcon:mockImage tag:5]];
					[sut setRightItems:rightItems];
				});
				it(@"should have three left items", ^{
					[[sut.leftItems should] containObjectsInArray:leftItems];
				});
				it(@"should have the left items as subviews", ^{
					[[sut.subviews should] containObjectsInArray:leftItems];
				});
				it(@"should have three right items", ^{
					[[sut.rightItems should] containObjectsInArray:rightItems];
				});
				it(@"should have the right items as subviews", ^{
					[[sut.subviews should] containObjectsInArray:rightItems];
				});
				it(@"should not show the shadow on the first left item", ^{
					KFToolbarItemButtonCell *cell = [leftItems[0] cell];
					[[theValue(cell.showLeftShadow) should] beNo];
				});
				it(@"should not show the shadow on the last right item", ^{
					KFToolbarItemButtonCell *cell = [[rightItems lastObject] cell];
					[[theValue(cell.showRightShadow) should] beNo];
				});
				context(@"setting right items to leftItems", ^{
					beforeEach(^{
						sut.leftItems = sut.rightItems;
					});
					it(@"should not have them in both stacks", ^{
						[[sut.rightItems shouldNot] containObjectsInArray:sut.leftItems];
					});
					it(@"should have 3 items", ^{
						[[sut.items should] haveCountOf:3];
					});
				});
				context(@"setting left items to rightItems", ^{
					beforeEach(^{
						sut.rightItems = sut.leftItems;
					});
					it(@"should not have them in both stacks", ^{
						[[sut.leftItems shouldNot] containObjectsInArray:sut.rightItems];
					});
					it(@"should have 3 items", ^{
						[[sut.items should] haveCountOf:3];
					});
				});
				context(@"when changing allowOverlappingItems", ^{
					__block KFToolBarConstraintBuilder *constraintBuilderMock = nil;
					beforeEach(^{
						constraintBuilderMock = [KFToolBarConstraintBuilder nullMock];
						sut.constraintsBuilder = constraintBuilderMock;
					});
					it(@"should change the underlying constraintBuilders allowOverlappingItems property", ^{
						[[constraintBuilderMock should] receive:@selector(setAllowOverlappingItems:) withArguments:theValue(NO)];
						sut.allowOverlappingItems = NO;
					});
					it(@"should update the layout constraints", ^{
						[[sut should] receive:@selector(setNeedsUpdateConstraints:) withArguments:theValue(YES)];
						sut.allowOverlappingItems = NO;
					});
				});
				context(@"selection", ^{
					it(@"should select the 3rd item when performing its action", ^{
						KFToolbarItem *item = sut.items[2];
						[item performClick:item];
						[[theValue(sut.selectedIndex) should] equal:theValue(2)];
					});
					it(@"should select the last item when performing its action", ^{
						KFToolbarItem *lastItem = [sut.items lastObject];
						[lastItem performClick:lastItem];
						[[theValue(sut.selectedIndex) should] equal:theValue(5)];
					});
				});
			});
			context(@"when trying to set non KFToolBarItems", ^{
				it(@"should not raise when setting invalid leftItems", ^{
					[[theBlock(^{
						[sut setLeftItems:@[@"one", @"two"]];
					}) shouldNot] raise];
				});
				it(@"should not raise when setting invalid rightItems", ^{
					[[theBlock(^{
						[sut setRightItems:@[@"one", @"two"]];
					}) shouldNot] raise];
				});
				it(@"should not set leftItems with non KFToolBarItems", ^{
					[sut setLeftItems:@[@"one", @"two"]];
					[[sut.leftItems should] beEmpty];
				});
				it(@"should not set rightItems with non KFToolBarItems", ^{
					[sut setRightItems:@[@"one", @"two"]];
					[[sut.rightItems should] beEmpty];
				});
			});
			context(@"autolayout", ^{
				it(@"should update the visibility when in layouting", ^{
					[[sut should] receive:@selector(updateItemVisibility)];
					[sut layout];
				});
			});
		});
	});
});

SPEC_END
