//
//  KFToolBarConstraintBuilder.m
//  KFToolbar
//
//  Created by Markus Müller on 08.02.14.
//  Copyright (c) 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import "KFToolBarConstraintBuilder.h"
#import "KFItemConstraintBuilder.h"
#import "KFViewBindingsBuilder.h"

@interface KFToolBarConstraintBuilder ()

@property (strong) KFItemConstraintBuilder *leftBuilder;
@property (strong) KFItemConstraintBuilder *rightBuilder;
@property (strong) KFViewBindingsBuilder *viewBindingsBuilder;

@end

@implementation KFToolBarConstraintBuilder

@dynamic layoutPriority;

- (id)initWithLeftItems:(NSArray*)leftItems rightItems:(NSArray*)rightItems
{
	self = [super init];
    if (self) {
		_viewBindingsBuilder = [[KFViewBindingsBuilder alloc] init];
		_allowOverlappingItems = YES;
		if ([leftItems count]) {
			_leftBuilder = [[KFItemConstraintBuilder alloc] initWithIdentifier:@"left"];
			_leftBuilder.items = leftItems;
			[_viewBindingsBuilder addItems:leftItems withPrefix:@"left"];
		}
		if ([rightItems count]) {
			_rightBuilder = [[KFItemConstraintBuilder alloc] initWithIdentifier:@"right"];
			_rightBuilder.items = rightItems;
			[_viewBindingsBuilder addItems:rightItems withPrefix:@"right"];
		}
    }
    return self;
}

- (NSString*)visualFormatString
{
	NSString *leftString = self.leftBuilder.visualFormatString;
	NSString *rightString = self.rightBuilder.visualFormatString;

	if (leftString && rightString) {
		return [NSString stringWithFormat:@"|%@-(>=8@%@)-%@|", leftString, @(self.layoutPriority), rightString];
	}
	else if (leftString && !rightString) {
		return [NSString stringWithFormat:@"|%@", leftString];
	}
	else if (!leftString && rightString) {
		return [NSString stringWithFormat:@"%@|", rightString];
	}
	return nil;
}

- (NSDictionary*)viewBindings
{
	return self.viewBindingsBuilder.itemVariableBindingsDictionary;
}

- (NSLayoutPriority)layoutPriority
{
	return self.allowOverlappingItems ? NSLayoutPriorityWindowSizeStayPut : NSLayoutPriorityWindowSizeStayPut + 1;
}

@end
