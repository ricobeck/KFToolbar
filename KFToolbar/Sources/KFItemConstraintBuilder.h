//
//  KFItemConstraintBuilder.h
//  KFToolbar
//
//  Created by Markus Müller on 08.02.14.
//  Copyright (c) 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFItemConstraintBuilder : NSObject

@property (copy, readonly) NSString *identifier;
@property (copy, readwrite) NSArray *items;
@property (nonatomic, readonly) NSString *visualFormatString;

- (id)initWithIdentifier:(NSString*)identifier;

@end
