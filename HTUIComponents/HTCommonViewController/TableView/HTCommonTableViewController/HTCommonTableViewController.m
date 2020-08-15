//
//  HTCommonTableViewController.m
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/16.
//  Copyright © 2019 HT. All rights reserved.
//

#import "HTCommonTableViewController.h"
#import "NSObject+RACKVOWrapper.h"
#import "HTCommonTableView.h"


@interface HTCommonTableViewController ()

/**
 vm
 */
@property(nonatomic, readwrite, strong)HTCommonTableViewModel *vm;

@end

@implementation HTCommonTableViewController
@synthesize tableView = _tableView;

#pragma mark - life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupMainView];
    [self bindViewModel];
    [self refreshConfig];
}

- (void)p_setupMainView {
    self.tableView = [[HTCommonTableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:self.vm.style cellClassNames:self.vm.classNames delegateTarget:self];
    self.tableView.showsVerticalScrollIndicator = false;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    if (self.vm.contentInset.top != 0 || self.vm.contentInset.left != 0 || self.vm.contentInset.bottom != 0 || self.vm.contentInset.right != 0) {
        self.tableView.contentInset = self.vm.contentInset;
    }
}

// 设置空提示页
- (UIView *)setupEmptyView {
    //    self.emptyView.frame = self.tableView.bounds;
    //    [self.tableView addSubview:self.emptyView];
    //    self.emptyView.hidden = true;

    
    if (self.vm.emptyIconPath.hasValue) {
            return  [[HTCommonEmptyView alloc] initWithEmptyIconPath:self.vm.emptyIconPath emptyTips:self.vm.emptyTips font:self.vm.emptyTipsFont textColor:self.vm.emptyTipsColor interval:self.vm.emptyInterval offset:self.vm.emptyOffset];
    }else {
        UIView *view = [[UIView alloc] init];
        view.hidden = true;
       return view;
    }
}

// 监听ViewModel模型
- (void)bindViewModel
{
    @weakify(self);
    [self.vm rac_observeKeyPath:@"data" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        @strongify(self);
        self.tableView.mj_footer.hidden = false;
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        // 旧值
        NSMutableArray *oldValue = change[@"old"];
        if (![oldValue isKindOfClass:[NSArray class]]) {
            oldValue = [NSMutableArray array];
        }
        
        // 新值
        NSMutableArray *newValue = change[@"new"];
        if (![newValue isKindOfClass:[NSArray class]]) {
            newValue = [NSMutableArray array];
        }
        
        

        // 如果允许上拉加载，且没有尾部刷新
        if (self.vm.canPullUp && !self.tableView.mj_footer) {
            @weakify(self);
            // 那么添加尾部刷新
            [self.tableView ht_addFooterRefresh:^(MJRefreshAutoNormalFooter *footer) {
                // 加载上拉刷新的数据
                @strongify(self);
                [self footerRefresh];
            }];
        }

        // 如果数量小于一页的数量那么隐藏上拉,否则添加footer
        if (newValue.count < self.vm.pageSize) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        // 上拉刷新
        if (self.vm.page != 1) {
            NSMutableArray *data1 = [[oldValue arrayByAddingObjectsFromArray:newValue] mutableCopy];
            self.vm.data2 = data1;
        }else {
            self.vm.data2 = newValue;
        }
        
     
        
        // 刷新数据
        [self reloadData];
    }];
    
    // 刷新信号
    [self.vm.refreshSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self reloadData];
    }];
}

// 是否显示空数据视图
- (void)showOrHideEmptyView:(BOOL)result {
    // 没有设置空视图
    if ([self.emptyView isMemberOfClass:[UIView class]]) {
        self.tableView.mj_footer.hidden = false;
        self.emptyView.hidden = true;
        return;
    }
    
    self.emptyView.hidden = result;
    
    
    // 如果显示空视图且没有数据
    if (!result && !self.vm.data.count) {
        self.tableView.mj_footer.hidden = true;
    }else {
        self.tableView.mj_footer.hidden = false;
    }
}

// 刷新事件
- (void)reloadData {
    [self.tableView reloadData];

}


