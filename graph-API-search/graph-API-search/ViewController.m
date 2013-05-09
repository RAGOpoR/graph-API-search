//
//  ViewController.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/9/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[ZodioAPIClient sharedClient] facebookGraphSearchForKeyword:@"Apple"
                                                        withPage:0
                                                        andLimit:0
                                                        forOwner:(id<ZodioAPIClientDelegate>)self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestCompletedWithStatus:(NSInteger)status andResults:(NSMutableDictionary *)results requestType:(NSString *)requestType {
    NSLog(@"%@",results);
}

- (void)requestType:(NSString *)request failedWithError:(NSError *)error andData:(id)JSON {
    NSLog(@"%@",JSON);
}
@end
