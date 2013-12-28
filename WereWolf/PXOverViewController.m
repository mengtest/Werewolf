//
//  PXOverViewController.m
//  WereWolf
//
//  Created by 朱泌丞 on 13-10-26.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import "PXOverViewController.h"
#import "PXChooseViewController.h"
#import <BaiduSocialShare/BDSocialShareSDK.h>
#import "PXMianViewController.h"
@interface PXOverViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UIImageView *overImageView;

@end

@implementation PXOverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)backToFirst:(UIButton *)sender {
    PXMianViewController *chooseVC = [self.navigationController.childViewControllers objectAtIndex:0];
    [self.navigationController popToViewController:chooseVC animated:YES];
}

- (IBAction)shareAction:(UIButton *)sender {
    BDSocialEventHandler result = ^(BD_SOCIAL_RESULT requestResult, NSString *shareType, id response, NSError *error)
    {
        if (requestResult == BD_SOCIAL_SUCCESS) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:[NSString stringWithFormat:@"%@分享成功",shareType] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            NSLog(@"%@分享成功",shareType);
        } else if (requestResult == BD_SOCIAL_CANCEL){
            NSLog(@"分享取消");
        } else if (requestResult == BD_SOCIAL_FAIL){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@分享失败\n error code:%d;\n error message:%@",shareType,error.code,[error localizedDescription]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            NSLog(@"%@分享失败\n error code:%d;\n error message:%@",shareType,error.code,[error localizedDescription]);
        }
    };

    BDSocialShareContent *content = [BDSocialShareContent shareContentWithDescription:@"百度社会化分享组件封装了新浪微博、人人网、开心网、腾讯微博、QQ空间等平台的授权及分享功能，也支持本地QQ好友分享、微信分享、邮件和短信发送等，同时提供了API接口调用及本地操作界面支持。组件集成简便，风格定制灵活，可轻松实现多平台分享功能。" url:@"http://developer.baidu.com/soc/share" title:@"百度社会化分享"];
    [content addImageWithImageSource:[UIImage imageNamed:@"share_small.png"] imageUrl:@"http://apps.bdimg.com/developer/static/04171450/developer/images/icon/terminal_adapter.png"];
    SHARE_MENU_STYLE style = BD_SOCIAL_SHARE_MENU_THEME_STYLE;
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    [content addImageWithImageSource:viewImage imageUrl:nil];
    
    
    [BDSocialShareSDK showShareMenuWithShareContent:content menuStyle:style supportedInterfaceOrientations:UIInterfaceOrientationMaskAllButUpsideDown result:result];
    

}
- (IBAction)restartAction:(UIButton *)sender {
    PXChooseViewController *chooseVC = [self.navigationController.childViewControllers objectAtIndex:1];
    [self.navigationController popToViewController:chooseVC animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *imageName = [NSString stringWithFormat:@"over%d",self.status];
    self.overImageView.image = [UIImage imageNamed:imageName];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
