//
//  ROPerson.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 8/23/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "ROPerson.h"
#import "ROFacebookCredential.h"

@implementation ROPerson

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.thumbnailURL forKey:@"thumbnailURL"];
    [aCoder encodeObject:self.email forKey:@"email"];
    
    [aCoder encodeBool:self.selected forKey:@"selected"];
    [aCoder encodeBool:self.invited forKey:@"invited"];
    [aCoder encodeObject:self.facebook forKey:@"facebook"];
    [aCoder encodeObject:self.twitter forKey:@"twitter"];
    [aCoder encodeBool:self.isZodioUser forKey:@"isZodioUser"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        
        self.thumbnailURL = [aDecoder decodeObjectForKey:@"thumbnailURL"];
        self.selected = [aDecoder decodeBoolForKey:@"selected"];
        self.invited = [aDecoder decodeBoolForKey:@"invited"];
        self.facebook = [aDecoder decodeObjectForKey:@"facebook"];
        self.twitter = [aDecoder decodeObjectForKey:@"twitter"];
        self.isZodioUser = [aDecoder decodeBoolForKey:@"isZodioUser"];
    }
    
    return self;
}

+ (ROPerson *)personFromFacebookFriendJsonData:(NSDictionary *)facebookJson
{
    ROPerson *person = [[ROPerson alloc] init];
    
    person.facebook = [[ROFacebookCredential alloc] init];
    person.facebook.userID = [facebookJson stringForKey:kFacebookUserIDFieldName];
    person.name = [facebookJson stringForKey:kFacebookFullNameFieldName];
    person.thumbnailURL = [NSURL URLWithString:[facebookJson stringForKey:kFacebookUserThumbnailURLFieldName]];
    
    @try
    {
        if ([[facebookJson stringForKey:kFacebookAppUserStatusFieldName] integerValue] == true)
        {
            person.isZodioUser = YES;
        }
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
        
    }
    
    return person;
    
}

+ (ROPerson*)personWithTwitterID:(NSString*)twitterID
{
    ROPerson *person = [[ROPerson alloc] init];
//    person.twitter = [[JGTwitterCredential alloc] init];
//    person.twitter.userID = twitterID;
    
    return person;
}

- (BOOL)isEqual:(id)object
{
    
    ROPerson *otherPerson = (ROPerson*)object;
    
    if ([otherPerson isKindOfClass:[self class]])
    {
        if (self.email && otherPerson.email)
        {
            if ([self.email isEqualToString:otherPerson.email])
            {
                return YES;
            }
        }
        else if (self.mobile && otherPerson.mobile)
        {
            if ([self.mobile isEqualToString:otherPerson.mobile])
            {
                return YES;
            }
        }
        else if (self.facebook && otherPerson.facebook)
        {
            if ([self.facebook isEqual:otherPerson.facebook])
            {
                return YES;
            }
        }
//        else if (self.twitter && otherPerson.twitter)
//        {
//            if ([self.twitter isEqual:otherPerson.twitter])
//            {
//                return YES;
//            }
//        }
    }
    
    
    
    return NO;
}

- (void)clearUserData
{
    self.name = nil;
    self.thumbnailURL = nil;
    self.email = nil;
    self.mobile = nil;
    
    self.selected = NO;
    self.invited = NO;
    
    self.facebook = nil;
    self.twitter = nil;
    
    self.isZodioUser = NO;
}


@end
