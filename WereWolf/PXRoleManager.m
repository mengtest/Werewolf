//
//  PXRoleManager.m
//  WereWolf
//
//  Created by 朱泌丞 on 13-10-25.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import "PXRoleManager.h"
#import "PXRole.h"
#import "PXStoryViewController.h"
static PXRoleManager *instance = nil;

@interface PXRoleManager()
{
    BOOL _witchIsChosen;
    BOOL _gurafIsChosen;
    BOOL _cupidIsChosen;
    BOOL _predictIsChosen;
    BOOL _hunterIsChosen;
    BOOL _girlIsChosen;
}

@end
@implementation PXRoleManager
+(id)defaultManager
{
    @synchronized (self){
        if (instance == nil) {
            NSArray *specialRole = @[[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO]];
            instance = [[PXRoleManager alloc] initWithSumNum:8 andPeopleNum:3 andWolfNum:2 andSpecialRoles:specialRole];
        }
    }
    return instance;
}
-(id)initWithSumNum:(NSInteger)sumNum andPeopleNum:(NSInteger)peopleNum andWolfNum:(NSInteger)wolfNum andSpecialRoles:(NSArray *)specialRoles
{
    instance = [super init];
    if (instance) {
    }
    self.isFirstStory = YES;
    self.sumNum = sumNum;
    self.peopleNum = peopleNum;
    self.wolfNum = wolfNum;
    _witchIsChosen = [[specialRoles objectAtIndex:0] boolValue];
    _gurafIsChosen = [[specialRoles objectAtIndex:1] boolValue];
    _cupidIsChosen = [[specialRoles objectAtIndex:2] boolValue];
    _predictIsChosen = [[specialRoles objectAtIndex:3] boolValue];
    _hunterIsChosen = [[specialRoles objectAtIndex:4] boolValue];
    _girlIsChosen = [[specialRoles objectAtIndex:5] boolValue];
    [self createRolesWithSpecialRoles:specialRoles];
    return instance;
}

-(void)createRolesWithSpecialRoles:(NSArray *)specialRoles
{
    int tag = 0;
    self.roles = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.wolfNum; i++) {
        PXRole *role = [[PXRole alloc] initRoleWithRoleType:PXRoleTypeWolf andTag:tag++];
        [self.roles addObject:role];
    }
    for (int i = 0 ; i < self.peopleNum; i++) {
        PXRole *role = [[PXRole alloc] initRoleWithRoleType:PXRoleTypePeople andTag:tag++];
        [self.roles addObject:role];
    }
    int type = 2;
    for (NSNumber *specialRole in specialRoles) {
        if ([specialRole boolValue]) {
            PXRole *role = [[PXRole alloc] initRoleWithRoleType:type andTag:tag++];
            [self.roles addObject:role];
        }
        type++;
    }
    
}
-(NSString *)description
{
    return  [NSString stringWithFormat:@"%@",self.roles];
}
-(PXStoryType)getNextStoryTypeFromCurrentType:(PXStoryType)currentType
{
    PXStoryType storyType = 4;
    
    switch (currentType) {
        case PXStoryTypeStart:{
            if (_predictIsChosen) {
                storyType = PXStoryTypePredict;
            }
            if (_gurafIsChosen) {
                storyType = PXStoryTypeGuard;
            }
            if (_cupidIsChosen&&self.isFirstStory) {
                storyType =  PXStoryTypeCupid;
                self.isFirstStory = NO;
            }
            break;
        }
        case PXStoryTypeCupid:{
            if (_predictIsChosen) {
                storyType = PXStoryTypePredict;
            }
            if (_gurafIsChosen) {
                storyType =  PXStoryTypeGuard;
            }
            break;
        }
        case PXStoryTypeGuard:{
            if (_predictIsChosen) {
                storyType = PXStoryTypePredict;
            }
            break;
        }
        case PXStoryTypeWolf:{
            storyType = PXStoryTypePeople;
            if (_witchIsChosen) {
                storyType = PXStoryTypeWitch;
            }
            break;
        }
        case PXStoryTypeWitch:{
            storyType = PXStoryTypePeople;
            break;
        }
        case PXStoryTypePeople:{
            if (_predictIsChosen) {
                storyType = PXStoryTypePredict;
            }
            if (_gurafIsChosen) {
                storyType = PXStoryTypeGuard;
            }
            break;
        }
        default:
            break;
    }
    NSLog(@"\ncurrentType:%d\nnextType:%d\n%@",currentType,storyType,self);
    return storyType;
}
-(PXRoleType)getRoleTypeWithTag:(NSInteger)tag
{
    PXRole *role = [self.roles objectAtIndex:tag];
    PXRoleType type = role.type;
    return type;
}
-(PXRoleStatus)getRoleStatusWithTag:(NSInteger)tag
{
    PXRole *role = [self.roles objectAtIndex:tag];
    PXRoleStatus status = role.status;
    return status;
}
-(void)changeRoleTag:(NSInteger)tag ToStatus:(PXRoleStatus)status
{
    PXRole *role = [self.roles objectAtIndex:tag];
    role.status = status;
}
@end



