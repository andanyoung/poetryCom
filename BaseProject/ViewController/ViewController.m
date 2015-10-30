//
//  ViewController.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ViewController.h"
#import "KindViewModel.h"
#import "KindIntronViewController.h"
#import "ShiListViewController.h"
#import "SearchPoetryViewModel.h"
#import "PoetryViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) SearchPoetryViewModel *searchPoetryVM;
@property (nonatomic, strong) KindViewModel *kindVM;

@end

@implementation ViewController

- (SearchPoetryViewModel *)searchPoetryVM{
    if (!_searchPoetryVM) {
        _searchPoetryVM = [SearchPoetryViewModel new];
    }
    return _searchPoetryVM;
}
- (KindViewModel *)kindVM{
    if (!_kindVM) {
        _kindVM = [KindViewModel new];
    }
    return _kindVM;
}

#pragma mark - UISearchBarDelegate
//搜索栏内容有更改时触发
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchPoetryVM.searchStr = searchText ;
    [self.searchDisplayController.searchResultsTableView reloadData];
}

#pragma mark - UITableView

//某行是否支持编辑状态
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView == _tableView;
}


#pragma mark - tableViewEdit

// Allows customization of the editingStyle for a particular（详细的） cell located at 'indexPath'. If not implemented（执行）, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
//某行的编辑状态
- (UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除此诗集";
}
// supercedes（取代） -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"editAction1" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了editAction1");
    }];
    
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"editAction2" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了editAction2");
    }];
    action2.backgroundColor = [UIColor grayColor];
    return @[action1,action2];
}
//当编辑操作出触发后，做什么
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle== UITableViewCellEditingStyleDelete) {
        if (editingStyle==UITableViewCellEditingStyleDelete) {
            
            [[UIAlertView bk_showAlertViewWithTitle:[self.kindVM titleForRow:indexPath.row] message:@"确定要删除此诗集吗？" cancelButtonTitle:@"点错了" otherButtonTitles:@[@"心意已决"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex==1) {
                    if([self.kindVM removeKindForRow:indexPath.row]){
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                }
            }] show];
            
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableView == _tableView ? self.kindVM.rowNumber:self.searchPoetryVM.rowNumber;
}

kRemoveCellSeparator
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (_tableView != tableView) {
        //如果是搜索界面
        cell.textLabel.text = [self.searchPoetryVM titleForRow:indexPath.row];
        cell.detailTextLabel.text = [self.searchPoetryVM authorForRow:indexPath.row];
        return cell;
    }
    UILabel *titleLb = (UILabel *)[cell.contentView viewWithTag:100];
    UIButton *button = (UIButton *)[cell.contentView viewWithTag:200];
    titleLb.text = [self.kindVM titleForRow:indexPath.row];
    button.hidden = [[self.kindVM detailForRow:indexPath.row]  isEqualToString: @""];
    button.layer.cornerRadius = 10;
    
    //为了防止cell从用，导致多次给按钮添加点击监听事件操作
    [button bk_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
    [button bk_addEventHandler:^(id sender) {
        KindIntronViewController *vc = [KindIntronViewController new];
        vc.intronKind = [self.kindVM detailForRow:indexPath.row];
        
        [self.navigationController pushViewController:vc animated:YES];
        vc.title = titleLb.text;
    } forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView != _tableView) {
        PoetryViewController *vc = [[PoetryViewController alloc]initWithShi:[self.searchPoetryVM shiForRow:indexPath.row] intro:[self.searchPoetryVM shiIntroForRow:indexPath.row]];
        [self.navigationController pushViewController:vc animated:YES];
        vc.title = [self.searchPoetryVM shiForRow:indexPath.row];
        self.searchPoetryVM = nil;
        return;
    }
    
    ShiListViewController *vc = [[ShiListViewController alloc]initWithKind:[self.kindVM titleForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.tableFooterView = [UIView new];//取出脚部空白的cell
    //向搜索列表中注册cell
    [self.searchDisplayController.searchResultsTableView registerClass:[PoetryCell class] forCellReuseIdentifier:@"Cell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
