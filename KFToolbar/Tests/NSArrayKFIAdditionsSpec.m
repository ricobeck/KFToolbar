//
//  NSArrayKFIAdditionsSpec.m
//  KFToolbar
//
//  Created by Markus Müller on 09.02.14.
//  Copyright 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import "Kiwi.h"
#import "NSArray+KFIAdditions.h"

SPEC_BEGIN(NSArrayKFIAdditionsSpec)

describe(@"NSArray KFIAdditions", ^{
	context(@"minusArray:", ^{
		it(@"should return the distinct objects from two arrays", ^{
			NSArray *strings = @[@"one", @"two", @"three", @"four", @"five"];
			NSArray *expectedArray = @[@"one", @"three", @"five"];
			[[[strings kfi_minusArray:@[@"two", @"four"]] should] equal:expectedArray];
		});
	});
});

SPEC_END
