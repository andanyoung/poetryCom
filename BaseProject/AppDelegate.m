//
//  AppDelegate.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Category.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initializeWithApplication:application];

    [self copyPoetryDBToDoc];
    return YES;
}


/**
 *  因为要对数据库中的数据进行删除操作，但是app目录下的文件都是只读的
 *   所以我们要复制一份到Document文件加下，以后就都对Document文件夹下的数据库做操作
 */
- (void)copyPoetryDBToDoc{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Poetry" ofType:@"bundle"];
    path = [path stringByAppendingPathComponent:@"sqlite.db"];
    NSLog(@"path:%@",path);
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    docPath = [docPath stringByAppendingPathComponent:@"sqlite.db"];
    NSLog(@"docPath %@",docPath);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:docPath]) {
        [fileManager copyItemAtPath:path toPath:docPath error:nil];
    }
}

@end
