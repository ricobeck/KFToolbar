//
//  KFItemConstraintBuilder.m
//  KFToolbar
//
//  Created by Markus Müller on 08.02.14.
//  Copyright (c) 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import "KFItemConstraintBuilder.h"
#import "KFViewNameBuilder.h"

@interface KFItemConstraintBuilder ()

@end

@implementation KFItemConstraintBuilder

- (id)initWithIdentifier:(NSString*)identifier
{
	self = [super init];
    if (self) {
       _identifier = [identifier copy];
    }
    return self;
}

- (NSString*)visualFormatString
{
	if ([self.items count] == 0) {
		return @"";
	}
	KFViewNameBuilder *nameBuilder = [[KFViewNameBuilder alloc] initWithPrefix:self.identifier itemCount:[self.items count]];
	return [nameBuilder.claspedVariableNames componentsJoinedByString:@"-"];
}

@end
