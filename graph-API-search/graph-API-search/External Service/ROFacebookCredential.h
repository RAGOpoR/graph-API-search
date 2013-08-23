//
//  ROFacebookCredential.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 8/23/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "ROExternalServiceCredential.h"

@interface ROFacebookCredential : ROExternalServiceCredential <NSCoding>
{
    NSDate *_expiryDate;
    FBGraphObject *_graphObject;
}

@property (strong, nonatomic) NSDate *expiryDate;
@property (strong, nonatomic) FBGraphObject *graphObject;

+ (ROFacebookCredential *)credentialFromExternalServiceJsonData:(NSDictionary *)jsonData;


@end
