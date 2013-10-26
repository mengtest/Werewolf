//
//  PXInputView.h
//  WereWolf
//
//  Created by Mango on 13-10-26.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PXInputView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) NSMutableArray *nameArray;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UITableView *nameTableView;
@property (nonatomic,strong) UIImageView *cardView;

@end
