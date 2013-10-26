//
//  PXTextInputViewController.h
//  WereWolf
//
//  Created by Mango on 13-10-25.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PXTextInputViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) NSMutableArray *nameArray;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UITableView *nameTableView;
@property (nonatomic,strong) UIImageView *cardView;

@end
