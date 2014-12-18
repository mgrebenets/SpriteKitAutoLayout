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
void SKALSwizzleMethod(Class clazz, SEL originalSelector, SEL newSelector) {
    Method originalMethod = class_getInstanceMethod(clazz, originalSelector);
    Method newMethod = class_getInstanceMethod(clazz, newSelector);
    if(class_addMethod(clazz, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(clazz, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}
