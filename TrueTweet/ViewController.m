//
//  ViewController.m
//  TrueTweet
//
//  Created by Sreekanth on 25/04/15.
//  Copyright (c) 2015 Housing. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"
#import <TwitterKit/TwitterKit.h>

#define TWITTER_BUTTON_HEIGHT   70
#define TWITTER_BUTTON_MARGIN   50

#define LOGIN_TO_HOME_SCREEN_SEGUE  @"LoginToHomeScreenSegue"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TWTRLogInButton *loginButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
        [[Model sharedInstance] fetchTweetsForUser:session.userName onCompletion:^(BOOL success)
        {
            if (success)
            {
                //Success completion
            }
            else
            {
                //Failed
            }
        }];
    }];
    loginButton.frame = CGRectMake(TWITTER_BUTTON_MARGIN, ((self.view.bounds.size.height/2) - (TWITTER_BUTTON_HEIGHT/2)), (self.view.bounds.size.width - (TWITTER_BUTTON_MARGIN * 2)), TWITTER_BUTTON_HEIGHT);
    [self.view addSubview:loginButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
