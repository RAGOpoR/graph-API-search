//
//  ROExternalServiceCredential.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 8/23/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ROExternalServiceCredential : NSObject <NSCoding> {
    
    NSString *_serviceName;
    NSInteger _serviceID;
    
    NSString *_userName;
    NSString *_userID;
    NSString *_accessToken;
}

@property (strong, nonatomic) NSString *serviceName;
@property (nonatomic) NSInteger serviceID;

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *accessToken;

+ (NSString *)serviceName;
- (NSDictionary*)jsonData;

@end
