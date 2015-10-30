//
//  PoetryModel.m
//  BaseProject
//
//  Created by tarena on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "PoetryModel.h"


@implementation PoetryModel
//把搜索结果FMResultSet类型转换为 包含potryModel的数据类型
+ (NSArray *)rsTOPortyList:(FMResultSet *)rs{
    NSMutableArray *dataArr = [NSMutableArray new];
    while ([rs next]) {
        PoetryModel *model = [PoetryModel new];
        model.kind = [rs stringForColumn:@"D_KIND"];
        model.shi = [rs stringForColumn:@"D_SHI"];
        model.introshi = [rs stringForColumn:@"D_INTROSHI"];
        model.ID = [rs longForColumn:@"D_ID"];
        model.title = [rs stringForColumn:@"D_TITLE"];
        model.author = [rs stringForColumn:@"d_author"];
        [dataArr addObject:model];
    }
   
    return [dataArr copy];
}

+ (NSArray *)PoetryListWithSearchStr:(NSString *)searchStr{
    FMDatabase *db = [self defaultDatabase];
    //SQL 语句 通配符 ss--> %ss%
    //如果要在format中输入%，需要转义符
    searchStr =[NSString stringWithFormat:@"%%%@%%",searchStr];
    FMResultSet *rs = [db executeQueryWithFormat:@"select * from T_SHI where d_title like %@ or d_author like %@",searchStr,searchStr];
    NSArray *dataArr = [self rsTOPortyList:rs];
     [db close];
    return dataArr;
}

- (BOOL)removePoetry{
    FMDatabase *db = [PoetryModel defaultDatabase];
    BOOL success = [db executeUpdateWithFormat:@"delete from t_shi where d_id =  %ld",_ID];
    [db close];
    return success;
}

+(NSArray *)poetryListWithKind:(NSString *)kind{
    FMDatabase *db = [self defaultDatabase];
    //如果数据库需要传参
    FMResultSet *rs = [db executeQueryWithFormat:@"select * from t_shi where d_kind = %@",kind];
//    NSMutableArray *dataArr = [NSMutableArray new];
//    while ([rs next]) {
//        PoetryModel *model = [self new];
//        model.kind = [rs stringForColumn:@"D_KIND"];
//        model.shi = [rs stringForColumn:@"D_SHI"];
//        model.introshi = [rs stringForColumn:@"D_INTROSHI"];
//        model.ID = [rs longForColumn:@"D_ID"];
//        model.title = [rs stringForColumn:@"D_TITLE"];
//        [dataArr addObject:model];
//    }
    
  NSArray *dataArr = [self rsTOPortyList:rs];
    [db close];
    [db closeOpenResultSets];
    return dataArr;
}
@end
