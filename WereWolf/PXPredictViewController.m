//
//  PXPredictViewController.m
//  WereWolf
//
//  Created by 朱泌丞 on 13-10-26.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import "PXPredictViewController.h"
#import "UIViewController+ADFlipTransition.h"
#import "PXShowViewController.h"
@interface PXPredictViewController ()

@end

@implementation PXPredictViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)didSelectedButton:(NSInteger)tag
{
    for (CardDetailButton *button in self.buttonArray) {
        if (button.tag == tag) {
            PXShowViewController *showVC = [[PXShowViewController alloc] init];
            showVC.type = [self.manager getRoleTypeWithTag:tag];
            [self flipToViewController:showVC fromView:button withCompletion:^{
            }];

        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
