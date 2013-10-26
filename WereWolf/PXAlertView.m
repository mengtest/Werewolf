//
//  PXAlertView.m
//  WereWolf
//
//  Created by Mango on 13-10-25.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import "PXAlertView.h"

@implementation PXAlertView
{
    CGRect originalFrame;
}

- (id)init
{
    CGRect frame = CGRectMake(25, 120, 270, 270);
    originalFrame = frame;
    self = [super initWithFrame:frame];
    if (self)
    {
        _background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 270, 270)];
        _background.backgroundColor = [UIColor yellowColor];
        [self addSubview:_background];
        
        _alertImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 230, 200)];
        _alertImage.backgroundColor = [UIColor purpleColor];
        [self addSubview:_alertImage];
        
        _Ok = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Ok addTarget:self action:@selector(clickButtonOne) forControlEvents:UIControlEventTouchUpInside];
        CGRect frame = CGRectMake(85, 220, 50, 100);
        _Ok.frame = frame;
        _Ok.backgroundColor = [UIColor blueColor];
        [self addSubview:_Ok];
    }
    return self;
}

- (void)clickButtonOne
{
    if (self.delegate)
    {
        [self.delegate alertView:self clickedButtonAtIndex:0];
    }
    [self hide];
}

- (void)show
{
    NSLog(@"show");
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.alpha = 0;
    [UIView beginAnimations:@"showAlert" context:nil];
    [UIView setAnimationDelegate:self];
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.alpha = 1;
    [UIView commitAnimations];
}

- (void)hide
{
    NSLog(@"hide");
    [UIView beginAnimations:@"hideAlert" context:nil];
    [UIView setAnimationDelegate:self];
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.alpha = 0;
    [UIView commitAnimations];
    [self removeFromSuperview];
}

#pragma mark Animation delegate

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"showAlert"]) {
        if (finished) {
            [UIView beginAnimations:nil context:nil];
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            [UIView commitAnimations];
        }
    } else if ([animationID isEqualToString:@"hideAlert"]) {
        if (finished) {
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.frame = originalFrame;
        }
    }
}

@end
