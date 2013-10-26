//
//  PXStoryViewController.m
//  WereWolf
//
//  Created by 朱泌丞 on 13-10-25.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import "PXStoryViewController.h"
#import "PXFunctionViewController.h"
#import "PXCupidViewController.h"
#import "PXGuardViewController.h"
#import "PXWitchViewController.h"
#import "PXWolfViewController.h"
#import "PXPredictViewController.h"
@interface PXStoryViewController (){
    NSData *gif;
}
@property (weak, nonatomic) IBOutlet UIWebView *gifView;

@end

@implementation PXStoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *gitName = [self getGifNameForType:self.type];
    gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:gitName ofType:@"gif"]];
    

    self.gifView.userInteractionEnabled = NO;
    [self.gifView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextVC:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipe];
    // Do any additional setup after loading the view from its nib.
}
-(void)nextVC:(UIPanGestureRecognizer *)sender
{
    NSLog(@"type:%d\ncontroller%@\n",self.type,self.navigationController.childViewControllers);
    switch (self.type) {
        case PXStoryTypeCupid:{
            PXCupidViewController *cupid = [[PXCupidViewController alloc] init];
            cupid.type = PXStoryTypeCupid;
            [self.navigationController pushViewController:cupid animated:YES];
            break;
        }
        case PXStoryTypeGuard:{
            PXGuardViewController *cupid = [[PXGuardViewController alloc] init];
            cupid.type = PXStoryTypeGuard;
            [self.navigationController pushViewController:cupid animated:YES];
            break;
        }
        case PXStoryTypePredict:{
            PXPredictViewController *cupid = [[PXPredictViewController alloc] init];
            cupid.type = PXStoryTypePredict;
            [self.navigationController pushViewController:cupid animated:YES];
            break;
        }
        case PXStoryTypeWitch:{
            PXWitchViewController *cupid = [[PXWitchViewController alloc] init];
            cupid.type = PXStoryTypeWitch;
            [self.navigationController pushViewController:cupid animated:YES];
            break;
        }
        case PXStoryTypeWolf:{
            PXWolfViewController *cupid = [[PXWolfViewController alloc] init];
            cupid.type = PXStoryTypeWolf;
            [self.navigationController pushViewController:cupid animated:YES];
            break;
        }
        case PXStoryTypePeople:{
            PXWolfViewController *cupid = [[PXWolfViewController alloc] init];
            cupid.type = PXStoryTypePeople;
            [self.navigationController pushViewController:cupid animated:YES];
            break;
        }
        default:
            break;
    }
}
-(NSString *)getGifNameForType:(PXStoryType)type
{
    NSString *gitName = [[NSString alloc] init];
    switch (type) {
        case PXStoryTypeCupid:
            gitName = @"cupid";
            break;
        case PXStoryTypeGuard:
            gitName = @"raise";
            break;
        case PXStoryTypePredict:
            gitName = @"witch";
            break;
        case PXStoryTypeWolf:
            gitName = @"wolf";
            break;
        case PXStoryTypeWitch:
            gitName = @"witch";
            break;
        case PXStoryTypePeople:
            gitName = @"raise";
        default:
            break;
    }
    
    return gitName;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.gifView removeFromSuperview];
    self.gifView = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
