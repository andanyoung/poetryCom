//
//  PoetryViewModel.m
//  BaseProject
//
//  Created by tarena on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "PoetryViewModel.h"
#import "PoetryModel.h"

@implementation PoetryViewModel
- (instancetype)initWithKind:(NSString *)kind{
    if (self = [super init]) {
        _kind = kind;
    }
    return self;
}

- (NSArray *)poetryList{
    return [PoetryModel poetryListWithKind:_kind];
}

- (PoetryModel *)poetryModelForRow:(NSInteger)row{
    return self.poetryList[row];
}

- (NSString *)titleForRow:(NSInteger)row{
    return [self poetryModelForRow:row].title;
}

- (NSString *)authorForRow:(NSInteger)row{
    return [self poetryModelForRow:row].author;
}

- (NSString *)shiForRow:(NSInteger)row{
    return [self poetryModelForRow:row].shi;
}

- (NSString *)shiIntroForRow:(NSInteger)row{
    return [self poetryModelForRow:row].introshi;
}

- (BOOL)removePoetryForRow:(NSInteger)row{
    return [[self poetryModelForRow:row] removePoetry];
}

-(NSInteger)rowNumber{
    return self.poetryList.count;
}

@end
