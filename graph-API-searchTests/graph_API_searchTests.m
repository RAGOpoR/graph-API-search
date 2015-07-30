//
//  graph_API_searchTests.m
//  graph-API-searchTests
//
//  Created by Siam Wannakosit on 5/9/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "graph_API_searchTests.h"
#import "ROObject.h"

@implementation graph_API_searchTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testROObject
{
    ROObject *roObject = [ROObject new];
    XCTAssertNotNil(roObject ,@"roObject should not be nil");
}

@end
