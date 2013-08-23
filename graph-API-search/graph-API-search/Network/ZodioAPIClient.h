//
//  ZodioAPIClient.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/9/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "AFHTTPClient.h"

typedef enum {
    StatusOK                               =   0,
    StatusLocationServicesError            =   1,
    StatusReachabilityError                =   2,
    StatusNoResultsError                   =   3,
    StatusUnknownError                     =   4,
    StatusUnknownUser                      =   5,
    
} ConnectionStatus;


@protocol ZodioAPIClientDelegate <NSObject>

@required
- (void)requestType:(NSString *)request failedWithError:(NSError *)error andData:(id)JSON;
-(void) requestCompletedWithStatus:(NSInteger)status andResults:(NSMutableDictionary *)results requestType:(NSString *)requestType;

@optional

@end

@interface ZodioAPIClient : AFHTTPClient {
    
    id _delegate;
}

@property (strong, nonatomic) id delegate;
@property (strong, nonatomic) NSString *currentRequestPath;
@property (strong, nonatomic) NSString *currentRequestMethod;
@property (strong, nonatomic) NSDictionary *currentRequest;
@property (strong, nonatomic) NSString *currentOwner;

+ (ZodioAPIClient *)sharedClient;
+ (NSMutableDictionary *)connectionTable;
- (void)facebookGraphSearchForKeyword:(NSString *)keyword withPage:(NSInteger)page andLimit:(NSInteger)limit forOwner:(id<ZodioAPIClientDelegate>)owner;
- (void)doLoginWithToken:(NSString *)token forOwner:(id<ZodioAPIClientDelegate>)owner;
@end
