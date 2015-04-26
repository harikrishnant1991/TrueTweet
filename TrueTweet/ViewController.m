//
//  ViewController.m
//  TrueTweet
//
//  Created by Sreekanth on 25/04/15.
//  Copyright (c) 2015 Housing. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"
#import "HomeViewController.h"
#import "MBProgressHUD.h"
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
    if ([TwitterKit session])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HomeViewController *viewController = (HomeViewController *)[storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [self.navigationController pushViewController:viewController animated:NO];
    }
    TWTRLogInButton *loginButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        [[Model sharedInstance] fetchTweetsForUser:@"housing" onCompletion:^(BOOL success)
        {
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            if (success)
            {
                //Success completion
                [self performSegueWithIdentifier:LOGIN_TO_HOME_SCREEN_SEGUE sender:self];
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
