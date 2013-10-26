//
//  Created by Baidu Developer Center on 13-3-10.
//  官网地址:http://developer.baidu.com/soc/share
//  技术支持邮箱:dev_support@baidu.com
//  Copyright (c) 2013年 baidu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	@brief	分享菜单的样式
 */
typedef enum {
    BD_SOCIAL_SHARE_MENU_THEME_STYLE = 0,         //可更换主题风格
    BD_SOCIAL_SHARE_MENU_BLACK_STYLE,             //黑色风格
} SHARE_MENU_STYLE;

/**
 *	@brief	分享类型
 */
//新浪微博
#define kBD_SOCIAL_SHARE_PLATFORM_SINAWEIBO         @"sinaweibo"
//QQ空间
#define kBD_SOCIAL_SHARE_PLATFORM_QQZONE            @"qqdenglu"
//开心网
#define kBD_SOCIAL_SHARE_PLATFORM_KAIXIN            @"kaixin"
//QQ微博
#define kBD_SOCIAL_SHARE_PLATFORM_QQWEIBO           @"qqweibo"
//人人网
#define kBD_SOCIAL_SHARE_PLATFORM_RENREN            @"renren"
//QQ好友
#define kBD_SOCIAL_SHARE_PLATFORM_QQFRIEND          @"qqfriend"
//微信
#define kBD_SOCIAL_SHARE_PLATFORM_WEIXIN_SESSION    @"weixin_session"
//朋友圈
#define kBD_SOCIAL_SHARE_PLATFORM_WEIXIN_TIMELINE   @"weixin_timeline"
//邮件
#define kBD_SOCIAL_SHARE_PLATFORM_EMAIL             @"email"
//短信
#define kBD_SOCIAL_SHARE_PLATFORM_SMS               @"sms"
