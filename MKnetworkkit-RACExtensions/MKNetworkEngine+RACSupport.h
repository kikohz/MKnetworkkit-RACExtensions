//
//  MKNetworkEngine+RACSupport.h
//  mgpyh
//
//  Created by x on 14-5-23.
//  Copyright (c) 2014年 x. All rights reserved.
//

#import "MKNetworkEngine.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MKNetworkEngine (RACSupport)




- (RACSignal *)rac_enqueueHTTPRequestOperation:(MKNetworkOperation *)requestOperation;

/*!
 * A convenience around -getPath:parameters:success:failure: that returns a cold signal of the
 * result.
 */
- (RACSignal *)rac_GET:(NSString *)path parameters:(NSDictionary *)parameters ssl:(BOOL)useSSL;

/*!
 * A convenience around -postPath:parameters:success:failure: that returns a cold signal of the
 * result.
 */
- (RACSignal *)rac_POST:(NSString *)path parameters:(NSDictionary *)parameters ssl:(BOOL)useSSL;

/*!
 * A convenience around -putPath:parameters:success:failure: that returns a cold signal of the
 * result.
 */
- (RACSignal *)rac_PUT:(NSString *)path parameters:(NSDictionary *)parameters ssl:(BOOL)useSSL;

/*!
 * A convenience around -deletePath:parameters:success:failure: that returns a cold signal of the
 * result.
 */
- (RACSignal *)rac_DELETE:(NSString *)path parameters:(NSDictionary *)parameters ssl:(BOOL)useSSL;

@end
