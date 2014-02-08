//
//  KFItemConstraintBuilderSpec.m
//  KFToolbar
//
//  Created by Markus Müller on 08.02.14.
//  Copyright 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import "Kiwi.h"
#import "KFItemConstraintBuilder.h"

SPEC_BEGIN(KFItemConstraintBuilderSpec)

describe(@"KFItemConstraintBuilder", ^{
	__block KFItemConstraintBuilder *sut = nil;

	context(@"a new instance with identifier name", ^{
			beforeEach(^{
				sut = [[KFItemConstraintBuilder alloc] initWithIdentifier:@"name"];
		});
		afterEach(^{
			sut = nil;
		});
		it(@"should exist", ^{
			[[sut shouldNot] beNil];
		});
		it(@"should have the identifier", ^{
			[[sut.identifier should] equal:@"name"];
		});
		it(@"should return an empty visualFormatString", ^{
			[[sut.visualFormatString should] equal:@""];
		});
		context(@"when setting items", ^{
			__block NSArray *items = nil;
			beforeEach(^{
				items = @[[NSObject nullMock], [NSObject nullMock], [NSObject nullMock]];
				sut.items = items;
			});
			it(@"should set the items", ^{
				[[sut.items should] equal:items];
			});
			it(@"should create the visual format string for the items", ^{
				[[sut.visualFormatString should] equal:@"[name0]-[name1]-[name2]"];
			});
		});
		
	});
});

SPEC_END
