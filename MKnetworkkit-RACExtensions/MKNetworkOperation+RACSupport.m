//
//  MKNetworkOperation+RACSupport.m
//  mgpyh
//
//  Created by x on 14-5-23.
//  Copyright (c) 2014年 x. All rights reserved.
//

#import "MKNetworkOperation+RACSupport.h"
#import <objc/message.h>

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
            [subject sendCompleted];
        }];
    }
    return subject;
}


- (RACSignal *)rac_progressSignalWithSelector:(SEL)original
{
    RACReplaySubject *subject = [RACReplaySubject subject];
    
    void(^ProgressBlock)(double) = ^(double progress){
        [subject sendNext:@(progress)];
    };
    
    objc_msgSend(self, original, ProgressBlock);
    
    return [subject deliverOn:[RACScheduler scheduler]];
}

- (RACSignal *)rac_downloadProgress
{
    return [self rac_progressSignalWithSelector:@selector(onDownloadProgressChanged:)];
}

- (RACSignal *)rac_uploadProgress
{
    return [self rac_progressSignalWithSelector:@selector(onUploadProgressChanged:)];
}


@end
