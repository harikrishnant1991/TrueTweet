//
//  Model.h
//  TrueTweet
//
//  Created by Sreekanth on 25/04/15.
//  Copyright (c) 2015 Housing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ListFetchCompletionBlock)(BOOL);

@interface Model : NSObject

@property (nonatomic, strong) NSArray *tweets;

- (void)fetchTweetsForUser:(NSString *)screenName onCompletion:(ListFetchCompletionBlock)completionBlock;

- (void)fetchTweetsWithQuery:(NSString *)query onCompletion:(ListFetchCompletionBlock)completionBlock;

+ (Model *)sharedInstance;

@end
