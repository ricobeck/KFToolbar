//
//  KFToolBarConstraintBuilderSpec.m
//  KFToolbar
//
//  Created by Markus Müller on 08.02.14.
//  Copyright 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import "Kiwi.h"
#import "KFToolBarConstraintBuilder.h"

SPEC_BEGIN(KFToolBarConstraintBuilderSpec)

describe(@"KFToolBarConstraintBuilder", ^{
	__block KFToolBarConstraintBuilder *sut = nil;
	
	context(@"new instance", ^{
		__block NSArray *left = nil;
		__block NSArray *right = nil;

		beforeEach(^{
			left = @[[NSButton nullMock], [NSButton nullMock]];
			right = @[[NSButton nullMock], [NSButton nullMock]];
			sut = [[KFToolBarConstraintBuilder alloc] initWithLeftItems:left rightItems:right];
		});
		afterEach(^{
			left = nil;
			right = nil;
			sut = nil;
		});
		it(@"should exist", ^{
			[[sut shouldNot] beNil];
		});
		it(@"should have the correct visual format string", ^{
			NSString *expectedString = @"|[left0]-[left1]-(>=8@249)-[right0]-[right1]|";
			[[sut.visualFormatString should] equal:expectedString];
		});
		it(@"should have the correct view binding keys", ^{
			NSArray *expectedKeys = @[@"left0", @"left1", @"right0", @"right1"];
			[[[sut.viewBindings allKeys] should] containObjectsInArray:expectedKeys];
		});
		it(@"should have the correct view binding values", ^{
			NSArray *expectedvalues = [left arrayByAddingObjectsFromArray:right];
			[[[sut.viewBindings allValues] should] containObjectsInArray:expectedvalues];
		});
		it(@"should have 4 view binding entries", ^{
			[[sut.viewBindings should] haveCountOf:4];
		});
		context(@"when having only left items", ^{
			beforeEach(^{
				sut = [[KFToolBarConstraintBuilder alloc] initWithLeftItems:left rightItems:nil];
			});
			it(@"should have the correct visual format string", ^{
				NSString *expectedString = @"|[left0]-[left1]";
				[[sut.visualFormatString should] equal:expectedString];
			});
			it(@"should have the correct view binding keys", ^{
				NSArray *expectedKeys = @[@"left0", @"left1"];
				[[[sut.viewBindings allKeys] should] containObjectsInArray:expectedKeys];
			});
			it(@"should have the correct view binding values", ^{
				[[[sut.viewBindings allValues] should] containObjectsInArray:left];
			});
			it(@"should have 2 view binding entries", ^{
				[[sut.viewBindings should] haveCountOf:2];
			});
		});
		context(@"when having only right items", ^{
			beforeEach(^{
				sut = [[KFToolBarConstraintBuilder alloc] initWithLeftItems:nil rightItems:right];
			});
			it(@"should have the correct visual format string", ^{
				NSString *expectedString = @"[right0]-[right1]|";
				[[sut.visualFormatString should] equal:expectedString];
			});
			it(@"should have the correct view binding keys", ^{
				NSArray *expectedKeys = @[@"right0", @"right1"];
				[[[sut.viewBindings allKeys] should] containObjectsInArray:expectedKeys];
			});
			it(@"should have the correct view binding values", ^{
				[[[sut.viewBindings allValues] should] containObjectsInArray:right];
			});
			it(@"should have 2 view binding entries", ^{
				[[sut.viewBindings should] haveCountOf:2];
			});
		});
		context(@"when habing no items", ^{
			beforeEach(^{
				sut = [[KFToolBarConstraintBuilder alloc] initWithLeftItems:nil rightItems:nil];
			});
			it(@"should have a nil visual format string", ^{
				[[sut.visualFormatString should] beNil];
			});
		});
	});
});

SPEC_END
