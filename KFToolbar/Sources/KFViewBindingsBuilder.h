//
//  KFViewBindingsBuilder.h
//  KFToolbar
//
//  Created by Markus Müller on 08.02.14.
//  Copyright (c) 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFViewBindingsBuilder : NSObject

@property (nonatomic, readonly) NSDictionary *itemVariableBindingsDictionary;

- (void)addItems:(NSArray*)items withPrefix:(NSString*)prefix;

@end
