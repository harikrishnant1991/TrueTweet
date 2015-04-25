//
//  FetchTweets.h
//  TrueTweet
//
//  Created by Sreekanth on 25/04/15.
//  Copyright (c) 2015 Housing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    kPersonSearch,
    kQuerySearch
} QueryType;

typedef void(^TweetFetchCompletionBlock)(BOOL, NSArray *, NSString *);

@interface FetchTweets : NSObject

- (instancetype)initWithQuery:(NSString *)query
                  requestType:(QueryType)queryType
                 onCompletion:(TweetFetchCompletionBlock)tweetFetchCompletionBlock;

@end
