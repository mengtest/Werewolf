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
        NSLog(@"\ncurrentType:%d\nnextType:%d\n%@",currentType,storyType,self.roles);
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
-(NSString *)getRoleNameWithTag:(NSInteger)tag
{
    PXRole *role = [self.roles objectAtIndex:tag];
    NSString *name = role.name;
    return name;
}
-(void)changeRoleTag:(NSInteger)tag ToStatus:(PXRoleStatus)status
{
    PXRole *role = [self.roles objectAtIndex:tag];
    role.status = status;
    NSLog(@"%@",self.roles);
    if (status == PXRoleStatusDead) {
        PXRoleType type = [self getRoleTypeWithTag:tag];
        switch (type) {
            case PXRoleTypeCupid:
                _cupidIsChosen = NO;
                break;
            case PXRoleTypeGirl:
                _girlIsChosen = NO;
                break;
            case PXRoleTypeHunter:
                _hunterIsChosen = NO;
                break;
            case PXRoleTypePredict:
                _predictIsChosen = NO;
                break;
            case PXRoleTypeGuard:
                _gurafIsChosen = NO;
                break;
            case PXRoleTypeWitch:
                _witchIsChosen = NO;
                break;
            default:
                break;
        }
    }else if(status == PXRoleStatusAlive){
        PXRoleType type = [self getRoleTypeWithTag:tag];
        switch (type) {
            case PXRoleTypeCupid:
                _cupidIsChosen = YES;
                break;
            case PXRoleTypeGirl:
                _girlIsChosen = YES;
                break;
            case PXRoleTypeHunter:
                _hunterIsChosen = YES;
                break;
            case PXRoleTypePredict:
                _predictIsChosen = YES;
                break;
            case PXRoleTypeGuard:
                _girlIsChosen = YES;
                break;
            case PXRoleTypeWitch:
                _witchIsChosen = YES;
                break;
            default:
                break;
        }
    }
}
-(void)changeRoleTag:(NSInteger)tag ToLife:(PXRoleLife)life
{
    PXRole *role = [self.roles objectAtIndex:tag];
    role.life = life;
}
-(void)changeRoleTag:(NSInteger)tag ToName:(NSString *)name
{
    PXRole *role = [self.roles objectAtIndex:tag];
    role.name = name;
}
-(PXGameStatus)getGameStatus
{
    PXGameStatus status = PXGameStatusNormal;
    NSInteger peopleAliveNum = 0;
    NSInteger wolfAliveNum = 0;
    NSInteger cupidNum = 0;
    BOOL isCupidWin = NO;
    [self cleanRoleStatus];
    for (PXRole *role in self.roles) {
        PXRoleStatus status = role.status;
        PXRoleType type = role.type;
        PXRoleLife life = role.life;
        if (status == PXRoleStatusAlive&&type == PXRoleTypeWolf) {
            wolfAliveNum++;
        }
        if (status == PXRoleStatusAlive&&type != PXRoleTypeWolf) {
            peopleAliveNum++;
        }
        if (life == PXRoleLifeCupid&&status == PXRoleStatusAlive) {
            cupidNum++;
            if (type == PXRoleTypeWolf) {
                isCupidWin = YES;
            }
        }
    }
    if (wolfAliveNum == 0) {
        return PXGameStatusPeopleWin;
    }
    if (peopleAliveNum == 0) {
        return PXGameStatusWolfWin;
    }
    if (cupidNum == 2&&isCupidWin) {
        return PXGameStatusCupidWin;
    }
    return status;
}
-(NSArray *)getSuccessRoleTag:(PXGameStatus)status
{
    NSMutableArray *rolesTag = [[NSMutableArray alloc]init];
    if (status == PXGameStatusCupidWin) {
        for (PXRole *role in self.roles) {
            if (role.life == PXRoleLifeCupid) {
                [rolesTag addObject:[NSNumber numberWithInteger:role.tag]];
            }
        }
    }
    if (status == PXGameStatusPeopleWin) {
        for (PXRole *role in self.roles) {
            if (role.type == PXRoleTypeWolf) {
                [rolesTag addObject:[NSNumber numberWithInteger:role.tag]];
            }
        }
    }
    if (status == PXGameStatusWolfWin) {
        for (PXRole *role in self.roles) {
            if (role.type != PXRoleTypeWolf) {
                [rolesTag addObject:[NSNumber numberWithInteger:role.tag]];
                
            }
        }
    }
    return [rolesTag copy];
}
-(void)cleanRoleStatus
{
    BOOL cupidIsDead = NO;
    for (PXRole *role  in self.roles) {
        PXRoleStatus status = role.status;
        PXRoleLife life = role.life;
        if (status == PXRoleStatusDead) {
            if (life == PXRoleLifeCupid) {
                cupidIsDead = YES;
            }
            role.status = PXRoleStatusTotalDead;
        }
        if (status == PXRoleStatusIsGuard) {
            role.status = PXRoleStatusAlive;
        }

    }
    if (cupidIsDead) {
        for (PXRole *role in self.roles) {
            PXRoleLife life = role.life;
            if (life == PXRoleLifeCupid) {
                role.status = PXRoleStatusTotalDead;
            }
        }
    }
}
@end



