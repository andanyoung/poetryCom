//
//  KindModel.m
//  BaseProject
//
//  Created by tarena on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "KindModel.h"

@implementation KindModel
- (BOOL)removeKind{
    FMDatabase *db = [KindModel defaultDatabase];
    BOOL success = [db executeUpdateWithFormat:@"delete  from t_kind where D_KIND = %@",_kind];
    [db close];
    return success;
}

/**
 *  从数据库中获取t_kind表中的所有数据
 *
 */
+ (NSArray *)kinds{
    FMDatabase *db = [self defaultDatabase];
    FMResultSet *rs = [db executeQuery:@"select * from t_kind"];
    
    NSMutableArray *dataArr = [NSMutableArray new];
    while ([rs next]) {
        KindModel *model = [self new];
        model.kind = [rs stringForColumn:@"D_KIND"];
        model.num = [rs longForColumn:@"D_NUM"];
        model.introKind = [rs stringForColumn:@"D_INTROKIND"];
        model.introKind2 = [rs stringForColumn:@"D_INTROKIND2"];
        
        [dataArr addObject:model];
    }
    //释放掉搜索出来的内容
    [db closeOpenResultSets];
    [db close];
    return [dataArr copy];
}
@end
