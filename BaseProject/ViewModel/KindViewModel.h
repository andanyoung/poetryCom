//
//  KindViewModel.h
//  BaseProject
//
//  Created by tarena on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
@class KindModel;

@interface KindViewModel : BaseViewModel
@property (nonatomic) NSInteger rowNumber;

- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)detailForRow:(NSInteger)row;
- (KindModel *)kindModelForRow:(NSInteger)row;
- (BOOL)removeKindForRow:(NSInteger)row;

@property (nonatomic, strong) NSArray *kinds;
@end
