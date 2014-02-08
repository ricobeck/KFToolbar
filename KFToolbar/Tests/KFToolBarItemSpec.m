//
//  KFToolBarItemSpec.m
//  KFToolbar
//
//  Created by Markus Müller on 08.02.14.
//  Copyright 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import "Kiwi.h"
#import "KFToolbarItem.h"
#import "KFToolbarItemButtonCell.h"

SPEC_BEGIN(KFToolBarItemSpec)

describe(@"KFToolBarItem", ^{
	__block KFToolbarItem *sut = nil;
	__block id mockedImage = nil;

	beforeAll(^{
		mockedImage = [NSImage nullMock];
	});
	afterAll(^{
		mockedImage = nil;
	});
	afterEach(^{
		sut = nil;
	});
	context(@"init", ^{
		it(@"should raise when tryining to initalize with plain init", ^{
			[[theBlock(^{
				sut = [[KFToolbarItem alloc] init];
			})should] raise];
		});
	});
	context(@"initWithIcon:tag:", ^{
		it(@"should call -initWithButtonType:icon:tag", ^{
			sut = [[KFToolbarItem alloc] initWithIcon:mockedImage tag:1];
			[[sut should] receive:@selector(initWithButtonType:icon:tag:)];
			sut = [sut initWithIcon:mockedImage tag:2];
		});
	});
	context(@"initWithTitle:tag:", ^{
		it(@"should call -initWithButtonType:icon:tag", ^{
			sut = [[KFToolbarItem alloc] initWithTitle:@"title" tag:1];
			[[sut should] receive:@selector(initWithButtonType:icon:tag:) withArguments:theValue(NSMomentaryPushInButton), [KWAny any], theValue(10)];
			sut = [sut initWithTitle:@"title" tag:10];
		});
		it(@"should set the title", ^{
			sut = [[KFToolbarItem alloc] initWithTitle:@"title" tag:1];
			[[[sut title] should] equal:@"title"];
		});
	});
	context(@"-initWithButtonType:icon:tag:", ^{
		beforeEach(^{
			sut = [[KFToolbarItem alloc] initWithButtonType:NSMomentaryPushInButton icon:mockedImage tag:1];
		});
		it(@"should exist", ^{
			[[sut shouldNot] beNil];
		});
		it(@"should be a NSButton subclass", ^{
			[[sut should] beKindOfClass:[NSButton class]];
		});
		it(@"should have a KFToolbarItemButtonCell cell", ^{
			[[[sut cell] should] beKindOfClass:[KFToolbarItemButtonCell class]];
		});
		it(@"should have the image", ^{
			[[[sut image] should] equal:mockedImage];
		});
		it(@"should set the tag", ^{
			[[theValue([sut tag]) should] equal:theValue(1)];
		});
		it(@"should be enabled", ^{
			[[theValue([sut isEnabled]) should] beYes];
		});
		it(@"should not translate autoresizing masks into constraints", ^{
			[[theValue([sut translatesAutoresizingMaskIntoConstraints]) should] beNo];
		});
		it(@"should not hide the left shadow", ^{
			[[theValue(((KFToolbarItemButtonCell*)[sut cell]).showLeftShadow) should] beYes];
		});
		it(@"should hide the left shadow when invoking hideLeftShadow", ^{
			[sut hideLeftShadow];
			KFToolbarItemButtonCell *cell = [sut cell];
			[[theValue(cell.showLeftShadow) should] beNo];
		});
		it(@"should hide the left shadow when invoking hideRightShadow", ^{
			[sut hideRightShadow];
			KFToolbarItemButtonCell *cell = [sut cell];
			[[theValue(cell.showRightShadow) should] beNo];
		});
	});
	
});

SPEC_END
