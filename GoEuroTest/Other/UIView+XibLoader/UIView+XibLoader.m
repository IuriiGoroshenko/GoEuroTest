//
//  UIView+XibLoader.m
//
//  Created by Goroshenko on 9/30/14.
//  Copyright (c) 2014 DigiCode. All rights reserved.
//

#import "UIView+XibLoader.h"

@implementation UIView (XibLoader)

+ (id) loadFromXibNamed:(NSString *) xibName {
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];
    for (id currentObject in topLevelObjects) {
        if ([currentObject isKindOfClass:self]) {
            return currentObject;
        }
    }
    return nil;
}

+ (id) loadFromXib {
    return [self loadFromXibNamed:NSStringFromClass(self)];
}

@end
