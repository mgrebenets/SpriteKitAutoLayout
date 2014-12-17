//
//  SKNode+SKAL.h
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 14/12/2014.
//  Copyright (c) 2014 i4nApps. All rights reserved.
//

@import SpriteKit;

#import "SKView+SKAL.h"

/**
 Auto Layout extension for SKNode
 */
@interface SKNode (SKAL)

#pragma mark Managing Constraints
/**
 Returns the constraints held by the view.
 */
- (NSArray *)constraints;

/**
 Adds a constraint on the layout of the receiving view or its subviews.
 */
- (void)addConstraint:(NSLayoutConstraint *)constraint;

/**
 Adds multiple constraints on the layout of the receiving view or its subviews.
 */
- (void)addConstraints:(NSArray *)constraints;

/**
 Removes the specified constraint from the view.
 */
- (void)removeConstraint:(NSLayoutConstraint *)constraint;

/**
 Removes the specified constraints from the view.
 */
- (void)removeConstraints:(NSArray *)constraints;

#pragma mark Managing Nodes Layout

/**
 Returns dictionary of all child nodes that have name
 Use it for creating constraints with visual formatting language
 */
- (NSDictionary *)nodes;

/**
 Enable or disable Auto layout
 By default it's disabled
 */
- (void)setAutoLayoutEnabled:(BOOL)enabled;

/**
 Returns Auto Layout Enabled property value
 */
- (BOOL)isAutoLayoutEnabled;

/**
 Layout nodes recursively
 */
- (void)layoutNodes;
@end
