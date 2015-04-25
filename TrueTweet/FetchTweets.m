//
//  FetchTweets.m
//  TrueTweet
//
//  Created by Sreekanth on 25/04/15.
//  Copyright (c) 2015 Housing. All rights reserved.
//

#import "FetchTweets.h"
#import "WebRequester.h"
#import <TwitterKit/TwitterKit.h>

#define TWEET_SEARCH_PERSON_URL     @""

#define REQUEST_AUTH_TOKEN_KEY      @"authToken"
#define REQUEST_AUTH_SECRET_KEY     @"authSecret"
#define REQUEST_SCREEN_NAME_KEY     @"screen_name"
#define REQUEST_QUERY_STRING_KEY    @"query"

@implementation FetchTweets

- (instancetype)initWithQuery:(NSString *)query
                  requestType:(QueryType)queryType
                 onCompletion:(TweetFetchCompletionBlock)tweetFetchCompletionBlock
{
    self = [super init];
    NSMutableDictionary *paramDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"", nil];
    __block WebRequester *webRequester = [[WebRequester alloc]initWithService:TWEET_SEARCH_PERSON_URL withGetParams:paramDictionary onCompletion:^(NSInteger status, NSString *message, NSDictionary *resultDictionary, NSError *error) {
        //Completion Code
        if (status == 200)
        {
            //Successful respose
        }
        else if (status == 400)
        {
            //Failed to fetch response
        }
        webRequester = nil;
    }];
    return self;
}

@end
