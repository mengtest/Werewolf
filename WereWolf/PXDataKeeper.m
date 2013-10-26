//
//  PXDataKeeper.m
//  WereWolf
//
//  Created by Mango on 13-10-26.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import "PXDataKeeper.h"

@implementation PXDataKeeper

- (id)init
{
    self = [super init];
    if (self) {
        _nameArray = [[NSMutableArray alloc]init];
    }
    return self;
}

+ (PXDataKeeper*)sharedInstance
{
    static PXDataKeeper * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[PXDataKeeper alloc]init];
    });
    return _sharedInstance;
}

- (void)addObject:(NSString *)string
{
    [self.nameArray addObject:string];
}

-(NSString *)getPath
{
    NSArray * pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * doucumentPath = [pathArray objectAtIndex:0];
    NSString * path = [doucumentPath stringByAppendingPathComponent:@"saveData.data"];
    return path;
}

-(BOOL)saveData
{
    NSString * path = [self getPath];
    return [NSKeyedArchiver archiveRootObject:self.nameArray toFile:path];
}

-(void)getData
{
    NSString * path = [self getPath];
    if ([NSKeyedUnarchiver unarchiveObjectWithFile:path])
    {
        self.nameArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
}
@end
