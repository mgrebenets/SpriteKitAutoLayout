//
//  SKALUtils.h
//  SpriteKitAutoLayout
//
//  Created by Maksym Grebenets on 16/12/2014.
//  Copyright (c) 2014 i4nApps. All rights reserved.
//

/**
 Cross platform defines
 */
#if TARGET_OS_IPHONE
#define SKAL_IOS    (YES)
#define SKAL_OSX    (NO)
#define SKALPlatformView UIView
#define SKALNSStringFromRect NSStringFromCGRect
#define SKALNSStringFromSize NSStringFromCGSize
#define SKALNSStringFromPoint NSStringFromCGPoint
#else
#define SKAL_IOS    (NO)
#define SKAL_OSX    (YES)
#define SKALPlatformView NSView
#define SKALNSStringFromRect NSStringFromRect
#define SKALNSStringFromSize NSStringFromSize
#define SKALNSStringFromPoint NSStringFromPoint
#endif


// TODO: remove for production
//#define SKAL_DEBUG  DEBUG

/**
 Logging
 */
#if SKAL_DEBUG
#define SKALLogDebug(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define SKALLogDebug(...)
#endif

/** 
 Make categories loadable
 */
#define SKAL_MAKE_CATEGORIES_LOADABLE(UNIQUE_NAME) @interface FORCELOAD_##UNIQUE_NAME : NSObject @end @implementation FORCELOAD_##UNIQUE_NAME @end

/**
 Swizzle method.
 @param clazz Class for which the instance method will be swizzled.
 @param originalSelector Original selector to be replaced.
 @param newSelector New selector to be used instead of original.
 */
extern void SKALSwizzleMethod(Class clazz, SEL originalSelector, SEL newSelector);

/**
 Define double swizzle guard
 @abstract A pair of special methods used to detect swizzling and prevent double swizzling
 This happens when category is loaded twice, for example for unit testing
 it's loaded once as part of test host bundle (app bundle) and then again
 as part of unit test bundle.
 Using dispatch_once doesn't help, since dispatch token is be different for each app bundle.
 
 Before swizzled, the method returns FALSE, indicating that no swizzling occured yet.
 Once swizzled, new implementation returns TRUE, indicating that swizzling has already happened.
 */
#define DECLARE_DOUBLE_SWIZZLE_GUARD() \
+ (BOOL)SKALCategoryLoaded { return FALSE; } \
+ (BOOL)SKALCategoryLoadedSwizzled { return TRUE; }

/**
 Macro used to protect form double swizzling
 Checks if the special class method returns TRUE indicating that this category is already loaded
 and then returns. Otherwise swizzle guard method that returns FALSE with method that returns TRUE.
 */
#define PROTECT_FROM_DOUBLE_SWIZZLE() \
if ([self.class SKALCategoryLoaded]) { \
    NSLog(@"SKAL category on %@ is already loaded!", NSStringFromClass(self.class)); \
    return; \
} \
SKALSwizzleMethod(object_getClass((id)self), @selector(SKALCategoryLoaded), @selector(SKALCategoryLoadedSwizzled));
