//
//  MockingURLSessionConfiguration.swift
//  MarketPlaceTests
//
//  Created by Vinsi on 25/07/2020.
//  Copyright © 2020 Majid Al Futtaim. All rights reserved.
//
// Purpose :- This class is used to call the swizzling only @ once

#import <Foundation/Foundation.h>
#import <MusicSearchTests-Swift.h>
@interface MockingURLSessionConfiguration : NSObject

@end

@implementation MockingURLSessionConfiguration

+ (void)load {
    [NSURLSessionConfiguration swizzleDefaultSessionConfiguration];
}

@end
