//
//  PXRoleManager.h
//  WereWolf
//
//  Created by 朱泌丞 on 13-10-25.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXRoleManager : NSObject
@property NSInteger sumNum;
@property NSInteger peopleNum;
@property NSInteger wolfNum;

@property (nonatomic,strong) NSMutableArray *roles;

+(id)defaultManager;
-(id)initWithSumNum:(NSInteger)sumNum andPeopleNum:(NSInteger)peopleNum andWolfNum:(NSInteger)wolfNum andSpecialRoles:(NSArray *)specialRoles;

-(PXStoryType)getNextStoryTypeFromCurrentType:(PXStoryType)currentType;

-(PXRoleType)getRoleTypeWithTag:(NSInteger)tag;


-(void)changeRoleTag:(NSInteger)tag ToStatus:(PXRoleStatus)status;
@end

