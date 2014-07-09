//
//  RKObjectManager+AXKRACExtensions.h
//  AXKRACExtensions
//
//  Created by Alexander Kolov on 04/04/14.
//  Copyright (c) 2014 Alexander Kolov. All rights reserved.
//

#import <RestKit/Network/RKObjectManager.h>

@class RACSignal;

@interface RKObjectManager (AXKRACExtensions)

- (RACSignal *)rac_getObjectsAtPath:(NSString *)path parameters:(NSDictionary *)parameters;
- (RACSignal *)rac_getObject:(id)object path:(NSString *)path parameters:(NSDictionary *)parameters;
- (RACSignal *)rac_postObject:(id)object path:(NSString *)path parameters:(NSDictionary *)parameters;
- (RACSignal *)rac_putObject:(id)object path:(NSString *)path parameters:(NSDictionary *)parameters;
- (RACSignal *)rac_patchObject:(id)object path:(NSString *)path parameters:(NSDictionary *)parameters;
- (RACSignal *)rac_deleteObject:(id)object path:(NSString *)path parameters:(NSDictionary *)parameters;

- (RACSignal *)rac_requestObject:(id)object path:(NSString *)path parameters:(NSDictionary *)parameters
                          method:(RKRequestMethod)method;

- (RACSignal *)rac_getObjectsAtPathForRelationship:(NSString *)relationshipName
                                          ofObject:(id)object
                                        parameters:(NSDictionary *)parameters;

@end
