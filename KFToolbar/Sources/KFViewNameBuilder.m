//
//  KFViewNameBuilder.m
//  KFToolbar
//
//  Created by Markus Müller on 08.02.14.
//  Copyright (c) 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import "KFViewNameBuilder.h"

@interface KFViewNameBuilder ()

@property NSUInteger count;
@property (nonatomic, readwrite) NSArray *variableNames;
@property (nonatomic, readwrite) NSArray *claspedVariableNames;

@end

@implementation KFViewNameBuilder

- (id)initWithPrefix:(NSString*)aPrefix itemCount:(NSUInteger)count
{
    self = [super init];
    if (self) {
		_prefix = [aPrefix copy];
		_count = count;
    }
    return self;
}

- (NSArray*)variableNames
{
	if (!_variableNames) {
		NSMutableArray *names = [NSMutableArray arrayWithCapacity:self.count];
		for (int i = 0; i < self.count; ++i) {
			[names addObject:[self variableNameAtIndex:i]];
		}
		_variableNames = [names copy];
	}
	return _variableNames;
}

- (NSArray*)claspedVariableNames
{
	if (!_claspedVariableNames) {
		NSMutableArray *names = [NSMutableArray arrayWithCapacity:self.count];
		[self.variableNames enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
			[names addObject:[NSString stringWithFormat:@"[%@]" ,name]];
		}];
		_claspedVariableNames = [names copy];
	}
	return _claspedVariableNames;
}

- (NSString*)variableNameAtIndex:(NSUInteger)anIndex
{
	return [NSString stringWithFormat:@"%@%lu", self.prefix, (unsigned long)anIndex];
}

@end
