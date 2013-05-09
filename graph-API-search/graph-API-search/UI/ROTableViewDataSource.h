//
//  ROTableViewDataSource.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/9/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ROObject;

@interface ROTableViewDataSource : NSObject <UITableViewDataSource> {
    NSMutableArray *_objectArray;

}

@property (strong, nonatomic) NSMutableArray *objectArray;

@end
