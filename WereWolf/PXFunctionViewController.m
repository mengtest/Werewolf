//
//  PXFunctionViewController.m
//  WereWolf
//
//  Created by 朱泌丞 on 13-10-25.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import "PXFunctionViewController.h"
#import "CardDetailButton.h"
#import "PXStoryViewController.h"
#define originX 36
#define originX2 186
#define originY 20
#define heightGap 150
#define height 120
#define weith 100
@interface PXFunctionViewController ()
@property (nonatomic,strong) UIScrollView *scrollView;



@end

@implementation PXFunctionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.manager = [PXRoleManager defaultManager];
        self.buttonArray = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)loadView
{
    [super loadView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.scrollView];
    [self initCard];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextVC:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipe];
    
}
-(void)nextVC:(UISwipeGestureRecognizer *)sender
{
    PXStoryType type = [self.manager getNextStoryTypeFromCurrentType:self.type];
    PXStoryViewController *storyVC = [[PXStoryViewController alloc] init];
    storyVC.type = type;
    [self.navigationController pushViewController:storyVC animated:YES];
}
-(void)initCard
{
    NSInteger sumNum = self.manager.sumNum;
    [self.scrollView setContentSize:CGSizeMake(320, originY + sumNum / 2 * heightGap + 50)];
    for (int i = 0; i < sumNum; i++) {
        float x = i % 2?originX2:originX;
        CardDetailButton *button = [[CardDetailButton alloc] initWithFrame:CGRectMake(x, originY + i / 2 * heightGap, weith, height)];
        [button addTarget:self action:@selector(executeFunction:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor blackColor];
        NSString *picName = [NSString stringWithFormat:@"small%d",[self.manager getRoleTypeWithTag:i]];
        button.tag = i;
        button.image.image = [UIImage imageNamed:picName];
        [button setBackgroundImage:[UIImage imageNamed:@"cardBack"] forState:UIControlStateNormal];
        [self.scrollView addSubview:button];
        [self.buttonArray addObject:button];
    }
}
-(void)executeFunction:(CardDetailButton *)sender
{
    [self.delegate didSelectedButton:sender.tag];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
