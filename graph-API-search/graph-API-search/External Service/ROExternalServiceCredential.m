//
//  ROExternalServiceCredential.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 8/23/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "ROExternalServiceCredential.h"

@implementation ROExternalServiceCredential

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.serviceName forKey:@"serviceName"];
    [aCoder encodeInteger:self.serviceID forKey:@"serviceID"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.accessToken forKey:@"accessToken"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.serviceName = [aDecoder decodeObjectForKey:@"serviceName"];
        self.serviceID = [aDecoder decodeIntegerForKey:@"serviceID"];
        
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.userID = [aDecoder decodeObjectForKey:@"userID"];
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
    }
    
    return self;
}

+ (NSString *)serviceName
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return nil;
}

- (BOOL)isEqual:(id)object
{
    if ([(ROExternalServiceCredential *)object isKindOfClass:[self class]])
    {
        ROExternalServiceCredential *otherObject = (ROExternalServiceCredential *)object;
        
        if ([self.userID isEqualToString:otherObject.userID])
        {
            return YES;
        }
    }
    
    return NO;
}

- (NSDictionary*)jsonData
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    return nil;
}

#pragma mark - Setters (Safety)

- (void)setUserID:(NSString *)userID
{
    if ([userID isKindOfClass:[NSString class]] || !userID)
    {
        _userID = userID;
    }
    else
    {
        _userID = [NSString stringWithFormat:@"%@", userID];
    }
    
}

@end
