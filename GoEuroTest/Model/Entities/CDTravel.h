//
//  CDTravel.h
//  GoEuroTest
//
//  Created by Yurii Goroshenko on 10/20/16.
//  Copyright © 2016 Yurii Goroshenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDTravel : NSObject

@property (strong, nonatomic) NSNumber *serverID;
@property (strong, nonatomic) NSString *logoURL;
@property (strong, nonatomic) NSNumber *numberOfChanges;
#warning Server should be Timestamp
@property (strong, nonatomic) NSString *departureTime;
#warning Server should be Timestamp
@property (strong, nonatomic) NSString *arrivalTime;
@property (strong, nonatomic) NSString *duration;
@property (strong, nonatomic) NSNumber *price;


@end
