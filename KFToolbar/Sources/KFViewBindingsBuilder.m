//
//  KFViewBindingsBuilder.m
//  KFToolbar
//
//  Created by Markus Müller on 08.02.14.
//  Copyright (c) 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import "KFViewBindingsBuilder.h"
#import "KFViewNameBuilder.h"

@interface KFViewBindingsBuilder ()

@property (strong) NSMutableDictionary *viewBindings;

@end

@implementation KFViewBindingsBuilder

- (id)init
{
    self = [super init];
    if (self) {
        _viewBindings = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addItems:(NSArray*)items withPrefix:(NSString*)prefix
{
	KFViewNameBuilder *nameBuilder = [[KFViewNameBuilder alloc] initWithPrefix:prefix itemCount:[items count]];
	NSDictionary *dict = [NSDictionary dictionaryWithObjects:items forKeys:nameBuilder.variableNames];
	[self.viewBindings setValuesForKeysWithDictionary:dict];
}

- (NSDictionary*)itemVariableBindingsDictionary
{
	return [self.viewBindings copy];
}


@end
