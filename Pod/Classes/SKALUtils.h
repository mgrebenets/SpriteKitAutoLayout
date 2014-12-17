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
#define SKALPlatformView UIView
#define SKALNSStringFromRect NSStringFromCGRect
#define SKALNSStringFromSize NSStringFromCGSize
#define SKALNSStringFromPoint NSStringFromCGPoint
#else
#define SKALPlatformView NSView
#define SKALNSStringFromRect NSStringFromRect
#define SKALNSStringFromSize NSStringFromSize
#define SKALNSStringFromPoint NSStringFromPoint
#endif

/**
 Logging
 */
#ifdef SKAL_DEBUG
#define SKALLogDebug(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define SKALLogDebug(...)
#endif

/** 
 Make categories loadable
 */
#define SKAL_MAKE_CATEGORIES_LOADABLE(UNIQUE_NAME) @interface FORCELOAD_##UNIQUE_NAME : NSObject @end @implementation FORCELOAD_##UNIQUE_NAME @end

/**
 Swizzle method
 */
extern void SKALSwizzleMethod(Class c, SEL orig, SEL new);

/**
 Inject method (backup original implementation and replace with new one)
 */
extern void SKALInjectMethod(Class c, SEL orig, SEL new, SEL backup);

