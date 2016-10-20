//
//  DatabaseParser.m
//  JiraGo
//
//  Created by Goroshenko on 7/9/15.
//  Copyright (c) 2015 DigiCode. All rights reserved.
//

#import "DatabaseParser.h"
#import "CDTravel.h"

@interface DatabaseParser()
@property (strong, nonatomic) NSDateFormatter *formatter;
@end

@implementation DatabaseParser

+ (DatabaseParser *)sharedInstance {
    static DatabaseParser *_sharedDatabaseParser = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedDatabaseParser = [[self alloc] init];
        
    });
    
    return _sharedDatabaseParser;
}

#pragma mark - Parse methods
- (NSArray *)parseTravelList:(NSArray *)items {
    NSMutableArray *array = [NSMutableArray new];
    
    for (NSDictionary *item in items) {
        CDTravel *travel = [CDTravel new];
        travel.serverID = @([item[@"id"] integerValue]);
        travel.price = @([item[@"price_in_euros"] floatValue]);
        travel.arrivalTime = item[@"arrival_time"];
        travel.departureTime = item[@"departure_time"];
        travel.numberOfChanges = item[@"number_of_stops"];
        travel.duration = [self calculateDurationWithArrivalTime:travel.arrivalTime
                                                   departureTime:travel.departureTime];
        
        //Change logo URL
        NSString *logoURL = item[@"provider_logo"];
        logoURL = [logoURL stringByReplacingOccurrencesOfString:@"{size}" withString:@"63"];
        travel.logoURL = logoURL;
        
        [array addObject:travel];
    }
    
    return [NSArray arrayWithArray:array];
}

- (NSString *)calculateDurationWithArrivalTime:(NSString *)arrivalTime  departureTime:(NSString *)departureTime {
    if (_formatter == nil) {
        self.formatter = [NSDateFormatter new];
        self.formatter.dateFormat = @"HH:mm";
    }
    
    NSDate *arrivalTimeDate = [self.formatter dateFromString:arrivalTime];
    NSDate *departureTimeDate = [self.formatter dateFromString:departureTime];
   
    if ([arrivalTimeDate compare:departureTimeDate] == NSOrderedDescending) {
        departureTimeDate = [departureTimeDate dateByAddingTimeInterval:24*3600];
    }
    
    NSCalendarUnit components = (NSCalendarUnit)(NSCalendarUnitHour | NSCalendarUnitMinute);
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:components
                                                                       fromDate:arrivalTimeDate
                                                                         toDate:departureTimeDate
                                                                        options:(NSCalendarOptions)0];
    
    NSString *resultString = [NSString stringWithFormat:@"%ld:%ldh", (long)dateComponents.hour, (long)dateComponents.minute];
    
    return resultString;
    
    

}

@end
