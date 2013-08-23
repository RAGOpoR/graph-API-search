//
//  ZodioAPIClient.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/9/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "ZodioAPIClient.h"
#import "AFJSONRequestOperation.h"

__strong static NSMutableDictionary *connectionTable = nil;

@implementation ZodioAPIClient

+ (ZodioAPIClient *)sharedClient {
    
    static ZodioAPIClient *sharedZodioAPIClientInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedZodioAPIClientInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseURLString]];
        connectionTable = [[NSMutableDictionary alloc] initWithCapacity:2048];
        
    });
    return sharedZodioAPIClientInstance;
}

+ (NSMutableDictionary *)connectionTable {
    
    return connectionTable;
}

#pragma mark - HTTP Operation Management

- (void)enqueueHTTPRequestOperation:(AFHTTPRequestOperation *)operation forOwner:(id)owner {
    
    [super enqueueHTTPRequestOperation:operation];
    
    _currentRequestMethod = [[operation request] HTTPMethod];
    _currentRequestPath = [NSString stringWithFormat:@"%@",[[[operation request] URL] relativePath]];
    _currentRequest = [NSDictionary dictionaryWithObjectsAndKeys: _currentRequestMethod, @"method", _currentRequestPath, @"path", nil];
    
    _currentOwner = [NSString stringWithFormat:@"%@",owner];
    [connectionTable setObject:_currentRequest forKey:_currentOwner];
    
}

//- (void)enqueueHTTPRequestOperation:(AFHTTPRequestOperation *)operation type:(NSString *)requestType forOwner:(id)owner


- (void)cancelHTTPRequestOperationsWithOwner:(id)owner {
    
    NSMutableArray *connectionsToRemove = [[NSMutableArray alloc] initWithCapacity:[connectionTable count]];
    NSString *ownerAsString = [NSString stringWithFormat:@"%@",owner];
    for (NSString *key in connectionTable) {
        if ([key isEqualToString:ownerAsString])
        {
            NSString *currentMethod = [[NSString alloc] initWithFormat:@"%@",[[connectionTable objectForKey:key] objectForKey:@"method"]];
            NSString *currentPath = [[NSString alloc] initWithFormat:@"%@",[[connectionTable objectForKey:key] objectForKey:@"path"]];
            
            [[ZodioAPIClient sharedClient] cancelAllHTTPOperationsWithMethod:currentMethod path:currentPath];
            
            [connectionsToRemove addObject:key];
        }
    }
    
    [connectionTable removeObjectsForKeys:connectionsToRemove];
}

- (void)facebookGraphSearchForKeyword:(NSString *)keyword withPage:(NSInteger)page andLimit:(NSInteger)limit forOwner:(id<ZodioAPIClientDelegate>)owner {
    
    NSString *requestPath = kAPIBasePath;
    requestPath = [requestPath stringByAppendingString:[NSString stringWithFormat:@"search?type=post&q=%@",keyword]];
    
//    NSMutableDictionary *getUserRecommendedParameters = [[NSMutableDictionary alloc] init];
//    
//    getUserRecommendedParameters = [[ZSearchManager sharedSearchManager] appendLoginDataToDictionary:getUserRecommendedParameters];
    
    NSMutableURLRequest *photosRequest = [[ZodioAPIClient sharedClient] requestWithMethod:@"GET" path:requestPath parameters:nil];

    AFJSONRequestOperation *photosRequestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:photosRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                                      {
                                                          [self processListData:JSON withFields:nil forOwner:owner requestType:kZodioAPIClientRequestTypeGetFacebookGraphSearch];
                                                      }
                                                                                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                                                      {
                                                          
                                                          [self processError:error andResponse:JSON forOwner:owner requestType:kZodioAPIClientRequestTypeGetFacebookGraphSearch];
                                                          
                                                      }];
    
    
    [[ZodioAPIClient sharedClient] enqueueHTTPRequestOperation:photosRequestOperation forOwner:owner];
    
}

-(void)processListData:(id)JSON withFields:(NSArray *)fields forOwner:(id)owner requestType:(NSString *)requestType {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableDictionary *resultsToReturn;
        resultsToReturn = [[NSMutableDictionary alloc] initWithDictionary:JSON];
        
            if ([owner respondsToSelector:@selector(requestCompletedWithStatus:andResults:requestType:)]) {
                resultsToReturn = [[NSMutableDictionary alloc] initWithDictionary:JSON];
                
                if (![resultsToReturn isEqual:[NSNull null]]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [owner requestCompletedWithStatus:StatusOK andResults:resultsToReturn requestType:requestType];
                    });
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [owner requestCompletedWithStatus:StatusUnknownError andResults:nil requestType:requestType];
                    });
                }
            }
        
    });
    
    
}

-(void)processError:(NSError *)error andResponse:(id)JSON forOwner:(id)owner requestType:(NSString *)requestType {
    
    NSMutableDictionary *resultsToReturn;
    
    resultsToReturn = [[NSMutableDictionary alloc] initWithDictionary:JSON];
    
    if ([owner respondsToSelector:@selector(requestCompletedWithStatus:andResults:requestType:)]) {
        [owner requestCompletedWithStatus:StatusUnknownError andResults:resultsToReturn requestType:requestType];
    }
}

#pragma mark Login

- (void)doLoginWithToken:(NSString *)token forOwner:(id<ZodioAPIClientDelegate>)owner {
    
    NSString *requestPath = kAPIBasePath;
    requestPath = [requestPath stringByAppendingString:[NSString stringWithFormat:@"%@",kLoginPath]];
    
    NSMutableDictionary *loginParameter = [[NSMutableDictionary alloc] init];
    [loginParameter setObject:@"saakyz@gmail.com" forKey:@"email"];
    [loginParameter setObject:@"n3tr" forKey:@"username"];
    [loginParameter setObject:@"21345o34567899765thsdfgdsasrgfdcvtfbcv4" forKey:@"device_token"];

    
    NSMutableURLRequest *photosRequest = [[ZodioAPIClient sharedClient] requestWithMethod:@"GET" path:requestPath parameters:loginParameter];
    
    AFJSONRequestOperation *loginRequestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:photosRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                                      {
                                                          [self processListData:JSON withFields:nil forOwner:owner requestType:kAPIClientRequestTypeFacebook];
                                                      }
                                                                                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                                                      {
                                                          
                                                          [self processError:error andResponse:JSON forOwner:owner requestType:kAPIClientRequestTypeFacebook];
                                                          
                                                      }];
    
    
    [[ZodioAPIClient sharedClient] enqueueHTTPRequestOperation:loginRequestOperation forOwner:owner];
    
}

@end
