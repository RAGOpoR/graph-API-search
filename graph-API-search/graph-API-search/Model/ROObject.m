//
//  ROObject.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/9/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "ROObject.h"

@implementation ROObject

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.objectID forKey:@"objectID"];
    [aCoder encodeObject:self.iconURL forKey:@"iconURL"];
    [aCoder encodeObject:self.message forKey:@"message"];
    [aCoder encodeObject:self.story forKey:@"story"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init])
    {
        self.objectID = [aDecoder decodeObjectForKey:@"objectID"];
        self.iconURL = [aDecoder decodeObjectForKey:@"iconURL"];
        self.message = [aDecoder decodeObjectForKey:@"message"];
        self.story = [aDecoder decodeObjectForKey:@"story"];
    }
    
    return self;
}

- (id)initWithJsonData:(NSDictionary *)jsonData {
    if (self = [super init]) {
        if ([[jsonData stringForKey:@"id"] length] > 0)
        {
            self.objectID = [jsonData stringForKey:@"id"];
        }
        if ([[jsonData stringForKey:@"icon"] length] > 0)
        {
            self.iconURL = [NSURL URLWithString:[jsonData stringForKey:@"icon"]];
        }
        if ([[jsonData stringForKey:@"message"] length] > 0)
        {
            self.message = [jsonData stringForKey:@"message"];
        }
        if ([[jsonData stringForKey:@"story"] length] > 0)
        {
            self.story = [jsonData stringForKey:@"story"];
        }
    }
    
    return self;
}

@end
