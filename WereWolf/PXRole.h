//
//  PXRole.h
//  WereWolf
//
//  Created by 朱泌丞 on 13-10-25.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXRole : NSObject
@property NSInteger tag;
@property NSString *name;
@property PXRoleType type;
@property PXRoleStatus status;
@property PXRoleType life;
-(id)initRoleWithRoleType:(NSInteger)type andTag:(NSInteger)tag;
@end
