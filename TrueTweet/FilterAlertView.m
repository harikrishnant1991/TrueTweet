//
//  FilterAlertView.m
//  TrueTweet
//
//  Created by Sreekanth on 26/04/15.
//  Copyright (c) 2015 Housing. All rights reserved.
//

#import "FilterAlertView.h"

@interface FilterAlertView ()
{
    __weak IBOutlet UITextField *searchQueryField;
    __weak IBOutlet UIView *alertBodyView;
    __weak IBOutlet UIButton *closeButton;
}

@end

@implementation FilterAlertView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    closeButton.layer.cornerRadius = 15.0;
    closeButton.layer.masksToBounds = YES;
    
    alertBodyView.layer.cornerRadius = 5.0;
    alertBodyView.layer.masksToBounds = YES;
}

- (void)show
{
    self.frame = [UIApplication sharedApplication].keyWindow.frame;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (IBAction)filterButtonClicked:(UIButton *)sender
{
    if (searchQueryField.text && ![searchQueryField.text isEqualToString:@""])
    {
        _buttonClickHandler(sender.tag, searchQueryField.text);
    }
    [self closeButtonClicked:sender];
}

- (IBAction)closeButtonClicked:(id)sender
{
    [self removeFromSuperview];
}

@end
