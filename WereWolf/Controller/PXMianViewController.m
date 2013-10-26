//
//  PXMianViewController.m
//  WereWolf
//
//  Created by 朱泌丞 on 13-10-25.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import "PXMianViewController.h"
#import "PXChooseViewController.h"
@interface PXMianViewController ()

@end

@implementation PXMianViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    return self;
}
- (IBAction)startGame:(UIButton *)sender {
    PXChooseViewController *chooseVC = [[PXChooseViewController alloc] init];
    [self.navigationController pushViewController:chooseVC animated:YES];
}
- (IBAction)setUp:(UIButton *)sender {
}
- (IBAction)tipsOfGame:(UIButton *)sender {
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}
@end
