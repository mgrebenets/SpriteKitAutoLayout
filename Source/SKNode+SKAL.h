//
//  SKNode+SKAL.h
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 14/12/2014.
//  Copyright (c) 2014 i4nApps. All rights reserved.
//

@import SpriteKit;

#import "SKView+SKAL.h"
#import "SKALUtils.h"

/**
 Auto Layout extension for `SKNode`
 */
@interface SKNode (SKAL)

#pragma mark Managing Constraints
/**
 Returns the constraints held by the view.
 @return View contraints.
 */
@property (readonly, copy) NSArray<NSLayoutConstraint *> * __nullable constraints;

/**
 Adds a constraint on the layout of the receiving view or its subviews.
 @param constraint Layout constraint.
 */
- (void)addConstraint:(NSLayoutConstraint * __nonnull)constraint;

/**
 Adds multiple constraints on the layout of the receiving view or its subviews.
 @param constraints Array of constraints to add.
 */
- (void)addConstraints:(NSArray * __nonnull)constraints;

/**
 Removes the specified constraint from the view.
 @param constraint Constraint to remove.
 */
- (void)removeConstraint:(NSLayoutConstraint * __nonnull)constraint;

/**
 Removes the specified constraints from the view.
 @param constraints Array of constraints to remove.
 */
- (void)removeConstraints:(NSArray * __nonnull)constraints;

#pragma mark Managing Nodes Layout

/**
 Returns layout proxy view which is a platform specific view.
 UIView for UIKit app (iOS).
 NSView for AppKit app (OSX).
 */
@property (nonatomic, readonly) SKALPlatformView * __nonnull layoutProxyView;

/**
 Returns the frame of layout proxy view
 */
- (CGRect)layoutFrame;

/**
 Returns dictionary of all child nodes that have name.
 Use it for creating constraints with visual formatting language.
 @return Dictionary nodes that have name.
 */
@property (nonatomic, readonly) NSDictionary <NSString *, NSObject *>* __nonnull nodesDic;

/**
 Autolayout enabled property.
 Enable it for nodes that need to use Auto Layout.
 */
@property (nonatomic, assign, getter=isAutoLayoutEnabled) BOOL autoLayoutEnabled;

/**
 Auto layout nodes recursively.
 */
- (void)autoLayoutNodes;
@end
