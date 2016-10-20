//
//  UIView+XibLoader.h
//
//  Created by Goroshenko on 9/30/14.
//  Copyright (c) 2014 DigiCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XibLoader)
+ (id) loadFromXibNamed:(NSString *) xibName;
+ (id) loadFromXib;
@end
