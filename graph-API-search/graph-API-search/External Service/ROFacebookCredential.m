//
//  ROFacebookCredential.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 8/23/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "ROFacebookCredential.h"
#import "ISO8601DateFormatter.h"

@implementation ROFacebookCredential

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.expiryDate forKey:@"expiryDate"];
    [aCoder encodeObject:[NSDictionary dictionaryWithDictionary:self.graphObject] forKey:@"graphObject"];
    
    [super encodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.expiryDate = [aDecoder decodeObjectForKey:@"expiryDate"];
        self.graphObject = (FBGraphObject*)[FBGraphObject graphObjectWrappingDictionary:[aDecoder decodeObjectForKey:@"graphObject"]];
    }
    
    return self;
}

+ (NSString*)serviceName
{
    return @"facebook";
}

- (id)init
{
    if (self = [super init])
    {
        self.serviceName = @"facebook";
    }
    
    return self;
}

+ (ROFacebookCredential *)credentialFromExternalServiceJsonData:(NSDictionary *)jsonData
{
    ROFacebookCredential *facebook = [[ROFacebookCredential alloc] init];
    
    if ([jsonData isKindOfClass:[NSDictionary class]])
    {
        facebook.userID = [jsonData stringForKey:kExternalServiceFacebookIDFieldName];
        facebook.accessToken = [jsonData stringForKey:kExternalServiceFacebookTokenFieldName];
        [[NSUserDefaults standardUserDefaults] setObject:facebook.accessToken forKey:kFBAccessTokenKeyFieldName];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        ISO8601DateFormatter *dateFormatter = [[ISO8601DateFormatter alloc] init];
        facebook.expiryDate = [dateFormatter dateFromString:[jsonData stringForKey:kExternalServiceFacebookExpiryDateFieldName]];
        
        if (facebook.userID.length > 0 &&
            facebook.accessToken.length > 10)
        {
            return facebook;
        }
        
    }
    
    return nil;
    
}



@end

