//
//  BaseHTTPClient.h

#import <AFNetworking/AFNetworking.h>

@interface BaseHTTPClient : AFHTTPSessionManager

@property (assign, nonatomic) NSInteger alertCount;

- (NSString *)hostName;
///AFNetwork
- (void)getAFOperationWithURL:(NSString *)stringURL parameters:(NSDictionary *)parameters
            completionHandler:(void (^)(id responseObject, NSError *error))completionHandler;

- (void)postAFOperationWithURL:(NSString *)stringURL parameters:(NSDictionary *)parameters
             completionHandler:(void (^)(id responseObject, NSError *error))completionHandler;

- (void)deleteAFOperationWithURL:(NSString *)stringURL parameters:(NSDictionary *)parameters
               completionHandler:(void (^)(id responseObject, NSError *error))completionHandler;

- (void)cancelAllOperations;

@end
