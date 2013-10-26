//
//  PXChooseViewController.m
//  WereWolf
//
//  Created by 朱泌丞 on 13-10-25.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import "PXChooseViewController.h"
#import "PXRoleManager.h"
#import "PXPlayersViewController.h"

@interface PXChooseViewController ()
{
    BOOL _witchIsChosen;
    BOOL _gurafIsChosen;
    BOOL _cupidIsChosen;
    BOOL _predictIsChosen;
    BOOL _hunterIsChosen;
    BOOL _girlIsChosen;
    
}

@property (nonatomic,strong) NSMutableArray *specialRole;

@property (weak, nonatomic) IBOutlet UILabel *sumNumLable;
@property (weak, nonatomic) IBOutlet UILabel *wolfNumLable;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumLable;

@property NSInteger sumNum;
@property NSInteger peopleNum;
@property NSInteger wolfNum;

@end

@implementation PXChooseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
                self.navigationController.interactivePopGestureRecognizer.delegate = self;
        self.sumNum = 8;
        self.peopleNum = 3;
        self.wolfNum = 2;
        _witchIsChosen = YES;
        _gurafIsChosen = YES;
        _cupidIsChosen = YES;
        _predictIsChosen = NO;
        _hunterIsChosen = NO;
        _girlIsChosen = NO;
        self.specialRole = [@[[NSNumber numberWithBool:_witchIsChosen],[NSNumber numberWithBool:_gurafIsChosen],[NSNumber numberWithBool:_cupidIsChosen],[NSNumber numberWithBool:_predictIsChosen],[NSNumber numberWithBool:_hunterIsChosen],[NSNumber numberWithBool:_girlIsChosen]] mutableCopy];

    }
    return self;
}
- (IBAction)changeNum:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            self.sumNumLable.text = [NSString stringWithFormat:@"%d",++self.sumNum];
            self.wolfNumLable.text = [NSString stringWithFormat:@"%d",++self.wolfNum];
            break;
        case 2:
            self.sumNumLable.text = [NSString stringWithFormat:@"%d",--self.sumNum];
            self.wolfNumLable.text = [NSString stringWithFormat:@"%d",--self.wolfNum];
            break;
        case 3:
            self.sumNumLable.text = [NSString stringWithFormat:@"%d",++self.sumNum];
            self.peopleNumLable.text = [NSString stringWithFormat:@"%d",++self.peopleNum];
            break;
        case 4:
            self.sumNumLable.text = [NSString stringWithFormat:@"%d",--self.sumNum];
            self.peopleNumLable.text = [NSString stringWithFormat:@"%d",--self.peopleNum];
            break;
        default:
            break;
    }
}

- (IBAction)chooseSpecialRole:(UIButton *)sender{
    NSInteger tag = sender.tag;
    BOOL isChosen = [[self.specialRole objectAtIndex:tag-2] boolValue];
    isChosen = !isChosen;
    [self.specialRole setObject:[NSNumber numberWithBool:isChosen] atIndexedSubscript:tag-2];
    if (isChosen) {
         self.sumNumLable.text = [NSString stringWithFormat:@"%d",++self.sumNum];
        NSString *picName = [NSString stringWithFormat:@"small%d",tag];
        [sender setImage:[UIImage imageNamed:picName] forState:UIControlStateNormal];
    }else{
         self.sumNumLable.text = [NSString stringWithFormat:@"%d",--self.sumNum];
        NSString *picName = [NSString stringWithFormat:@"choose0%dq",tag];
        [sender setImage:[UIImage imageNamed:picName] forState:UIControlStateNormal];
    }
    
}
- (IBAction)startGame:(UIButton *)sender {
    PXRoleManager *manager = [[PXRoleManager alloc] initWithSumNum:self.sumNum andPeopleNum:self.peopleNum andWolfNum:self.wolfNum andSpecialRoles:self.specialRole];
    NSLog(@"%@",manager);
    
    PXPlayersViewController *playerVC = [[PXPlayersViewController alloc] init];
    [self.navigationController pushViewController:playerVC animated:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.sumNumLable.text = [NSString stringWithFormat:@"%d",self.sumNum];
        self.wolfNumLable.text = [NSString stringWithFormat:@"%d",self.wolfNum];
        self.peopleNumLable.text = [NSString stringWithFormat:@"%d",self.peopleNum];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%@",gestureRecognizer);
    return YES;
}


@end

