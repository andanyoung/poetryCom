//
//  BaseModel.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

MJCodingImplementation

+ (FMDatabase *)defaultDatabase{
    static FMDatabase *db = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /**
         *  数据库初始化 获取数据库路径
         */
        //iOS 9.1 ，貌似是真机不支持读取Document路径，需要改为Library
        //模拟器支持Document 不支持Library
        NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        docPath = [docPath stringByAppendingPathComponent:@"sqlite.db"];
        db = [FMDatabase databaseWithPath:docPath];
    });
    //在使用之前，要打开数据库
    [db open];
    return db;
}
@end
