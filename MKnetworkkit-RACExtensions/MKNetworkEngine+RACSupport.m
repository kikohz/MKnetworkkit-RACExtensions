//
//  MKNetworkEngine+RACSupport.m
//  mgpyh
//
//  Created by x on 14-5-23.
//  Copyright (c) 2014年 x. All rights reserved.
//

#import "MKNetworkEngine+RACSupport.h"
#import "MKNetworkOperation+RACSupport.h"

@implementation MKNetworkEngine (RACSupport)



- (RACSignal *)rac_enqueueHTTPRequestOperation:(MKNetworkOperation *)requestOperation {
	RACSignal* signal = [requestOperation rac_overrideHTTPCompletionHandlerBlock];
	[self enqueueOperation:requestOperation forceReload:YES];
	return signal;
}


- (RACSignal *)rac_GET:(NSString *)path parameters:(NSDictionary *)parameters ssl:(BOOL)useSSL{
    return [[self
			 rac_requestPath:path parameters:parameters method:@"GET" ssl:useSSL]
			setNameWithFormat:@"<%@: %p> -rac_getPath: %@, parameters: %@", self.class, self, path, parameters];
}

- (RACSignal *)rac_POST:(NSString *)path parameters:(NSDictionary *)parameters ssl:(BOOL)useSSL{
	return [[self
			 rac_requestPath:path parameters:parameters method:@"POST" ssl:useSSL]
			setNameWithFormat:@"<%@: %p> -rac_postPath: %@, parameters: %@", self.class, self, path, parameters];
	
}

- (RACSignal *)rac_PUT:(NSString *)path parameters:(NSDictionary *)parameters ssl:(BOOL)useSSL{
	return [[self
			 rac_requestPath:path parameters:parameters method:@"PUT" ssl:useSSL]
			setNameWithFormat:@"<%@: %p> -rac_putPath: %@, parameters: %@", self.class, self, path, parameters];
	
}

- (RACSignal *)rac_DELETE:(NSString *)path parameters:(NSDictionary *)parameters ssl:(BOOL)useSSL{
	return [[self
			 rac_requestPath:path parameters:parameters method:@"DELETE" ssl:useSSL]
			setNameWithFormat:@"<%@: %p> -rac_deletePath: %@, parameters: %@", self.class, self, path, parameters];
}


- (RACSignal *)rac_download:(NSString *)url parameters:(NSDictionary *)parameters filePath:(NSString *)filePath{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        MKNetworkOperation *operation = [self operationWithURLString:url params:parameters];
        RACSignal *signal = [operation rac_downloadProgress];
        [operation addDownloadStream:[NSOutputStream outputStreamToFileAtPath:filePath append:NO]];
        [self enqueueOperation:operation forceReload:YES];   //添加到队列
		[signal subscribe:subscriber];
        
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }];

}


- (RACSignal *)rac_requestPath:(NSString *)path parameters:(NSDictionary *)parameters method:(NSString *)method ssl:(BOOL)useSSL{
	return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        
        MKNetworkOperation *operation = [self operationWithPath:path params:parameters httpMethod:method ssl:useSSL];
        
		RACSignal *signal = [operation rac_overrideHTTPCompletionHandlerBlock];
		[self enqueueOperation:operation forceReload:YES];   //添加到队列
		[signal subscribe:subscriber];
		return [RACDisposable disposableWithBlock:^{
			[operation cancel];
		}];
	}];
}



@end
