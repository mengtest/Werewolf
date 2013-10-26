//
//  PXAlertView.h
//  WereWolf
//
//  Created by Mango on 13-10-25.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PXAlertViewProtocol <NSObject>
- (void)alertView:(UIView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end


@interface PXAlertView : UIView

@property(nonatomic,strong) UIImageView *background;
@property(nonatomic,strong) UIImageView *alertImage;
@property(nonatomic,strong) UIButton *Ok;
@property(nonatomic,strong) id<PXAlertViewProtocol> delegate;

@end
