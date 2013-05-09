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

static NSString *facebookCellIdentifier = @"fbsearchcell";

@implementation FBGraphSearchDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [self.objectArray count];
    
    return rows;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
//    JGBusiness *business = self.business;
    
    facebookCellToReturn = [FacebookResultCellFactory createfacebookCellWithCell:facebookCellToReturn feedItem:nil];
    facebookCellToReturn.tag = indexPath.section;
    
    return facebookCellToReturn;
}

@end
