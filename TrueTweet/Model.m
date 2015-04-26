//
//  Model.m
//  TrueTweet
//
//  Created by Sreekanth on 25/04/15.
//  Copyright (c) 2015 Housing. All rights reserved.
//

#import "Model.h"
#import "FetchTweets.h"

@interface Model ()
{
}

@end

@implementation Model

+ (Model *)sharedInstance
{
    static Model *sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (void)fetchTweetsForUser:(NSString *)screenName onCompletion:(ListFetchCompletionBlock)completionBlock
{
    __block ListFetchCompletionBlock tweetFetchCompletionBlock = completionBlock;
    __block FetchTweets *fetchTweets = [[FetchTweets alloc] initWithQuery:screenName requestType:kPersonSearch onCompletion:^(BOOL success, NSArray *tweets, NSString *errorMessage) {
        //Handle response
        if (success)
        {
            //Handle success response
            _tweets = tweets;
        }
        else
        {
            //Handle error
        }
        if (tweetFetchCompletionBlock)
        {
            tweetFetchCompletionBlock(success);
            tweetFetchCompletionBlock = nil;
        }
        fetchTweets = nil;
    }];
}

- (void)fetchTweetsWithQuery:(NSString *)query onCompletion:(ListFetchCompletionBlock)completionBlock
{
    __block ListFetchCompletionBlock tweetFetchCompletionBlock = completionBlock;
    __block FetchTweets *fetchTweets = [[FetchTweets alloc] initWithQuery:query requestType:kQuerySearch onCompletion:^(BOOL success, NSArray *tweets, NSString *errorMessage) {
        //Handle response
        if (success)
        {
            //Handle success response
            _tweets = tweets;
        }
        else
        {
            //Handle error
        }
        if (tweetFetchCompletionBlock)
        {
            tweetFetchCompletionBlock(success);
            tweetFetchCompletionBlock = nil;
        }
        fetchTweets = nil;
    }];
}

@end
