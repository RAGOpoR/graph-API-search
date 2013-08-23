//
//  ROObjectFactory.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/10/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "ROObjectFactory.h"
#import "ROObject.h"

@implementation ROObjectFactory

+ (ROObject *)ROObjectWithData:(NSDictionary *)data {
    ROObject *objectToReturn;
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        objectToReturn = [self objectWithData:data];
    }
    
    return objectToReturn;
}

+ (ROObject *)objectWithData:(NSDictionary *)data {
    //    NSLog(@"data %@",data);
    ROObject *review = [[ROObject alloc] initWithJsonData:data];
    
//    [review setObjectType:ZodioObjectTypeReview];
//    
//    [self setupStandardUGObject:review withData:data];
//    
//    //    DNSLogWarn(@"Asking to create photo object using: %@", [[self photoArrayFromData:data] objectAtIndex:0]);
//    
//    if ([self checkForPhotoInObjectData:data])
//    {
//        review.photo = [[JGZodioUGObjectFactory photoArrayFromData:data] objectAtIndex:0];
//    }
//    
//    if ([data safeValueForKeyPath:kActivityFeedPhotoArrayName] &&
//        [[data safeValueForKeyPath:kActivityFeedPhotoArrayName] isKindOfClass:[NSArray class]] &&
//        [[data safeValueForKeyPath:kActivityFeedPhotoArrayName] count] > 0)
//    {
//        ////Has photos, process photo by creating photo object
//        NSArray *photoArray = [data safeValueForKeyPath:kActivityFeedPhotoArrayName];
//        NSLog(@"Creating photo with data: %@", [photoArray objectAtIndex:0]);
//        
//    }
//    
//    [self setReviewDataForObject:review withObjectData:data];
    
    return review;
}

@end
