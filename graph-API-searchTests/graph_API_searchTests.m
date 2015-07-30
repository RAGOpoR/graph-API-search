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

- (void)testROObject {
    
    ROObject *roObject = [ROObject new];
    XCTAssertNotNil(roObject ,@"roObject should not be nil");
}

- (void)testSetROObjectID {
    
    ROObject *roObject = [ROObject new];
    roObject.objectID = @"1";
    XCTAssertEqual(roObject.objectID, @"1", @"Object ID should equal 1");
}

- (void)testSetROObjectMessage {
    
    ROObject *roObject = [ROObject new];
    roObject.message = @"message";
    XCTAssertEqual(roObject.message, @"message", @"message should equal");
}

- (void)testSetROObjectStory {
    
    ROObject *roObject = [ROObject new];
    roObject.story = @"story";
    XCTAssertEqual(roObject.story, @"story", @"story should equal");
}

- (void)testSetROObjectIconURL {
    
    ROObject *roObject = [ROObject new];
    roObject.iconURL = [NSURL URLWithString:@"http://message"];
    XCTAssertEqual(roObject.iconURL.absoluteString, @"http://message", @"iconURL should equal");
}

@end
