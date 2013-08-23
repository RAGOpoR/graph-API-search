//
//  ROPerson.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 8/23/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ROFacebookCredential;
@class ROTwitterCredential;

@interface ROPerson : NSObject <NSCoding> {
    NSString *_name;
    NSURL *_thumbnailURL;
    NSString *_email;
    NSString *_mobile;
    
    //Used for list displays, selection, etc
    BOOL _selected;
    BOOL _invited;
    
    ROFacebookCredential *_facebook;
    ROTwitterCredential *_twitter;
    
    //    NSString *_facebookID;
    //    NSString *_twitterID;
    BOOL _isZodioUser;
    NSString *_zodioUserID;
}


@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSURL *thumbnailURL;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *mobile;
@property (nonatomic) BOOL selected;
@property (nonatomic) BOOL invited;

//@property (strong, nonatomic) NSString *facebookID;
//@property (strong, nonatomic) NSString *twitterID;

@property (strong, nonatomic) ROFacebookCredential *facebook;
@property (strong, nonatomic) ROTwitterCredential *twitter;
@property (nonatomic) BOOL isZodioUser;
@property (strong, nonatomic) NSString *zodioUserID;

+ (ROPerson *)personFromFacebookFriendJsonData:(NSDictionary *)facebookJson;
+ (ROPerson *)personWithTwitterID:(NSString*)twitterID;

- (void)clearUserData;

@end
