//
//  KFViewBindingsBuilderSpec.m
//  KFToolbar
//
//  Created by Markus Müller on 08.02.14.
//  Copyright 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import "Kiwi.h"
#import "KFViewBindingsBuilder.h"

SPEC_BEGIN(KFViewBindingsBuilderSpec)

describe(@"KFViewBindingsBuilder", ^{
	__block KFViewBindingsBuilder *sut = nil;

	context(@"a new instance", ^{
		__block NSArray *items = nil;
		beforeEach(^{
			items = @[[NSObject nullMock], [NSObject nullMock], [NSObject nullMock]];
			sut = [[KFViewBindingsBuilder alloc] init];
		});
		afterEach(^{
			sut = nil;
		});
		it(@"should exist", ^{
			[[sut shouldNot] beNil];
		});
		context(@"itemVariableBindingsDictionary", ^{
			beforeEach(^{
				[sut addItems:items withPrefix:@"name"];
			});
			it(@"should not be nil", ^{
				[[sut.itemVariableBindingsDictionary shouldNot] beNil];
			});
			it(@"should have the correct keys", ^{
				NSArray *expectedKeys = @[@"name0", @"name1", @"name2"];
				[[[sut.itemVariableBindingsDictionary allKeys] should] containObjectsInArray:expectedKeys];
			});
			it(@"should have the values", ^{
				[[[sut.itemVariableBindingsDictionary allValues] should] containObjectsInArray:items];
			});
			context(@"when adding more items with another prefix", ^{
				__block NSArray *moreItems = nil;
				beforeEach(^{
					moreItems = @[[NSObject nullMock], [NSObject nullMock]];
					[sut addItems:moreItems withPrefix:@"moreItems"];
				});
				it(@"should have the keys", ^{
					NSArray *expectedKeys = @[@"moreItems0", @"moreItems1"];
					[[[sut.itemVariableBindingsDictionary allKeys] should] containObjectsInArray:expectedKeys];
				});
				it(@"should have the values", ^{
					[[[sut.itemVariableBindingsDictionary allValues] should] containObjectsInArray:moreItems];
				});
			});
		});
	});
});

SPEC_END
