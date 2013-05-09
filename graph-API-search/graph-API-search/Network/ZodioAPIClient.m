//
//  ZodioAPIClient.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/9/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "ZodioAPIClient.h"

__strong static NSMutableDictionary *connectionTable = nil;

@implementation ZodioAPIClient

+ (ZodioAPIClient *)sharedClient {
    
    static ZodioAPIClient *sharedZodioAPIClientInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedZodioAPIClientInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"https://graph.facebook.com/"]];
        connectionTable = [[NSMutableDictionary alloc] initWithCapacity:2048];
        
    });
    return sharedZodioAPIClientInstance;
}

+ (NSMutableDictionary *)connectionTable {
    
    return connectionTable;
}

@end
