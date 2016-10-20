//
//  MMCLogger.h
//
//  Created by Yurii Goroshenko on 5/6/16.
//  Copyright © 2016 Digicode. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Quick way to access [[MCLogger sharedInstance] log:]
FOUNDATION_EXPORT void MCLog(NSObject *object);

/// Quick way to access [[MCLogger sharedInstance] logErrorMessage:]
FOUNDATION_EXPORT void MCLogErrorMessage(NSString *errorMessage);

/// Quick way to access [[MCLogger sharedInstance] logInfoMessage:]
FOUNDATION_EXPORT void MCLogInfoMessage(NSString *infoMessage);

/// Quick way to access [[MCLogger sharedInstance] logSuccessMessage:]
FOUNDATION_EXPORT void MCLogSuccessMessage(NSString *successMessage);

@interface MCLogger : NSObject

+ (MCLogger *)sharedInstance;
- (void)log:(NSObject *)object;
- (void)logString:(NSString *)logMessage;

#pragma mark -
- (void)logInfoMessage:(NSString *)infoMessage;
- (void)logSuccessMessage:(NSString *)successMessage;
- (void)logErrorMessage:(NSString *)errorMessage;
- (void)logError:(NSError *)error;

@end
