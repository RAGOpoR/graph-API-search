//
//  FBGraphSearchDataSource.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/10/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "FBGraphSearchDataSource.h"
#import "FacebookResultCell.h"
#import "FacebookResultCellFactory.h"
#import "ROObject.h"
#import "ROObjectFactory.h"

static NSString *facebookCellIdentifier = @"fbsearchcell";

@implementation FBGraphSearchDataSource

- (void)processJSONArray:(NSArray *)jsonArray {    
    [super processJSONArray:jsonArray];
    
}

- (NSArray*)createObjectsFromJsonArray:(NSArray *)rawObjectArray {
    NSMutableArray *arrayToReturn = [NSMutableArray array];
    
    for (id currentObject in rawObjectArray) {
        
        ROObject *currentROObject = [ROObjectFactory ROObjectWithData:(NSDictionary *)currentObject];
        
        if (currentROObject) {
            [arrayToReturn addObject:currentROObject];
        }
    }
    
    return arrayToReturn;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = [self.objectArray count];
    
    return rows;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cellToReturn;
    

    
    cellToReturn = [self drawCellWith:tableView cellForRowAtIndexPath:indexPath];
    
    return cellToReturn;
    
}

- (FacebookResultCell *)drawCellWith:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FacebookResultCell *facebookCellToReturn = (FacebookResultCell*)[tableView dequeueReusableCellWithIdentifier:facebookCellIdentifier];
    if (facebookCellToReturn == nil) {
        facebookCellToReturn = [[FacebookResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:facebookCellIdentifier];
        [facebookCellToReturn setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    ROObject *currentObject = [self.objectArray objectAtIndex:indexPath.row];
    
    facebookCellToReturn = [FacebookResultCellFactory createfacebookCellWithCell:facebookCellToReturn feedItem:currentObject];
    facebookCellToReturn.tag = indexPath.section;
    
    return facebookCellToReturn;
}

@end
