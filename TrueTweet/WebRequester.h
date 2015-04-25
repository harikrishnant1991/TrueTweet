//
//  WebRequester.h
//  TrueTweet
//
//  Created by Sreekanth on 25/04/15.
//  Copyright (c) 2015 Housing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ServiceCompletionBlock)(NSInteger, NSString *, NSDictionary *, NSError *);

@interface WebRequester : NSObject

- (instancetype)initWithService:(NSString *)service
                  withGetParams:(NSDictionary *)paramDictionary
                   onCompletion:(ServiceCompletionBlock)completionBlock;

@end
