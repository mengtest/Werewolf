//
//  BUTTON.m
//  wolf
//
//  Created by a3-169i on 13-6-1.
//  Copyright (c) 2013年 mango. All rights reserved.
//

#import "CardDetailButton.h"

@implementation CardDetailButton
@synthesize lable = _lable;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor blackColor];
        self.lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, 80, 20)];
        [self addSubview:self.lable];
        self.lable.textAlignment = NSTextAlignmentCenter;
        self.lable.font = [UIFont systemFontOfSize:20];
        self.lable.backgroundColor = [UIColor clearColor];
        
        self.image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
        [self addSubview:self.image];
        self.secondImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,100,120)];
        [self addSubview:self.secondImage];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
}


@end
