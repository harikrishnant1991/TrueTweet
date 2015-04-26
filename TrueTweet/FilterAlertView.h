//
//  FilterAlertView.h
//  TrueTweet
//
//  Created by Sreekanth on 26/04/15.
//  Copyright (c) 2015 Housing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickHandler)(NSInteger, NSString *);

@interface FilterAlertView : UIView

@property (nonatomic, strong) ButtonClickHandler buttonClickHandler;

- (void)show;

@end
