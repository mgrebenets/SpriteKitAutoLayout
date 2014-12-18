//
//  SKNode+SKAL.m
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 14/12/2014.
//  Copyright (c) 2014 i4nApps. All rights reserved.
//

@import ObjectiveC.runtime;

#import "SKNode+SKAL.h"
#import "SKNode+SKALInternal.h"
#import "SKALPlatformView+SKALInternal.h"
#import "SKALUtils.h"

/**
 `SizeableNode` protocol used to work with sizeable nodes.
 So far it's related `SKSpriteNode` and `SKVideoNode`.
 */
@protocol SizeableNode <NSObject>
@required
/** 
 Anchor point.
 */
@property (nonatomic) CGPoint anchorPoint;
/** 
 Size.
 */
@property (nonatomic) CGSize size;
@end

// Make it loadable
SKAL_MAKE_CATEGORIES_LOADABLE(SKNode_SKAL)

// SKNode AutoLayout category implementation
@implementation SKNode (SKAL)

#pragma mark New Child Management Selectors
- (void)SKALAddChild:(SKNode *)node {
    if (!node.layoutProxyView.superview) {
        [self.layoutProxyView addSubview:node.layoutProxyView];
    }
    [self SKALAddChild:node];
}

- (void)SKALInsertChild:(SKNode *)node atIndex:(NSInteger)index {
    if (!node.layoutProxyView.superview) {
        [self.layoutProxyView SKALInsertSubview:node.layoutProxyView atIndex:index];
    }
    [self SKALInsertChild:node atIndex:index];
}

- (void)SKALRemoveChildrenInArray:(NSArray *)nodes {
    for (SKNode *node in nodes) {
        if (node.layoutProxyView.superview) {
            [node.layoutProxyView removeFromSuperview];
        }
    }
    [self SKALRemoveChildrenInArray:nodes];
}

- (void)SKALRemoveAllChildren {
    for (SKNode *node in self.children) {
        if (node.layoutProxyView.superview) {
            [node.layoutProxyView removeFromSuperview];
        }
    }
    [self SKALRemoveAllChildren];
}

- (void)SKALRemoveFromParent {
    if (self.layoutProxyView.superview) {
        [self.layoutProxyView removeFromSuperview];
    }
    [self SKALRemoveFromParent];
}

#pragma mark Loading Category
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Swizzle time!
        Class nodeClass = [self class];

        // Add child
        SKALSwizzleMethod(nodeClass, @selector(addChild:), @selector(SKALAddChild:));

        // Insert child
        SKALSwizzleMethod(nodeClass, @selector(insertChild:atIndex:), @selector(SKALInsertChild:atIndex:));

        // Remove childred in array
        SKALSwizzleMethod(nodeClass, @selector(removeChildrenInArray:), @selector(SKALRemoveChildrenInArray:));

        // Remove all children
        SKALSwizzleMethod(nodeClass, @selector(removeAllChildren), @selector(SKALRemoveAllChildren));

        // Remove from parent
        SKALSwizzleMethod(nodeClass, @selector(removeFromParent), @selector(SKALRemoveFromParent));
    });
}

#pragma mark - Managing Constraints
- (NSArray *)constraints {
    return self.layoutProxyView.constraints;
}

- (void)addConstraint:(NSLayoutConstraint *)constraint {
    [self.layoutProxyView addConstraint:constraint];
}

- (void)addConstraints:(NSArray *)constraints {
    [self.layoutProxyView addConstraints:constraints];
}

- (void)removeConstraint:(NSLayoutConstraint *)constraint {
    [self.layoutProxyView removeConstraint:constraint];
}

- (void)removeConstraints:(NSArray *)constraints {
    [self.layoutProxyView removeConstraints:constraints];
}

#pragma mark - Managing Layout
- (NSDictionary *)nodes {
    NSMutableDictionary *namedNodes = [NSMutableDictionary dictionaryWithCapacity:self.children.count];
    // Return only those children which have names
    [self enumerateChildNodesWithName:@"*" usingBlock:^(SKNode *node, BOOL *stop) {
        if (![node.name isEqualToString:@""]) {
            namedNodes[node.name] = node;
        }
    }];
    return namedNodes;
}

