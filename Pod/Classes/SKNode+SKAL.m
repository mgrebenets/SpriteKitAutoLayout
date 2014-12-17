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
 Sizeable Node protocol
 So far it's SKSpriteNode and SKVideoNode
 */
@protocol SizeableNode <NSObject>
@required
// Anchor point
@property (nonatomic) CGPoint anchorPoint;
// Size
@property (nonatomic) CGSize size;
@end

// Make it loadable
SKAL_MAKE_CATEGORIES_LOADABLE(SKNode_SKAL)

// SKNode AutoLayout category implementation
@implementation SKNode (SKAL)

#pragma mark Original Child Management Selectors
- (void)originalAddChild:(SKNode *)node { /* Stub */ }
- (void)originalInsertChild:(SKNode *)node atIndex:(NSInteger)index { /* Stub */ }
- (void)originalRemoveChildrenInArray:(NSArray *)nodes { /* Stub */ }
- (void)originalRemoveAllChildren { /* Stub */ }
- (void)originalRemoveFromParent { /* Stub */ }

#pragma mark New Child Management Selectors
- (void)autoLayoutAddChild:(SKNode *)node {
    if (!node.layoutProxyView.superview) {
        [self.layoutProxyView addSubview:node.layoutProxyView];
    }
    [self originalAddChild:node];
}

- (void)autoLayoutInsertChild:(SKNode *)node atIndex:(NSInteger)index {
    if (!node.layoutProxyView.superview) {
        [self.layoutProxyView SKALInsertSubview:node.layoutProxyView atIndex:index];
    }
    [self originalInsertChild:node atIndex:index];
}

- (void)autoLayoutRemoveChildrenInArray:(NSArray *)nodes {
    for (SKNode *node in nodes) {
        if (node.layoutProxyView.superview) {
            [node.layoutProxyView removeFromSuperview];
        }
    }
    [self originalRemoveChildrenInArray:nodes];
}

- (void)autoLayoutRemoveAllChildren {
    for (SKNode *node in self.children) {
        if (node.layoutProxyView.superview) {
            [node.layoutProxyView removeFromSuperview];
        }
    }
    [self originalRemoveAllChildren];
}

- (void)autoLayoutRemoveFromParent {
    if (self.layoutProxyView.superview) {
        [self.layoutProxyView removeFromSuperview];
    }
    [self originalRemoveFromParent];
}

#pragma mark Loading Category
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // swizzle time!
        Class nodeClass = [SKNode class];

        // add child
        SKALInjectMethod(nodeClass, @selector(addChild:), @selector(autoLayoutAddChild:), @selector(originalAddChild:));

        // insert child
        SKALInjectMethod(nodeClass, @selector(insertChild:atIndex:), @selector(autoLayoutInsertChild:atIndex:), @selector(originalInsertChild:atIndex:));

        // remove childred in array
        SKALInjectMethod(nodeClass, @selector(removeChildrenInArray:), @selector(autoLayoutRemoveChildrenInArray:), @selector(originalRemoveChildrenInArray:));

        // remove all children
        SKALInjectMethod(nodeClass, @selector(removeAllChildren), @selector(autoLayoutRemoveAllChildren), @selector(originalRemoveAllChildren));

        // remove from parent
        SKALInjectMethod(nodeClass, @selector(removeFromParent), @selector(autoLayoutRemoveFromParent), @selector(originalRemoveFromParent));
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
    // return only those children which have names
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
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.layoutProxyView SKALLayoutSubviews];
        [self layoutNodesRecursively];
    });
}

+ (CGRect)flippedFrame:(CGRect)frame inParentRect:(CGRect)parentRect {
    return CGRectOffset(frame, 0, (CGRectGetHeight(parentRect) - 2 * frame.origin.y) * self.flipMultiplier);
}

- (void)layoutNodesRecursively {

    // TODO: scene's anchor point will break things

    for (SKNode *child in self.children) {
        // Ignore autolayout for those nodes which we did not create
        // for example a Sprite node with text inside SKLabelNode
        if (!child.isAutoLayoutEnabled) {
            SKALLogDebug(@"Ignoring AutoLayout for child node\n\tName: %@\n\tClass: %@\n\tParent: %@", NSStringFromClass(child.class), child.name, self.name);
            continue;
        }

        // Flip the frame if required
        // to make visual formatting language fully compatible with UIKit/AppKit
        CGRect flippedFrame = [self.class flippedFrame:child.layoutProxyView.layoutRect inParentRect:self.layoutProxyView.layoutRect];

        SKALLogDebug(@"\n---%@---\n\tParent proxy frame: %@\n\tChild proxy frame: %@\n\tFlipped proxy frame: %@\n\tParent node frame: %@\n\tChild node frame: %@", child.name, SKALNSStringFromRect(self.layoutProxyView.layoutRect), SKALNSStringFromRect(child.layoutProxyView.layoutRect), SKALNSStringFromRect(flippedFrame), SKALNSStringFromRect(self.frame), SKALNSStringFromRect(child.frame));

        // Sizeable vs Sizeless nodes
        if ([child respondsToSelector:@selector(setSize:)]) {
            SKNode<SizeableNode> *sizeableChild = (SKNode<SizeableNode> *)child;
            // set the size
            sizeableChild.size = flippedFrame.size;
            // set the position using frame's origin and node's anchor point
            // also take flip into account
            sizeableChild.position = CGPointMake(flippedFrame.origin.x + sizeableChild.size.width * (sizeableChild.anchorPoint.x), flippedFrame.origin.y + sizeableChild.size.height * (sizeableChild.anchorPoint.y - self.class.flipMultiplier));

            SKALLogDebug(@"\n\tSizeable(%@)\n\tframe: %@\n\tsize: %@\n\tanchor: %@\n\tposition: %@", child.name, SKALNSStringFromRect(sizeableChild.frame), SKALNSStringFromSize(sizeableChild.size), SKALNSStringFromPoint(sizeableChild.anchorPoint), SKALNSStringFromPoint(sizeableChild.position));
        } else {
            // child position taking this child's frame into account and flip
            child.position = CGPointMake(flippedFrame.origin.x + CGRectGetWidth(child.frame) / 2, flippedFrame.origin.y - self.class.flipMultiplier * CGRectGetHeight(flippedFrame));

            SKALLogDebug(@"\n\tSizeless(%@)\n\tframe: %@\n\tposition: %@", child.name, SKALNSStringFromRect(child.frame), SKALNSStringFromPoint(child.position));
        }

        [child layoutNodesRecursively];
    }
}
@end
