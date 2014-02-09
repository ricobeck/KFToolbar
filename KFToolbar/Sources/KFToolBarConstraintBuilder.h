//
//  KFToolBarConstraintBuilder.h
//  KFToolbar
//
//  Created by Markus Müller on 08.02.14.
//  Copyright (c) 2014 com.kf-interactive.toolbar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFToolBarConstraintBuilder : NSObject

@property (nonatomic, readonly) NSString *visualFormatString;
@property (nonatomic, readonly) NSDictionary *viewBindings;
@property (nonatomic) BOOL allowOverlappingItems;
@property (nonatomic, readonly) NSLayoutPriority layoutPriority;

- (id)initWithLeftItems:(NSArray*)leftItems rightItems:(NSArray*)rightItems;

@end
