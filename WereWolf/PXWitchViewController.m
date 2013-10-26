//
//  PXWitchViewController.m
//  WereWolf
//
//  Created by 朱泌丞 on 13-10-26.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import "PXWitchViewController.h"

@interface PXWitchViewController ()

@end

@implementation PXWitchViewController

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
            PXStoryType status = [self.manager getRoleStatusWithTag:tag];
            if (status == PXRoleStatusDead) {
                [self.manager changeRoleTag:tag ToStatus:PXRoleStatusAlive];
                button.secondImage.image = nil;
            }
            if (status == PXRoleStatusCupid||status == PXRoleStatusAlive) {
                [self.manager changeRoleTag:tag ToStatus:PXRoleStatusDead];
                button.secondImage.image = [UIImage imageNamed:@"ghost"];
            }
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
