//
//  MKNetworkOperation+RACSupport.h
//  mgpyh
//
//  Created by x on 14-5-23.
//  Copyright (c) 2014年 x. All rights reserved.
//

#import "MKNetworkOperation.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MKNetworkOperation (RACSupport)
-(RACSignal *)rac_overrideHTTPCompletionHandlerBlock;
@end
