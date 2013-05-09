//
//  ROTableViewDataSource.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/9/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "ROTableViewDataSource.h"

@implementation ROTableViewDataSource

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.objectArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (void)processJSONArray:(NSArray *)jsonArray
{
    if (jsonArray != nil &&
        [jsonArray isKindOfClass:[NSArray class]] &&
        [jsonArray count] > 0)
    {

        self.objectArray = [[NSMutableArray alloc] initWithArray:[self createObjectsFromJsonArray:jsonArray]];
        
    }
    
}

- (NSArray *)createObjectsFromJsonArray:(NSArray *)rawObjectArray
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    return nil;
}

- (ROObject*)processZodioObjectFromJSONData:(NSDictionary *)jsonData
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    return nil;
}

#pragma mark - Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.objectArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
