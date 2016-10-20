//
//  MCLogger.m
//
//  Created by Yurii Goroshenko on 5/6/16.
//  Copyright © 2016 Digicode. All rights reserved.
//

#import "MCLogger.h"

FOUNDATION_EXTERN void MCLog(NSObject *object) {
    [[MCLogger sharedInstance] log:object];
}

FOUNDATION_EXTERN void MCLogErrorMessage(NSString *errorMessage) {
    [[MCLogger sharedInstance] logErrorMessage:errorMessage];
}

FOUNDATION_EXTERN void MCLogInfoMessage(NSString *infoMessage) {
    [[MCLogger sharedInstance] logInfoMessage:infoMessage];
}

FOUNDATION_EXTERN void MCLogSuccessMessage(NSString *successMessage) {
    [[MCLogger sharedInstance] logSuccessMessage:successMessage];
}

@implementation MCLogger

#pragma mark - Object live cycle
+ (MCLogger *)sharedInstance {
    static MCLogger *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Actual Logging
- (void)logString:(NSString *)logMessage {
    NSLog(@"%@", logMessage);
}

#pragma mark - Universal Logging
- (void)log:(NSObject *)object {
    if ([object isKindOfClass:[NSError class]]) {
        [self logError:((NSError *)object)];
    } else {
        [self logInfoMessage:object.description];
    }
}

#pragma mark - Logging strings

- (void)logErrorMessage:(NSString *)errorMessage {
    NSString *logString = [NSString stringWithFormat:@"🔴 %@🔴", errorMessage];
    [self logString:logString];
}

- (void)logInfoMessage:(NSString *)infoMessage {
    NSString *logString = [NSString stringWithFormat:@"🔵 %@🔵", infoMessage];
    [self logString:logString];
}

- (void)logSuccessMessage:(NSString *)successMessage
{
    NSString *logString = [NSString stringWithFormat:@"✅ %@✅", successMessage];
    [self logString:logString];
}

#pragma mark - Logging special objects
- (void)logError:(NSError *)error {
    NSString *errorString = [NSString stringWithFormat:@"Error %li: \"%@\"", (long)error.code, error.localizedDescription];
    [self logErrorMessage:errorString];
}


@end
