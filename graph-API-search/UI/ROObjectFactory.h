//
//  ROObjectFactory.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/10/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ROObject;

@interface ROObjectFactory : NSObject


+ (ROObject *)ROObjectWithData:(NSDictionary *)data;

@end
