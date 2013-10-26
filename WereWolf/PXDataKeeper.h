//
//  PXDataKeeper.h
//  WereWolf
//
//  Created by Mango on 13-10-26.
//  Copyright (c) 2013年 朱泌丞. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PXDataKeeper : NSObject
@property (nonatomic,strong) NSMutableArray *nameArray;

+ (PXDataKeeper*)sharedInstance;
- (void)addObject:(NSString*)string;
- (BOOL)saveData;
- (void)getData;

@end
