//
//  NSDictionary+Safety.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/10/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "NSDictionary+Safety.h"

@implementation NSDictionary (Safety)

- (id)safeValueForKeyPath:(NSString *)keyPath
{
    if (![self containsValidDataAtKeyPath:keyPath]) {
        return @"";
    }
    else
    {
        return [self valueForKeyPath:keyPath];
    }
    
    //    @try {
    //        if ([self valueForKeyPath:keyPath] == nil || [[self valueForKeyPath:keyPath] isEqual:[NSNull null]])
    //        {
    //            return @"";
    //        }
    //        else
    //        {
    //            return [self valueForKeyPath:keyPath];
    //        }
    //    }
    //    @catch (NSException *exception) {
    //
    //    }
    //    @finally {
    //
    //    }
    
    
}

- (id)safeObjectForKey:(id)key
{
    if ([self objectForKey:key] == nil || [[self objectForKey:key] isEqual:[NSNull null]])
    {
        return @"";
    }
    else
    {
        return [self objectForKey:key];
    }
}

- (NSString *)stringForKey:(NSString *)key
{
    return [NSString stringWithFormat:@"%@", [self safeValueForKeyPath:key]];
}

- (NSArray *)arrayForKey:(NSString *)key
{
    if ([[self safeValueForKeyPath:key] isKindOfClass:[NSArray class]])
    {
        return [self safeValueForKeyPath:key];
    }
    
    return nil;
}

- (BOOL)containsValidDataAtKeyPath:(NSString *)keyPath
{
    
    
    
    if (keyPath)
    {
        NSArray *keyPathComponents = [keyPath componentsSeparatedByString:@"."];
        
        //No key (null/nil key?)
        if ([keyPathComponents count] == 0) {
            return NO;
        }
        
        
        if ([keyPathComponents count] == 1)
        {
            //Only one key, no depth (depth = 1)
            //This is the base case
            if ([self objectForKey:keyPath] &&
                ![[self objectForKey:keyPath] isEqual:[NSNull null]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        //        else if ([keyPathComponents count] == 2)
        //        {
        //            NSString *nextKeyPath = [keyPathComponents objectAtIndex:0];
        //
        //            if ([[self objectForKey:nextKeyPath] isKindOfClass:[NSDictionary class]])
        //            {
        //                //Valid
        //                return [self containsValidDataAtKeyPath:[keyPathComponents objectAtIndex:1]];
        //            }
        //            else
        //            {
        //                //We need to drill another level but the next level is not a dictionary
        //                return NO;
        //            }
        //        }
        else
        {
            NSMutableArray *truncatedKeyPathComponents = [NSMutableArray array];
            
            for (int i = 1; i < [keyPathComponents count]; i++) {
                [truncatedKeyPathComponents addObject:[keyPathComponents objectAtIndex:i]];
            }
            NSString *truncatedKeyPath = [truncatedKeyPathComponents componentsJoinedByString:@"."];
            
            
            if ([[self objectForKey:[keyPathComponents objectAtIndex:0]] isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *nextLevelDictionary = [self objectForKey:[keyPathComponents objectAtIndex:0]];
                return [nextLevelDictionary containsValidDataAtKeyPath:truncatedKeyPath];
            }
            else
            {
                return NO;
            }
            
            //            [keyPathComponents removeObjectAtIndex:0];
            
            
            //            return [self containsValidDataAtKeyPath:truncatedKeyPath];
        }
        
    }
    
    return NO;
}

- (NSInteger)totalRows
{
    if ([self containsValidDataAtKeyPath:@"total_rows"] &&
        [self stringForKey:@"total_rows"].length > 0)
    {
        return [[self stringForKey:@"total_rows"] integerValue];
    }
    
    return 0;
}
@end
