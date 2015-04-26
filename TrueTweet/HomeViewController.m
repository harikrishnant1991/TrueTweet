//
//  HomeViewController.m
//  TrueTweet
//
//  Created by Sreekanth on 25/04/15.
//  Copyright (c) 2015 Housing. All rights reserved.
//

#import "HomeViewController.h"
#import "Model.h"
#import "FilterAlertView.h"
#import "MBProgressHUD.h"
#import <TwitterKit/TwitterKit.h>

static NSString * const TweetTableReuseIdentifier = @"TweetCell";

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, TWTRTweetViewDelegate>
{
    __weak IBOutlet UITableView *tweetTableView;
    __weak IBOutlet UIButton *filterButton;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tweetTableView.estimatedRowHeight = 150.0;
    tweetTableView.rowHeight = UITableViewAutomaticDimension;
    [tweetTableView registerClass:[TWTRTweetTableViewCell class] forCellReuseIdentifier:TweetTableReuseIdentifier];
    filterButton.layer.cornerRadius = 22.0;
    filterButton.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)filterButtonClicked:(id)sender
{
    FilterAlertView *alert = [[[NSBundle mainBundle] loadNibNamed:@"FilterAlertView" owner:self options:nil] objectAtIndex:0];
    [alert setButtonClickHandler:^(NSInteger buttonIndex, NSString *query)
     {
         switch (buttonIndex)
         {
             case 1:
             {
                 [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                 [[Model sharedInstance] fetchTweetsForUser:query onCompletion:^(BOOL success)
                  {
                      [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
                      if (success)
                      {
                          //Success completion
                          [tweetTableView reloadData];
                      }
                  }];
             }
                 break;
             case 2:
             {
                 [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                 [[Model sharedInstance] fetchTweetsWithQuery:query onCompletion:^(BOOL success)
                  {
                      [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
                      if (success)
                      {
                          //Success completion
                          [tweetTableView reloadData];
                      }
                  }];
             }
                 break;
             default:
                 break;
         }
     }];
    [alert show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[Model sharedInstance] tweets].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWTRTweet *tweet = [Model sharedInstance].tweets[indexPath.row];
    TWTRTweetTableViewCell *cell = (TWTRTweetTableViewCell *)[tableView dequeueReusableCellWithIdentifier:TweetTableReuseIdentifier forIndexPath:indexPath];
    [cell configureWithTweet:tweet];
    cell.tweetView.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWTRTweet *tweet = [Model sharedInstance].tweets[indexPath.row];
    return [TWTRTweetTableViewCell heightForTweet:tweet width:tweetTableView.bounds.size.width];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TWTRTweet *tweet = [Model sharedInstance].tweets[indexPath.row];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
