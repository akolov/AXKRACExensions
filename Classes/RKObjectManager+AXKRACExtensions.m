//
//  RKObjectManager+AXKRACExtensions.m
//  AXKRACExtensions
//
//  Created by Alexander Kolov on 04/04/14.
//  Copyright (c) 2014 Alexander Kolov. All rights reserved.
//

#import "RKObjectManager+AXKRACExtensions.h"

#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RKObjectManager (AXKRACExtensionsInternalMethods)

- (NSURL *)URLWithRoute:(RKRoute *)route object:(id)object interpolatedParameters:(NSDictionary **)interpolatedParameters;

@end

@implementation RKObjectManager (AXKRACExtensions)



- (RACSignal *)rac_getObjectsAtPath:(NSString *)path parameters:(NSDictionary *)parameters {
  return [self rac_requestObject:nil path:path parameters:parameters method:RKRequestMethodGET];
}

- (RACSignal *)rac_getObject:(id)object path:(NSString *)path parameters:(NSDictionary *)parameters {
  return [self rac_requestObject:object path:path parameters:parameters method:RKRequestMethodGET];
}

- (RACSignal *)rac_postObject:(id)object path:(NSString *)path parameters:(NSDictionary *)parameters {
  return [self rac_requestObject:object path:path parameters:parameters method:RKRequestMethodPOST];
}

- (RACSignal *)rac_putObject:(id)object path:(NSString *)path parameters:(NSDictionary *)parameters {
  return [self rac_requestObject:object path:path parameters:parameters method:RKRequestMethodPUT];
}

- (RACSignal *)rac_patchObject:(id)object path:(NSString *)path parameters:(NSDictionary *)parameters {
  return [self rac_requestObject:object path:path parameters:parameters method:RKRequestMethodPATCH];
}

- (RACSignal *)rac_deleteObject:(id)object path:(NSString *)path parameters:(NSDictionary *)parameters {
  return [self rac_requestObject:object path:path parameters:parameters method:RKRequestMethodDELETE];
}



- (RACSignal *)rac_requestObject:(id)object path:(NSString *)path parameters:(NSDictionary *)parameters
                          method:(RKRequestMethod)method {
  NSAssert(object || path, @"Cannot make a request without an object or a path.");

  @weakify(self);
  return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
    @strongify(self);

    RKObjectRequestOperation *operation =
      [self appropriateObjectRequestOperationWithObject:object method:method path:path parameters:parameters];

    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
      [subscriber sendNext:RACTuplePack(operation, mappingResult)];
      [subscriber sendCompleted];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
      [subscriber sendError:error];
    }];

    [self enqueueObjectRequestOperation:operation];

    return [RACDisposable disposableWithBlock:^{
      [operation cancel];
    }];
  }];
}


- (RACSignal *)rac_getObjectsAtPathForRelationship:(NSString *)relationshipName
                                          ofObject:(id)object
                                        parameters:(NSDictionary *)parameters{
  
  NSAssert(object || relationshipName, @"Cannot make a request without an object or a relationshipName.");

  @weakify(self);
  return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
    @strongify(self);
    
    RKRoute *route = [self.router.routeSet routeForRelationship:relationshipName ofClass:[object class] method:RKRequestMethodGET];
    NSDictionary *interpolatedParameters = nil;
    NSURL *URL = [self URLWithRoute:route object:object interpolatedParameters:&interpolatedParameters];
    NSAssert(URL, @"Failed to generate URL for relationship named '%@' for object: %@", relationshipName, object);
    
    RKObjectRequestOperation *operation = [self appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodGET path:[URL relativeString] parameters:parameters];
    operation.mappingMetadata = @{ @"routing": @{ @"parameters": interpolatedParameters, @"route": route } };
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
      [subscriber sendNext:RACTuplePack(operation, mappingResult)];
      [subscriber sendCompleted];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
      [subscriber sendError:error];
    }];
    
    [self enqueueObjectRequestOperation:operation];
    
    return [RACDisposable disposableWithBlock:^{
      [operation cancel];
    }];
  }];
}

@end
