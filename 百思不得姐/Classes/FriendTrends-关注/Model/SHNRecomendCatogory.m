//
//  SHNRecomendCatogory.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/2/28.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNRecomendCatogory.h"

@implementation SHNRecomendCatogory
- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
