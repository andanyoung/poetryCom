//
//  PoetryViewModel.h
//  BaseProject
//
//  Created by tarena on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
@class PoetryModel;

@interface PoetryViewModel : BaseViewModel
@property (nonatomic) NSInteger rowNumber;
@property (nonatomic, strong) NSArray *poetryList;

- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)authorForRow:(NSInteger)row;
- (NSString *)shiForRow:(NSInteger)row;
- (NSString *)shiIntroForRow:(NSInteger)row;
- (BOOL)removePoetryForRow:(NSInteger)row;

- (instancetype)initWithKind:(NSString *)kind;
@property (nonatomic,strong)NSString *kind;
@end
