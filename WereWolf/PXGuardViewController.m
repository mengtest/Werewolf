//
//  PXGuardViewController.m
//  WereWolf
//
//  Created by 朱泌丞 on 13-10-26.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import "PXGuardViewController.h"

@interface PXGuardViewController ()

@end

@implementation PXGuardViewController

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
            button.secondImage.image = [UIImage imageNamed:@"shield"];
            [self.manager changeRoleTag:tag ToStatus:PxRoleStatusIsGuard];
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
