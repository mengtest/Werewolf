//
//  PXRole.m
//  WereWolf
//
//  Created by 朱泌丞 on 13-10-25.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import "PXRole.h"

@implementation PXRole

-(id)initRoleWithRoleType:(NSInteger)type andTag:(NSInteger)tag
{
    self = [super init];
    if (self) {
        self.type = type;
        self.tag = tag;
        self.status = PXRoleStatusAlive;
    }
    return self;
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"tag:%d   name:%@   type:%d   status:%d",self.tag,self.name,self.type,self.status];
}
@end
