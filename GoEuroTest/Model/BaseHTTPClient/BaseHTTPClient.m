//
//  BaseHTTPClient.m

#import "BaseHTTPClient.h"
#import "AppDelegate.h"
#import "MCLogger.h"
#import <AFNetworking/AFURLRequestSerialization.h>
#import "Defines.h"


@implementation BaseHTTPClient

- (NSString *)hostName {
    return @"";
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    return self;
}

#pragma mark - operations
- (void)postAFOperationWithURL:(NSString *)stringURL parameters:(NSDictionary *)parameters
             completionHandler:(void (^)(id responseObject, NSError *error))completionHandler
{
    
    NSString *encodingString = [stringURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *URL = [NSURL URLWithString:encodingString];
    NSString *host = [self hostName];
    
    MCLogInfoMessage([NSString stringWithFormat:@"POST: %@%@",host, encodingString]);
    [self POST:URL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MCLogSuccessMessage(encodingString);
        
        IfDictionaryValueNotNull(responseObject) {
            if (completionHandler)
                completionHandler(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MCLogErrorMessage([NSString stringWithFormat:@"POST ERROR: %@",error.localizedDescription]);
        
        if (completionHandler)
            completionHandler(nil, error);
    }];
}

- (void)getAFOperationWithURL:(NSString *)stringURL parameters:(NSDictionary *)parameters
            completionHandler:(void (^)(id responseObject, NSError *error))completionHandler
{
    
    NSString *encodingString = [stringURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *URL = [NSURL URLWithString:encodingString];
    NSString *host = [self hostName];
    
    MCLogInfoMessage([NSString stringWithFormat:@"GET: %@%@",host, encodingString]);
    [self GET:URL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MCLogSuccessMessage(encodingString);
        IfDictionaryValueNotNull(responseObject) {
            if (completionHandler)
                completionHandler(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MCLogErrorMessage([NSString stringWithFormat:@"GET ERROR: %@",error.localizedDescription]);
        if (completionHandler)
            completionHandler(nil, error);
    }];
}

- (void)deleteAFOperationWithURL:(NSString *)stringURL parameters:(NSDictionary *)parameters
            completionHandler:(void (^)(id responseObject, NSError *error))completionHandler
{
    
    NSString *encodingString = [stringURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *URL = [NSURL URLWithString:encodingString];
    NSString *host = [self hostName];
    
    MCLogInfoMessage([NSString stringWithFormat:@"DELETE: %@%@",host, encodingString]);
    [self DELETE:URL.absoluteString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MCLogSuccessMessage(encodingString);
        IfDictionaryValueNotNull(responseObject) {
            if (completionHandler)
                completionHandler(responseObject, nil);
        } else {
            if (completionHandler)
                completionHandler(nil, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MCLogErrorMessage([NSString stringWithFormat:@"DELETE ERROR: %@",error.localizedDescription]);
        if (completionHandler)
            completionHandler(nil, error);
    }];
}

- (void)cancelAllOperations {
    [self.operationQueue cancelAllOperations];
}

@end
