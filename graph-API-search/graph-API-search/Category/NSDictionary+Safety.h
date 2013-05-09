//
//  NSDictionary+Safety.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/10/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Safety)

- (id)safeValueForKeyPath:(NSString *)keyPath;
- (id)safeObjectForKey:(id)key;

- (NSString *)stringForKey:(NSString *)key;
- (NSArray *)arrayForKey:(NSString *)key;
- (BOOL)containsValidDataAtKeyPath:(NSString *)keyPath;


/*!
 @abstract Checks the current dictionary for a 'total_rows' key and returns the int value of that if it exists. If they key doesn't exist, method returns -1.
 */
- (NSInteger)totalRows;

@end
