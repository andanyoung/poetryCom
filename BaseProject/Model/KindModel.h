//
//  KindModel.h
//  BaseProject
//
//  Created by tarena on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface KindModel : BaseModel

@property (nonatomic, strong) NSString *kind;
@property (nonatomic) long num;
@property (nonatomic, strong) NSString *introKind;
@property (nonatomic, strong) NSString *introKind2;

/**
 *  删除当前数据
 */
- (BOOL)removeKind;
+ (NSArray *)kinds;
@end
