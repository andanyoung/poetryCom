//
//  KindViewModel.m
//  BaseProject
//
//  Created by tarena on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "KindViewModel.h"
#import "KindModel.h"

@implementation KindViewModel
- (NSInteger)rowNumber{
    return self.kinds.count;
}

- (NSArray *)kinds{
    return [KindModel kinds];
}

- (KindModel *)kindModelForRow:(NSInteger)row{
    return self.kinds[row];
}

- (NSString *)titleForRow:(NSInteger)row{
    return [self kindModelForRow:row].kind;
}

- (NSString *)detailForRow:(NSInteger)row{
    return [self kindModelForRow:row].introKind;
}

- (BOOL)removeKindForRow:(NSInteger)row{
    return [[self kindModelForRow:row] removeKind];
}

@end
