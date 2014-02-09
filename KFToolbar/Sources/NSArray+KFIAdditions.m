//
//  NSArray+KFIAdditions.m
//  KFToolbar
//
//  Created by Markus Müller on 09.02.14.
//  Copyright (c) 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import "NSArray+KFIAdditions.h"

@implementation NSArray (KFIAdditions)

- (NSArray*)kfi_minusArray:(NSArray*)other
{
	NSMutableArray *objectsNotInOtherArray = [self mutableCopy];
	[objectsNotInOtherArray removeObjectsInArray:other];
	return [objectsNotInOtherArray copy];
}

@end
