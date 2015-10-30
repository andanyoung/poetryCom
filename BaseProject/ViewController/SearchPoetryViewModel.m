//
//  SearchPoetryViewModel.m
//  BaseProject
//
//  Created by tarena on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "SearchPoetryViewModel.h"
#import "PoetryModel.h"

@implementation SearchPoetryViewModel
- (NSArray *)poetryList{
    if (_searchStr==nil||_searchStr.length==0) {
        return nil;
    }
    return [PoetryModel PoetryListWithSearchStr:_searchStr];
}
@end
