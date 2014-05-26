//
//  MKNetworkOperation+RACSupport.m
//  mgpyh
//
//  Created by x on 14-5-23.
//  Copyright (c) 2014年 x. All rights reserved.
//

#import "MKNetworkOperation+RACSupport.h"

@implementation MKNetworkOperation (RACSupport)


- (RACSignal *)rac_overrideHTTPCompletionHandlerBlock
{
    RACReplaySubject *subject = [RACReplaySubject replaySubjectWithCapacity:1];
	[subject setNameWithFormat:@"-rac_start: %@", self.readonlyRequest.URL];
    
    if([self respondsToSelector:@selector(addCompletionHandler:errorHandler:)]){
    
        [self addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            [subject sendNext:completedOperation];
            [subject sendCompleted];
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            [subject sendError:error];
        }];
    }
    return subject;
}

@end
