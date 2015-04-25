//
//  WebRequester.m
//  TrueTweet
//
//  Created by Sreekanth on 25/04/15.
//  Copyright (c) 2015 Housing. All rights reserved.
//

#import "WebRequester.h"

#define BASE_URL                @"http://192.168.1.106:8080/Hack/rest/twitter"

#define RESPONSE_STATUS_KEY     @"status"
#define RESPONSE_MESSAGE_KEY    @"message"
#define RESPONSE_RESULTS_KEY    @"results"

#define SERVER_ERROR_MESSAGE    @"We are having some trouble communicating with the server. Please try again later."

@interface WebRequester () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NSMutableData *webData;
    
    ServiceCompletionBlock serviceCompletionBlock;
}

@end

@implementation WebRequester

- (instancetype)initWithService:(NSString *)service
                  withGetParams:(NSDictionary *)paramDictionary
                   onCompletion:(ServiceCompletionBlock)completionBlock
{
    self = [super init];
    if (self)
    {
        serviceCompletionBlock = completionBlock;
        
        NSMutableString *paramString = [NSMutableString string];
        for (NSString *key in [paramDictionary allKeys])
        {
            [paramString appendFormat:@"%@=%@&", key, paramDictionary[key]];
        }
        
        NSURL *serviceURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?%@", BASE_URL, service, paramString]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:serviceURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    webData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error = nil;
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:webData
                                                                       options:0
                                                                         error:&error];
    if (error && serviceCompletionBlock)
    {
        serviceCompletionBlock(100, SERVER_ERROR_MESSAGE, nil, error);
        serviceCompletionBlock = nil;
    }
    else if (serviceCompletionBlock)
    {
        serviceCompletionBlock([responseDictionary[RESPONSE_STATUS_KEY] integerValue], responseDictionary[RESPONSE_MESSAGE_KEY], responseDictionary[RESPONSE_RESULTS_KEY], nil);
        serviceCompletionBlock = nil;
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (serviceCompletionBlock)
    {
        serviceCompletionBlock(101, nil, nil, error);
        serviceCompletionBlock = nil;
    }
}

@end
