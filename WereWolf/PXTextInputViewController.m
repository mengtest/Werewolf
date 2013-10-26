//
//  PXTextInputViewController.m
//  WereWolf
//
//  Created by Mango on 13-10-25.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import "PXTextInputViewController.h"
#import "PXDataKeeper.h"
#import "PXRoleManager.h"
#import "UIViewController+ADFlipTransition.h"
@interface PXTextInputViewController (){
    
}
@property (nonatomic,strong) NSMutableArray *nameArray;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UITableView *nameTableView;
@property (nonatomic,strong) UIImageView *cardView;
@property (nonatomic,strong) PXRoleManager *manager;
@end

@implementation PXTextInputViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.manager = [PXRoleManager defaultManager];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _cardView = [[UIImageView alloc]initWithFrame:self.view.frame];
    _cardView.backgroundColor = [UIColor yellowColor];
    NSString *picName = [NSString stringWithFormat:@"big%d",self.type];
    _cardView.image = [UIImage imageNamed:picName];
    [self.view addSubview:_cardView];
    
    PXDataKeeper *dataKeeper = [PXDataKeeper sharedInstance];
    [dataKeeper getData];
    _nameArray = dataKeeper.nameArray;
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(57, 436, 206, 44)];
    _textField.delegate = self;
    _textField.placeholder = @"请输入名字";
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.borderStyle = UITextBorderStyleNone;//设置文本框的边框风格
    _textField.textColor = [UIColor blackColor];
    _textField.font = [UIFont systemFontOfSize:22];
    _textField.background = [UIImage imageNamed:@"输入框"];
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_textField];
    
    _nameTableView = [[UITableView alloc]initWithFrame:CGRectMake(50, 130+44, 220, 200)];
    _nameTableView.dataSource = self;
    _nameTableView.delegate = self;
    _nameTableView.backgroundColor = [UIColor colorWithRed:160/250.0 green:129/250.0 blue:101/250.0 alpha:1];
    _nameTableView.separatorColor = [UIColor blackColor];
    _nameTableView.hidden = YES;
    [self.view addSubview:_nameTableView];
    
    [self addGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
- (void)tableViewDropDown
{
    self.nameTableView.hidden = NO;
}
 */

-(void)addGesture
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(pushVC)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
}

- (void)pushVC  //在里面实现保存数据和跳转
{
    int i = 1;
    for (NSString* name in self.nameArray)
    {
        if ([name isEqualToString:self.textField.text]) {
            i = 0;
        }
    }
    if (i)
    {
        [[PXDataKeeper sharedInstance]addObject:self.textField.text];
        [[PXDataKeeper sharedInstance]saveData];
    }
    
    [self dismissFlipWithCompletion:NULL];
}
#pragma mark TextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self pushVC];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGRect frame = self.textField.frame;
    if (frame.origin.y != 130)
    {
        frame.origin.y = 130;
        self.textField.frame = frame;
    }
    self.nameTableView.hidden = NO;
    return YES;
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.nameArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndentifier = @"name";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    
    cell.textLabel.text = [self.nameArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.backgroundColor = [UIColor colorWithRed:160/250.0 green:129/250.0 blue:101/250.0 alpha:1];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.textField.text = [self.nameArray objectAtIndex:indexPath.row];
    self.nameTableView.hidden = YES;
}

#pragma mark UIScollView

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textField resignFirstResponder];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.manager changeRoleTag:self.tag ToName:self.textField.text];
    
}
@end
