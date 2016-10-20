//
//  DatabaseParser.h
//
//  Created by Goroshenko on 7/9/15.
//  Copyright (c) 2015 DigiCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseParser : NSObject

+ (DatabaseParser *)sharedInstance;
- (NSArray *)parseTravelList:(NSArray *)items;

@end
