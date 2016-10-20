//
//  HTTPManager.h
//
//  Created by Goroshenko on 6/17/15.
//  Copyright (c) 2015 DigiCode. All rights reserved.
//

#import "BaseHTTPClient.h"

//** Developer
#define SERVER_DEVELOP         @"https://api.myjson.com/bins"
//** Live

//** Main Host
#define SERVER_HOST            SERVER_DEVELOP


@interface HTTPManager : BaseHTTPClient

+ (HTTPManager *)sharedInstance;
+ (NSString *)hostName;

- (void)getTravelFlightsWithCompletion:(void (^)(NSArray *array, NSError *error))completion;
- (void)getTravelTrainsWithCompletion:(void (^)(NSArray *array, NSError *error))completion;
- (void)getTravelBusesWithCompletion:(void (^)(NSArray *array, NSError *error))completion;

@end
