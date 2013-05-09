//
//  ROObject.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/9/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ROObject : NSObject <NSCoding> {
    NSString *_objectID;
    NSURL *_iconURL;
    NSString *_message;
    NSString *_story;
}

@property (nonatomic, copy) NSString *objectID;
@property (nonatomic, strong) NSURL *iconURL;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *story;

@end
