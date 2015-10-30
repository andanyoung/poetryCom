//
//  PoetryModel.h
//  BaseProject
//
//  Created by tarena on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface PoetryModel : BaseModel
@property (nonatomic, strong) NSString *shi;
@property (nonatomic, strong) NSString *kind;
@property (nonatomic, strong) NSString *introshi;
@property (nonatomic, strong) NSString *title;
@property (nonatomic) long ID;
@property (nonatomic, strong) NSString *author;

+ (NSArray *)poetryListWithKind:(NSString *)kind;

- (BOOL)removePoetry;

/**
 *  通过字符串，搜索 诗名或者作者包含此字符串的诗
 */
+ (NSArray *)PoetryListWithSearchStr:(NSString *)searchStr;
@end
