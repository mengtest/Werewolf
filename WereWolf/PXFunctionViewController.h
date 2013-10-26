//
//  PXFunctionViewController.h
//  WereWolf
//
//  Created by 朱泌丞 on 13-10-25.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

@protocol PXFunctionDelegate <NSObject>
-(void)didSelectedButton:(NSInteger)tag;

@end
#import <UIKit/UIKit.h>
#import "CardDetailButton.h"
#import "PXRoleManager.h"
@interface PXFunctionViewController : UIViewController
@property (nonatomic,assign) id<PXFunctionDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *buttonArray;
@property PXStoryType type;
@property (nonatomic,strong) PXRoleManager *manager;
@end
