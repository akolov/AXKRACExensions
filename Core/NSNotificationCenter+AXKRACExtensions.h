//
//  NSNotificationCenter+AXKRACExtensions.h
//  AXKRACExtensions
//
//  Created by Alexander Kolov on 04/04/14.
//  Copyright (c) 2014 Alexander Kolov. All rights reserved.
//

#import <ReactiveCocoa/NSNotificationCenter+RACSupport.h>

#define RACObserveNotification(name) \
  [[NSNotificationCenter defaultCenter] rac_addObserverForName:name object:nil]

#define RACObserveNotificationUntilDealloc(name) \
  [[[NSNotificationCenter defaultCenter] rac_addObserverForName:name object:nil] takeUntil:[self rac_willDeallocSignal]]

#define RACObserveTwoNotificationsUntilDealloc(one, two) \
  [[RACSignal merge:@[RACObserveNotification(one), RACObserveNotification(two)]] takeUntil:[self rac_willDeallocSignal]]
