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
    [aCoder encodeObject:self.objectName forKey:@"objectName"];
    [aCoder encodeObject:self.createDate forKey:@"createDate"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init])
    {
        self.objectID = [aDecoder decodeObjectForKey:@"objectID"];
        self.iconURL = [aDecoder decodeObjectForKey:@"iconURL"];
        self.message = [aDecoder decodeObjectForKey:@"message"];
        self.story = [aDecoder decodeObjectForKey:@"story"];
        self.objectName = [aDecoder decodeObjectForKey:@"objectName"];
        self.createDate = [aDecoder decodeObjectForKey:@"createDate"];
    }
    
    return self;
}

- (id)initWithJsonData:(NSDictionary *)jsonData {
    if (self = [super init]) {
        if ([[jsonData stringForKey:@"id"] length] > 0)
        {
            self.objectID = [jsonData valueForKey:@"id"];
        }
        if ([[NSString stringWithFormat:@"%@",[jsonData valueForKeyPath:@"user.avatar_url"]] length] > 1)
        {
            self.iconURL = [NSURL URLWithString:[jsonData valueForKeyPath:@"user.avatar_url"]];
        }
        if ([[jsonData stringForKey:@"where_text"] length] > 0)
        {
            self.message = [jsonData valueForKey:@"where_text"];
        }
        if ([[jsonData stringForKey:@"status"] length] > 0)
        {
            self.story = [jsonData valueForKey:@"status"];
        }
        if ([[jsonData valueForKeyPath:@"user.username"] length] > 0)
        {
            self.objectName = [jsonData valueForKeyPath:@"user.username"];
        }
        if ([[jsonData valueForKey:@"created_at"] length] > 0)
        {
            self.createDate = [jsonData valueForKey:@"created_at"];
        }
    }
    
    return self;
}

@end
