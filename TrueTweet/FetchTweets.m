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

#define TWEET_SEARCH_QUERY_URL      @"sendAuthDetails"
#define TWEET_SEARCH_PERSON_URL     @"getDetailsId"

#define REQUEST_AUTH_TOKEN_KEY      @"authToken"
#define REQUEST_AUTH_SECRET_KEY     @"authSecret"

#define REQUEST_SCREEN_NAME_KEY     @"userId"
#define REQUEST_QUERY_STRING_KEY    @"screenName"

#define RESPONSE_TWEETS_KEY         @"statuses"

@implementation FetchTweets

- (instancetype)initWithQuery:(NSString *)query
                  requestType:(QueryType)queryType
                 onCompletion:(TweetFetchCompletionBlock)tweetFetchCompletionBlock
{
    self = [super init];
    NSMutableDictionary *paramDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:[TwitterKit session].authToken, REQUEST_AUTH_TOKEN_KEY, [TwitterKit session].authTokenSecret, REQUEST_AUTH_SECRET_KEY, nil];
    
    NSString *servicePath;
    switch (queryType)
    {
        case kPersonSearch:
        {
            [paramDictionary setObject:query forKey:REQUEST_SCREEN_NAME_KEY];
            servicePath = TWEET_SEARCH_PERSON_URL;
        }
            break;
        case kQuerySearch:
        {
            [paramDictionary setObject:query forKey:REQUEST_QUERY_STRING_KEY];
            servicePath = TWEET_SEARCH_QUERY_URL;
        }
            break;
        default:
            break;
    }
    
    __block TweetFetchCompletionBlock completionBlock = tweetFetchCompletionBlock;
    __block WebRequester *webRequester = [[WebRequester alloc]initWithService:servicePath withGetParams:paramDictionary onCompletion:^(NSInteger status, NSString *message, NSDictionary *resultDictionary, NSError *error) {
        //Completion Code
        if (status == 200)
        {
            //Successful respose
            NSArray *tweets = [TWTRTweet tweetsWithJSONArray:resultDictionary[RESPONSE_TWEETS_KEY]];
            if (completionBlock)
            {
                completionBlock(YES, tweets, nil);
                completionBlock = nil;
            }
        }
        else if (status == 400)
        {
            //Failed to fetch response
        }
        else if (status == 100)
        {
            
        }
        else if (status == 101)
        {
            
        }
        webRequester = nil;
    }];
    return self;
}

@end
