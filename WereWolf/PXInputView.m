//
//  PXInputView.m
//  WereWolf
//
//  Created by Mango on 13-10-26.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import "PXInputView.h"
#import "PXDataKeeper.h"

@implementation PXInputView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _cardView = [[UIImageView alloc]initWithFrame:self.frame];
        _cardView.backgroundColor = [UIColor yellowColor];
        _cardView.image = [UIImage imageNamed:@"big0"];
        [self addSubview:_cardView];
        
        PXDataKeeper *dataKeeper = [PXDataKeeper sharedInstance];
        [dataKeeper getData];
        _nameArray = dataKeeper.nameArray;
        
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(50, 50, 220, 80)];
        _textField.delegate = self;
        _textField.placeholder = @"请输入名字";
        _textField.backgroundColor = [UIColor whiteColor];
        //[_textField addTarget:self action:@selector(tableViewDropDown) forControlEvents:UIControlEventAllTouchEvents];
        [self addSubview:_textField];
        
        _nameTableView = [[UITableView alloc]initWithFrame:CGRectMake(50, 130, 220, 200)];
        _nameTableView.dataSource = self;
        _nameTableView.delegate = self;
        _nameTableView.hidden = YES;
        [self addSubview:_nameTableView];
        
        [self addGesture];
    }
    return self;
}

-(void)addGesture
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipe];
}

- (void)remove  //在里面实现保存数据和返回
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
    [self removeFromSuperview];
    
}
#pragma mark TextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self remove];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.nameTableView.hidden = NO;
    //CGRect frame = self.textField.frame;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndentifier = @"name";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    
    cell.textLabel.text = [self.nameArray objectAtIndex:indexPath.row];
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


@end
