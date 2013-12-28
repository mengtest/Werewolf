//
//  PXShowViewController.m
//  WereWolf
//
//  Created by 朱泌丞 on 13-10-27.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import "PXShowViewController.h"
#import "UIViewController+ADFlipTransition.h"
@interface PXShowViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

@end

@implementation PXShowViewController

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
    NSString *picName = self.type?@"haoren":@"huairen";
    self.showImageView.image = [UIImage imageNamed:picName];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popVC:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
    // Do any additional setup after loading the view from its nib.
}
-(void)popVC:(UISwipeGestureRecognizer *)sender
{
    [self dismissFlipWithCompletion:^{
        
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
