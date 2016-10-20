//
//  HTTPManager.m
//  JiraGo
//
//  Created by Goroshenko on 6/17/15.
//  Copyright (c) 2015 DigiCode. All rights reserved.
//

#import "HTTPManager.h"
#import "DatabaseParser.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface HTTPManager ()
@end

@implementation HTTPManager

+ (HTTPManager *)sharedInstance {
    static HTTPManager *_sharedHTTPClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
        NSURL *baseURL = [NSURL URLWithString:[HTTPManager hostName]];
        
        _sharedHTTPClient = [[HTTPManager alloc] initWithBaseURL:baseURL
                                            sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        _sharedHTTPClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedHTTPClient.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [_sharedHTTPClient.requestSerializer setTimeoutInterval:10];
        //        [_sharedHTTPClient.operationQueue setMaxConcurrentOperationCount:3];
        
        ((AFJSONResponseSerializer*)_sharedHTTPClient.responseSerializer).removesKeysWithNullValues = YES;
    });
    
    return _sharedHTTPClient;
}

+ (NSString *)hostName {
    return SERVER_HOST;
}

- (NSString *)hostName {
    return [HTTPManager hostName];
}

#warning URLs return data array, not valid JSON. Is TEMP method for current logic
- (void)getDataOperationWithURL:(NSString *)url completion:(void (^)(id responseObject, NSError *error))completion {
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_HOST, url]];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (completion)
            completion(responseObject, error);
    }];
    
    [dataTask resume];
}

#pragma mark - GETs
//*** https://api.myjson.com/bins/w60i for flights
- (void)getTravelFlightsWithCompletion:(void (^)(NSArray *array, NSError *error))completion {
    NSString *stringURL = @"/w60i";
    
    [self getDataOperationWithURL:stringURL completion:^(id responseObject, NSError *error) {
        if (completion) {
            NSArray *objects = nil;
            if (error == nil) {
                objects = [[DatabaseParser sharedInstance] parseTravelList:responseObject];
            }
            
            completion(objects, error);
        }
    }];
    
    //    [self getAFOperationWithURL:stringURL parameters:nil completionHandler:^(id responseObject, NSError *error) {
    //        if (completion)
    //            completion(responseObject,error);
    //    }];
}

//*** https://api.myjson.com/bins/3zmcy for trains
- (void)getTravelTrainsWithCompletion:(void (^)(NSArray *array, NSError *error))completion {
    NSString *stringURL = @"/3zmcy";
    
    [self getDataOperationWithURL:stringURL completion:^(id responseObject, NSError *error) {
        if (completion) {
            NSArray *objects = nil;
            if (error == nil) {
                objects = [[DatabaseParser sharedInstance] parseTravelList:responseObject];
            }
            
            completion(objects, error);
        }
    }];
    
    //    [self getAFOperationWithURL:stringURL parameters:nil completionHandler:^(id responseObject, NSError *error) {
    //        if (completion)
    //            completion(responseObject,error);
    //    }];
}

//*** https://api.myjson.com/bins/37yzm for buses
- (void)getTravelBusesWithCompletion:(void (^)(NSArray *array, NSError *error))completion {
    NSString *stringURL = @"/37yzm";
    
    [self getDataOperationWithURL:stringURL completion:^(id responseObject, NSError *error) {
        if (completion) {
            NSArray *objects = nil;
            if (error == nil) {
                objects = [[DatabaseParser sharedInstance] parseTravelList:responseObject];
            }
            
            completion(objects, error);
        }
    }];
    
    //    [self getAFOperationWithURL:stringURL parameters:nil completionHandler:^(id responseObject, NSError *error) {
    //        if (completion)
    //            completion(responseObject,error);
    //    }];
}

@end
