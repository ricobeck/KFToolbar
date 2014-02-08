//
//  KFViewNameBuilderSpec.m
//  KFToolbar
//
//  Created by Markus Müller on 08.02.14.
//  Copyright 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import "Kiwi.h"
#import "KFViewNameBuilder.h"

SPEC_BEGIN(KFViewNameBuilderSpec)

describe(@"KFViewNameBuilder", ^{
	__block KFViewNameBuilder *sut = nil;

	context(@"a new instance with prefix view", ^{
		beforeEach(^{
			sut = [[KFViewNameBuilder alloc] initWithPrefix:@"view" itemCount:3];
		});
		afterEach(^{
			sut = nil;
		});
		it(@"should exist", ^{
			[[sut shouldNot] beNil];
		});
		it(@"should have the prefix", ^{
			[[sut.prefix should] equal:@"view"];
		});
		it(@"should have 3 variable names", ^{
			[[[sut should] have:3] variableNames];
		});
		it(@"should have the prefixed variable names", ^{
			[[[sut.variableNames objectAtIndex:0] should] equal:@"view0"];
			[[[sut.variableNames objectAtIndex:1] should] equal:@"view1"];
			[[[sut.variableNames objectAtIndex:2] should] equal:@"view2"];
		});
		it(@"should have the brackeded variable names", ^{
			[[[sut.claspedVariableNames objectAtIndex:0] should] equal:@"[view0]"];
			[[[sut.claspedVariableNames objectAtIndex:1] should] equal:@"[view1]"];
			[[[sut.claspedVariableNames objectAtIndex:2] should] equal:@"[view2]"];
		});
	});
});

SPEC_END
