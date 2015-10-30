//
//  ShiListViewController.m
//  BaseProject
//
//  Created by tarena on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ShiListViewController.h"
#import "PoetryViewModel.h"
#import "PoetryViewController.h"


@implementation PoetryCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}


@end

@interface ShiListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong)PoetryViewModel *poetryVM;
@end

@implementation ShiListViewController

- (instancetype)initWithKind:(NSString *)kind{
    if (self = [super init]) {
        _kind = kind;
    }
    return self;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];//多于行不显示
        [_tableView registerClass:[PoetryCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}

- (PoetryViewModel *)poetryVM{
    if (!_poetryVM) {
        _poetryVM = [[PoetryViewModel alloc]initWithKind:_kind];
    }
    return _poetryVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.title = _kind;
}

#pragma mark - UITableView 

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除此诗";
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == 1) {
        [[UIAlertView bk_showAlertViewWithTitle:[self.poetryVM titleForRow:indexPath.row] message:@"确定删除" cancelButtonTitle:@"点错了" otherButtonTitles:@[@"去意已决"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if(buttonIndex == 1){
                if ([self.poetryVM removePoetryForRow:indexPath.row]) {
                    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }
        } ]show];
    }else{
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.poetryVM.poetryList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PoetryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.poetryVM titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self.poetryVM authorForRow:indexPath.row];
    cell.accessoryType = 1;
    return cell;
}

kRemoveCellSeparator

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PoetryViewController *vc =[[PoetryViewController alloc]initWithShi:[self.poetryVM shiForRow:indexPath.row] intro:[self.poetryVM shiIntroForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
    vc.title = [self.poetryVM shiForRow:indexPath.row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
