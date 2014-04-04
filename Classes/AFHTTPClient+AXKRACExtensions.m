//
//  AFHTTPClient+AXKRACExtensions.m
//  AXKRACExtensions
//
//  Created by Alexander Kolov on 04/04/14.
//  Copyright (c) 2014 Alexander Kolov. All rights reserved.
//

#import "AFHTTPClient+AXKRACExtensions.h"

#import <AFNetworking/AFHTTPRequestOperation.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation AFHTTPClient (AXKRACExtensions)

- (RACSignal *)rac_getPath:(NSString *)path parameters:(NSDictionary *)parameters {
  return [self rac_requestPath:path parameters:parameters method:@"GET"];
}

- (RACSignal *)rac_postPath:(NSString *)path parameters:(NSDictionary *)parameters {
  return [self rac_requestPath:path parameters:parameters method:@"POST"];
}

- (RACSignal *)rac_putPath:(NSString *)path parameters:(NSDictionary *)parameters {
  return [self rac_requestPath:path parameters:parameters method:@"PUT"];
}

- (RACSignal *)rac_deletePath:(NSString *)path parameters:(NSDictionary *)parameters {
  return [self rac_requestPath:path parameters:parameters method:@"DELETE"];
}

- (RACSignal *)rac_patchPath:(NSString *)path parameters:(NSDictionary *)parameters {
  return [self rac_requestPath:path parameters:parameters method:@"PATCH"];
}

- (RACSignal *)rac_requestPath:(NSString *)path parameters:(NSDictionary *)parameters method:(NSString *)method {
  @weakify(self);
  return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
    @strongify(self);
    NSURLRequest *request = [self requestWithMethod:method path:path parameters:parameters];
    AFHTTPRequestOperation *operation =
      [self HTTPRequestOperationWithRequest:request success:^(id innerOperation, id result) {
        [subscriber sendNext:RACTuplePack(innerOperation, result)];
        [subscriber sendCompleted];
      } failure:^(AFHTTPRequestOperation *innerOperation, NSError *error) {
        [subscriber sendError:error];
      }];

    [self enqueueHTTPRequestOperation:operation];

    return [RACDisposable disposableWithBlock:^{
      [operation cancel];
    }];
  }];
}

#ifdef _SYSTEMCONFIGURATION_H
- (RACSignal *)networkReachabilityStatusSignal {
  return RACObserve(self, networkReachabilityStatus);
}
#endif

@end
