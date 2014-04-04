//
//  AFHTTPClient+AXKRACExtensions.h
//  AXKRACExtensions
//
//  Created by Alexander Kolov on 04/04/14.
//  Copyright (c) 2014 Alexander Kolov. All rights reserved.
//

#import <AFNetworking/AFHTTPClient.h>

@class RACSignal;

@interface AFHTTPClient (AXKRACExtensions)

- (RACSignal *)rac_getPath:(NSString *)path parameters:(NSDictionary *)parameters;
- (RACSignal *)rac_postPath:(NSString *)path parameters:(NSDictionary *)parameters;
- (RACSignal *)rac_putPath:(NSString *)path parameters:(NSDictionary *)parameters;
- (RACSignal *)rac_deletePath:(NSString *)path parameters:(NSDictionary *)parameters;
- (RACSignal *)rac_patchPath:(NSString *)path parameters:(NSDictionary *)parameters;

#ifdef _SYSTEMCONFIGURATION_H
- (RACSignal *)networkReachabilityStatusSignal;
#endif

@end
