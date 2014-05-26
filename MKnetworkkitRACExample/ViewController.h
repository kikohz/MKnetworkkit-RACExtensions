//
//  ViewController.h
//  MKnetworkkitRACExample
//
//  Created by x on 14-5-26.
//  Copyright (c) 2014年 x. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *responseText;
@property (weak, nonatomic) IBOutlet UITextField *requestUrl;

@property (weak, nonatomic) IBOutlet UIButton *getButton;
@end
