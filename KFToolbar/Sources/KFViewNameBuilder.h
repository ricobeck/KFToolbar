//
//  KFViewNameBuilder.h
//  KFToolbar
//
//  Created by Markus Müller on 08.02.14.
//  Copyright (c) 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFViewNameBuilder : NSObject

@property (copy) NSString *prefix;
@property (nonatomic, readonly) NSArray *variableNames;
@property (nonatomic, readonly) NSArray *claspedVariableNames;

- (id)initWithPrefix:(NSString*)aPrefix itemCount:(NSUInteger)count;

@end
