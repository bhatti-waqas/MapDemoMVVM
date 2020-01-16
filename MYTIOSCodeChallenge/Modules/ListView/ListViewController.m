//
//  ListViewController.m
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 16/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

#import "ListViewController.h"
#import "ListViewCell.h"
#import "ListViewModel.h"
#import "MYTIOSCodeChallenge-Swift.h"

@interface ListViewController () <ListViewModelDelegate>
@property(nonatomic,weak) UIActivityIndicatorView *activitiIndicator;
@property(nonatomic,strong) ListViewModel *viewModel;
@end

@implementation ListViewController

+ (UIViewController *)createWith:(ListViewModel *)listViewModel {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListViewController *listView = [storyBoard instantiateViewControllerWithIdentifier:@"ListViewController"];
    listViewModel.delegate = listView;
    listView.viewModel = listViewModel;
    return [[UINavigationController alloc] initWithRootViewController:listView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    [self setupIndicator];
    [self setupPullToRefresh];
    [self.activitiIndicator startAnimating];
    [self.viewModel load];
}

- (void)setupPullToRefresh {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

- (void)refreshTable {
    [self.refreshControl endRefreshing];
    [self.viewModel load];
}

- (void)setupIndicator {
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activitiIndicator = indicator;
    [self.tableView setBackgroundView:indicator];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel getNumberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ListViewCell";
    ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    ListCellViewModel *cellViewModel = [self.viewModel getListCellViewModelAt:indexPath.row];
    [cell configureWith:cellViewModel];
    return cell;
}

#pragma mark - ListViewModel Delegates

- (void)onListViewModelError:(nonnull NSError *)error {
    [self.activitiIndicator stopAnimating];
    [AlertHandler showError:self error:error];
}

- (void)onListViewModelReady {
    [self.activitiIndicator stopAnimating];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleSingleLine];
    [self.tableView reloadData];
}

@end
