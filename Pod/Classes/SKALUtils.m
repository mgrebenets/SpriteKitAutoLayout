//
//  SKALUtils.m
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 16/12/2014.
//  Copyright (c) 2014 i4nApps. All rights reserved.
//

@import Foundation;
@import ObjectiveC.runtime;

// Swizzle
void SKALSwizzleMethod(Class c, SEL orig, SEL new) {
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if(class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}

// Inject
void SKALInjectMethod(Class c, SEL orig, SEL new, SEL backup) {
    SKALSwizzleMethod(c, backup, orig);
    SKALSwizzleMethod(c, orig, new);
}