#pragma mark - 上下拉刷新事件
// 添加加载和刷新控件
- (void)refreshConfig {
    // 下拉刷新
    @weakify(self);
    if (self.vm.canPulldown && !self.tableView.mj_header) {
        [self.tableView ht_addHeaderRefresh:^(MJRefreshNormalHeader * _Nonnull header) {
            /// 加载下拉刷新的数据
             @strongify(self);
             [self headerRefresh];
        }];
        
        if (self.vm.autoFirstRefresh) {
            if (self.vm.firtTimeQuiet) {
               [self headerRefresh];
            }else {
               [self.tableView.mj_header beginRefreshing];
            }
        }
    }else if(!self.vm.canPulldown){
        // 监听滚动,移动背景墙的
        @weakify(self);
        [RACObserve(self.tableView, contentOffset) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            CGPoint offset = [x CGPointValue];
            if (offset.y < 0) {
                self.tableView.contentOffset = CGPointMake(0, 0);
            }
        }];
    }
    

        // 自动刷新
        if (self.vm.autoFirstRefresh) {
            // 是否是静默刷新,是的话直接执行刷新函数
            if (self.vm.firtTimeQuiet && self.vm.canPullUp) {
                  [self footerRefresh];
             }else {
                  // 否则添加尾部，并执行刷新
               if (self.vm.canPullUp && !self.tableView.mj_footer && !self.vm.canPulldown) {
                   @weakify(self);
                   // 那么添加尾部刷新
                   [self.tableView ht_addFooterRefresh:^(MJRefreshAutoNormalFooter *footer) {
                       // 加载上拉刷新的数据
                       @strongify(self);
                       [self footerRefresh];
                   }];
             }
        }
     }
}

// 下拉事件
- (void)headerRefresh{
    @weakify(self)
    [[[self.vm.fetchDataSourceCommand
       execute:@1]
      deliverOnMainThread]
     subscribeNext:^(NSMutableArray *datas) {
         @strongify(self)
         self.tableView.mj_footer.hidden = true;
         self.vm.page = 1;
         if (![datas isKindOfClass:[NSMutableArray class]] || !datas) {
             datas = [NSMutableArray array];
         }
          self.vm.data = datas;
        
        // 展示或隐藏emptyView提示
        [self showOrHideEmptyView:self.vm.data2.count > 0];
     } error:^(NSError *error) {
         @strongify(self)
         // 如果之前就没值的话赋值改变头部和尾部
         if (!self.vm.data) {
             self.vm.data = [@[] mutableCopy];
         }
         [self.tableView.mj_header endRefreshing];
         
         // 展示或隐藏emptyView提示
         [self showOrHideEmptyView:self.vm.data2.count > 0];
     }];
}

// 上拉事件
- (void)footerRefresh{
    @weakify(self);
    [[[self.vm.fetchDataSourceCommand
       execute:@(self.vm.page + 1)]
      deliverOnMainThread]
     subscribeNext:^(NSMutableArray *datas) {
         @strongify(self)
        self.tableView.mj_footer.hidden = false;
         self.vm.page += 1;
         if (![datas isKindOfClass:[NSMutableArray class]] || !datas) {
             datas = [NSMutableArray array];
         }
          self.vm.data = datas;
        // 展示或隐藏emptyView提示
        [self showOrHideEmptyView:self.vm.data2.count > 0];
     } error:^(NSError *error) {
         @strongify(self);
         // 如果之前就没值的话赋值改变头部和尾部
         if (!self.vm.data) {
             self.vm.data = [@[] mutableCopy];
         }
         [self.tableView.mj_footer endRefreshing];
         // 展示或隐藏emptyView提示
         [self showOrHideEmptyView:self.vm.data2.count > 0];
     }];
}

- (void)startHeaderRefresh {
    [self.tableView.mj_header beginRefreshing];
}

- (void)startFooterRefresh {
    [self.tableView.mj_footer beginRefreshing];
}

#pragma mark - Data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.vm numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.vm itemsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.vm heightOfRow:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self.vm cellIdentiyferWithIndexPath:indexPath]];
    [self configureCell:cell atIndexPath:indexPath tableView:tableView];
    return cell;
}

// 设置cell数据
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
}

//  组头视图
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.vm sectionHeaderHeightOfRow:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.vm sectionHeaderView:section];
}

// 组尾视图
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.vm sectionFooterHeightOfRow:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [self.vm sectionFooterView:section];
}

#pragma mark - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView selectRowAtIndexPath:indexPath animated:false scrollPosition:UITableViewScrollPositionNone];
    [self.vm.didSelectCommand execute:indexPath];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Setter && Getter
- (UIView *)emptyView {
    if (!_emptyView) {
        _emptyView = [self setupEmptyView];
        _emptyView.userInteractionEnabled = false;
        _emptyView.hidden = true;
        [self.tableView addSubview:_emptyView];
        [_emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_W, self.tableView.height));
        }];
    }
    return _emptyView;
}


@end
