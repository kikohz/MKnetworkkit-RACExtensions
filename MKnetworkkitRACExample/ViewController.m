//
//  ViewController.m
//  MKnetworkkitRACExample
//
//  Created by x on 14-5-26.
//  Copyright (c) 2014年 x. All rights reserved.
//

#import "ViewController.h"
#import "MKNetworkEngine+RACSupport.h"
#import <MKNetworkKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    @weakify(self);
    self.getButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        NSString *tempPath = NSTemporaryDirectory();
        NSString *tempFilePath = [NSString stringWithFormat:@"%@1.temp",
                                  tempPath];
        
        MKNetworkEngine *mkengine = [MKNetworkEngine new];
        
        [[mkengine rac_download:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V3.1.1.dmg" parameters:nil filePath:tempFilePath] subscribeNext:^(NSNumber *x) {
    
            NSString *temp =[NSString stringWithFormat:@"%f",[x doubleValue]*100];
            NSLog(@"%@",temp);
        }];
        
        
//        MKNetworkEngine *mkengine = [[MKNetworkEngine alloc] initWithHostName:@"i2.apiary.io"];
//        
//        [[mkengine rac_GET:@"notes" parameters:nil ssl:NO] subscribeNext:^(MKNetworkOperation *op) {
//            
//            self_weak_.responseText.text = [op responseString];
//            
//        } error:^(NSError *error) {
//            self_weak_.responseText.text = [NSString stringWithFormat:@"%@",error];
//        }];
        
        return [RACSignal empty];
    }];
    
    

    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
