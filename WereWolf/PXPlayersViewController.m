//
//  PXPlayersViewController.m
//  WereWolf
//
//  Created by 朱泌丞 on 13-10-25.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import "PXPlayersViewController.h"
#import "PXStoryViewController.h"
#import "PXRoleManager.h"
#import "PXTextInputViewController.h"
#import "UIViewController+ADFlipTransition.h"


#define CARD_CONTAINER_WIDTH 320-31-31
#define CARD_CONTAINER_MARGIN 31.0
#define CARD_WIDTH  130
#define CARD_HEIGHT 156
#define cardX 30.0
#define cardY 155.0
#define backButtonFrame CGRectMake(89,362.5,142.5,54)
#define startButtonFrame
@interface PXPlayersViewController (){
    NSInteger cardNum;
}
@property (nonatomic,strong) NSMutableArray *cardArry;
@property (nonatomic,strong) PXRoleManager *manager;
@end

@implementation PXPlayersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.manager = [PXRoleManager defaultManager];
        self.cardArry = [[NSMutableArray alloc] init];
        cardNum = self.manager.sumNum;
    }
    return self;
}
-(void)loadView
{
    [super loadView];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    background.image = [UIImage imageNamed:@"playerBG"];
    [self.view addSubview:background];
    
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [startButton setTitle:@"startGame" forState:UIControlStateNormal];
    startButton.frame = CGRectMake(0, 0, 100, 100);
    [startButton addTarget:self action:@selector(startGame:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backButtonFrame;
    [backButton setImage:[UIImage imageNamed:@"playerBack"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"playerBackS"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(popVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    [self initCardWithNumber:self.manager.sumNum];
}
-(void)popVC:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)startGame:(UIButton *)sender
{
    PXStoryViewController *storyVC = [[PXStoryViewController alloc] initWithType:[self.manager getNextStoryTypeFromCurrentType:PXStoryTypeStart]];
    
    [self.navigationController pushViewController:storyVC animated:YES];

}
-(void)initCardWithNumber:(NSInteger)num
{
    int i = 0;
    for (; i < num; i++) {
        UIView *card = [[UIView alloc]initWithFrame:CGRectMake(-150, cardY, CARD_WIDTH, CARD_HEIGHT)];
        if(num==1){
            card.tag = (320-CARD_WIDTH)/2;
        }else{
            card.tag = i*(CARD_CONTAINER_WIDTH - CARD_WIDTH)/(num-1)+CARD_CONTAINER_MARGIN;
        }
        UIImageView *backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CARD_WIDTH, CARD_HEIGHT)];
//        backGround.layer.borderColor = [UIColor redColor].CGColor;
//        backGround.layer.borderWidth = 2.0;
        backGround.tag = 100;
        backGround.image = [UIImage imageNamed:@"playerCard"];
        [card addSubview:backGround];
        card.backgroundColor = [UIColor clearColor];
        card.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(tapEvent:)];
        [card addGestureRecognizer:tap];
        [self.view addSubview:card];
        [self.cardArry addObject:card];
    }
}
-(void)loadCardViewWithNumber:(NSInteger)num
{
    for (UIView *view in self.cardArry) {
        [view removeFromSuperview];
    }
    [self.cardArry removeAllObjects];
    if (num <= 0) {
        [self startGame:nil];
        return;
    }
    int i = 0;
    for (; i < num; i++) {
        NSInteger x;
        if(num==1){
            x = (320-CARD_WIDTH)/2;
        }else{
            x = i*(CARD_CONTAINER_WIDTH - CARD_WIDTH)/(num-1)+CARD_CONTAINER_MARGIN;
        }
        UIView *card = [[UIView alloc]initWithFrame:CGRectMake(x, cardY, CARD_WIDTH, CARD_HEIGHT)];
        UIImageView *backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CARD_WIDTH, CARD_HEIGHT)];
        backGround.tag = 100;
        backGround.image = [UIImage imageNamed:@"playerCard"];
        [card addSubview:backGround];
        card.backgroundColor = [UIColor clearColor];
        [self.view addSubview:card];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(tapEvent:)];
        [card addGestureRecognizer:tap];
        [self.cardArry addObject:card];
    }
}
-(void)tapEvent:(UITapGestureRecognizer *)tap
{
    /*
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration =0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"cube";
    animation.subtype = kCATransitionFromTop;
     animation.subtype = kCATransitionFromRight;
    [tap.view.layer addAnimation:animation forKey:@"animation"];
     */
    

    PXTextInputViewController *inputNameController = [[PXTextInputViewController alloc]init];
    inputNameController.type = [self.manager getRoleTypeWithTag:cardNum-1];
    inputNameController.tag = cardNum-1;
    //[self.navigationController pushViewController:inputNameController animated:YES];
    [self flipToViewController:inputNameController fromView:tap.view withCompletion:^{
            [self loadCardViewWithNumber:--cardNum];
    }];
    

    //UIView *InputView = [[PXInputView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSelector:@selector(startBeginAinimation) withObject:Nil afterDelay:0.3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)startBeginAinimation
{
    for (UIView *card in self.cardArry) {
        card.hidden = NO;
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            card.frame = CGRectMake(card.tag+CARD_CONTAINER_MARGIN, card.frame.origin.y, card.frame.size.width, card.frame.size.height);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                card.frame = CGRectMake(card.tag, card.frame.origin.y, card.frame.size.width, card.frame.size.height);
            }];
        }];
    }
}