@dynamic autoLayoutEnabled;
- (void)setAutoLayoutEnabled:(BOOL)enabled {
    objc_setAssociatedObject(self, @selector(isAutoLayoutEnabled), @(enabled), OBJC_ASSOCIATION_ASSIGN);
    if (enabled) {
        self.layoutProxyView.translatesAutoresizingMaskIntoConstraints = NO;
    } else {
        self.layoutProxyView = nil;
    }
}

- (BOOL)isAutoLayoutEnabled {
    return [objc_getAssociatedObject(self, @selector(isAutoLayoutEnabled)) boolValue];
}

- (void)layoutNodes {
    SKALLogDebug(@"\n===Layout for %@===", self.name);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self layoutNodesRecursively];
    });
}

+ (CGRect)flippedFrame:(CGRect)frame inParentRect:(CGRect)parentRect {
    return CGRectOffset(frame, 0, (CGRectGetHeight(parentRect) - 2 * frame.origin.y) * self.flipMultiplier);
//    return CGRectOffset(frame, 0, (CGRectGetHeight(parentRect) - 1 * frame.origin.y) * 1);
}

- (void)layoutNodesRecursively {
    // need to add layout proxy view each time
    // there are cases like presenting scene for 1st time where nested nodes
    // would not be sized properly without this call
    [self.layoutProxyView SKALLayoutSubviews];

    // TODO: scene's anchor point will break things

    for (SKNode *child in self.children) {
        // Ignore autolayout for those nodes which we did not create
        // for example a Sprite node with text inside SKLabelNode
        if (!child.isAutoLayoutEnabled) {
            SKALLogDebug(@"\n\t--->Ignoring AutoLayout for child node\n\t\tName: %@\n\t\tClass: %@\n\t\tParent: %@", NSStringFromClass(child.class), child.name, self.name);
            continue;
        }

        // Flip the frame if required
        // to make visual formatting language fully compatible with UIKit/AppKit
        CGRect flippedFrame = [self.class flippedFrame:child.layoutProxyView.layoutRect inParentRect:self.layoutProxyView.layoutRect];

        SKALLogDebug(@"\n---%@---\n\tParent proxy frame: %@\n\tChild proxy frame: %@\n\tFlipped proxy frame: %@\n\tParent node frame: %@\n\tChild node frame: %@", child.name, SKALNSStringFromRect(self.layoutProxyView.layoutRect), SKALNSStringFromRect(child.layoutProxyView.layoutRect), SKALNSStringFromRect(flippedFrame), SKALNSStringFromRect(self.frame), SKALNSStringFromRect(child.frame));

        // Sizeable vs Sizeless nodes
        if ([child respondsToSelector:@selector(setSize:)]) {
            SKNode<SizeableNode> *sizeableChild = (SKNode<SizeableNode> *)child;
            // Set the size
            sizeableChild.size = flippedFrame.size;
            // set the position using frame's origin and node's anchor point
            // Also take flip into account
            sizeableChild.position = CGPointMake(flippedFrame.origin.x + sizeableChild.size.width * (sizeableChild.anchorPoint.x), flippedFrame.origin.y + sizeableChild.size.height * (sizeableChild.anchorPoint.y - self.class.flipMultiplier));

            SKALLogDebug(@"\tSizeable(%@)\n\tframe: %@\n\tsize: %@\n\tanchor: %@\n\tposition: %@", child.name, SKALNSStringFromRect(sizeableChild.frame), SKALNSStringFromSize(sizeableChild.size), SKALNSStringFromPoint(sizeableChild.anchorPoint), SKALNSStringFromPoint(sizeableChild.position));
        } else {
            // child position taking this child's frame into account and flip
            child.position = CGPointMake(flippedFrame.origin.x + CGRectGetWidth(child.frame) / 2, flippedFrame.origin.y - self.class.flipMultiplier * CGRectGetHeight(flippedFrame));

            SKALLogDebug(@"\tSizeless(%@)\n\tframe: %@\n\tposition: %@", child.name, SKALNSStringFromRect(child.frame), SKALNSStringFromPoint(child.position));
        }

        [child layoutNodesRecursively];
    }
}
@end
