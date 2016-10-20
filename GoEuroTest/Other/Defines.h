//
//  Defines.h
//
//  Created by Yurii Goroshenko on 7/20/16.
//  Copyright © 2016 Yurii Goroshenko. All rights reserved.
//


#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MCLogger.h"
#endif


#define IfStringValueNotNull(p) if (p != nil && p != [NSNull class] && [p isKindOfClass:[NSString class]])
#define IfArrayValueNotNull(p) if (p != nil && p != [NSNull class] && [p isKindOfClass:[NSArray class]])
#define IfDictionaryValueNotNull(p) if (p != nil && p != [NSNull class] && [p isKindOfClass:[NSDictionary class]])

//*** Devices
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)


#define UN_SELECTED_TEXT @{NSFontAttributeName : [UIFont fontWithName:@"Optima" size:18]}
#define SELECTED_TEXT @{NSFontAttributeName : [UIFont fontWithName:@"Optima" size:18]}


#define COLOR_BLUE    [UIColor colorWithRed:15.0 / 255.0 green:95.0 / 255.0 blue:165.0 / 255.0 alpha:1.0f]
#define COLOR_BLUE_LIGHT  [UIColor colorWithRed:0.0 / 255.0 green:171.0 / 255.0 blue:243.0 / 255.0 alpha:1.0]