#pragma mark - Trace Touch Point
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint;
    UITouch *touch = [touches anyObject];
    return;
//    if (_numOfcard == self.gameModel.peopleNum) {
//        return;
//    }
    if (touch) {
        touchPoint = [touch locationInView:self.view];
        if (touchPoint.y > cardY && touchPoint.y < cardY+CARD_HEIGHT) {
            for (int i = 0; i < [self.cardArry count]; i++) {
                UIView *fontView = [self.cardArry objectAtIndex:i];
                CGRect font = fontView.frame;
                if (i != [self.cardArry count] - 1) {
                    UIView *nextView = [self.cardArry objectAtIndex:i+1];
                    CGRect next = nextView.frame;
                    if (touchPoint.x > font.origin.x && touchPoint.x < next.origin.x) {
                        [self upTheView:fontView];
                    }else{
                        [self downTheView:fontView];
                    }
                }else{
                    if (touchPoint.x > font.origin.x && touchPoint.x < font.origin.x + 160) {
                        [self upTheView:fontView];
                    }else{
                        [self downTheView:fontView];
                    }
                }
            }
        }else{
            for (UIView *view in self.cardArry) {
                [self downTheView:view];
            }
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint;
    UITouch *touch = [touches anyObject];
//    if (_numOfcard == self.gameModel.peopleNum) {
//        return;
//    }
    if (touch) {
        touchPoint = [touch locationInView:self.view];
        if (touchPoint.y > cardY && touchPoint.y < cardY+CARD_HEIGHT) {
            for (int i = 0; i < [self.cardArry count]; i++) {
                UIView *fontView = [self.cardArry objectAtIndex:i];
                CGRect font = fontView.frame;
                if (i != [self.cardArry count] -1) {
                    UIView *nextView = [self.cardArry objectAtIndex:i+1];
                    CGRect next = nextView.frame;
                    if (touchPoint.x > font.origin.x && touchPoint.x < next.origin.x) {
                        [self upTheView:fontView];
                    }else{
                        [self downTheView:fontView];
                    }
                }else{
                    if (touchPoint.x > font.origin.x && touchPoint.x < font.origin.x + 160) {
                        [self upTheView:fontView];
                    }else{
                        [self downTheView:fontView];
                    }
                }
            }
        }else{
            for (UIView *view in self.cardArry) {
                [self downTheView:view];
            }
        }
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint;
    UITouch *touch = [touches anyObject];
//    if (_numOfcard == self.gameModel.peopleNum) {
//        return;
//    }
    if (touch) {
        touchPoint = [touch locationInView:self.view];
        if (touchPoint.y > cardY && touchPoint.y < cardY+CARD_HEIGHT) {
            for (int i = 0; i < [self.cardArry count]; i++) {
                UIView *fontView = [self.cardArry objectAtIndex:i];
                CGRect font = fontView.frame;
                if (i != [self.cardArry count] -1) {
                    UIView *nextView = [self.cardArry objectAtIndex:i+1];
                    CGRect next = nextView.frame;
                    if (touchPoint.x > font.origin.x && touchPoint.x < next.origin.x) {
//                        _isNoPhoto =NO;
//                        [self showTakePhotoView:fontView];
                    }else{
                        [self downTheView:fontView];
                    }
                }else{
                    if (touchPoint.x > font.origin.x && touchPoint.x < font.origin.x + 160) {
//                        _isNoPhoto =NO;
//                        [self showTakePhotoView:fontView];
                    }else{
                        [self downTheView:fontView];
                    }
                }
            }
        }else{
            for (UIView *view in self.cardArry) {
                [self downTheView:view];
            }
        }
    }
}
// 卡牌上升
-(void)upTheView:(UIView *)view
{
    CGRect frame = view.frame;
    if (view.frame.origin.y == cardY) {
        [UIView beginAnimations:nil context:nil] ;
        [UIView setAnimationDuration:0.2];
        frame.origin.y -= 10;
        view.frame = frame;
        [UIView commitAnimations];
    }
}
// 卡牌下降
-(void)downTheView:(UIView *)view
{
    CGRect frame = view.frame;
    if (view.frame.origin.y == cardY -10) {
        [UIView beginAnimations:nil context:nil] ;
        [UIView setAnimationDuration:0.2];
        frame.origin.y += 10;
        view.frame = frame;
        [UIView commitAnimations];
    }
}



@end
