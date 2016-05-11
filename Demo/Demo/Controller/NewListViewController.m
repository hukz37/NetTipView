//
//  NewListViewController.m
//  Demo
//
//  Created by hukezhu on 16/5/10.
//  Copyright © 2016年 hukezhu. All rights reserved.
//

#import "NewListViewController.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "AFNetWorking.h"
#import "UIImageView+AFNetworking.h"
#import "NewData.h"
#import "DetailViewController.h"
#import "NetTipView.h"

@interface NewListViewController ()
/** 模型数组*/
@property (nonatomic,strong)NSMutableArray *dataList;

/** 记录请求数据的个数,上拉记载使用*/
@property (nonatomic,assign)NSUInteger index;

@end

@implementation NewListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.title = @"新闻列表";
    self.tableView.rowHeight = 70;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden = YES;
    [self.tableView.mj_header beginRefreshing];
    
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    if (manager.isReachable) {
        [self.view hideNetTipView];
    }else{
    
        __weak NewListViewController *weakSelf = self;
        [self.view showNetTipViewWithToDoBlock:^{
            [weakSelf loadData];
        }];
    }
    
}


#pragma mark lazy method

-(NSMutableArray *)dataList{

    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}
#pragma mark GetDataMethod

- (void)loadData{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager GET:@"http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [self.tableView.mj_header endRefreshing];
             
             [self.dataList removeAllObjects];
             [self.view hideNetTipView];
             self.index = 20;
             
              NSArray *dictArray = responseObject[@"T1348647853363"];
              self.dataList = [NewData mj_objectArrayWithKeyValuesArray:dictArray];
             
             [self.tableView reloadData];
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             [self.tableView.mj_header endRefreshing];

             NSLog(@"%@",error);
             
         }];
}

- (void)loadMoreData{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager GET:[NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348647853363/%zd-%zd.html",self.index,self.index + 20 ] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [self.tableView.mj_header endRefreshing];
             
             self.index += 20;
             NSMutableArray *tempArray = [NewData mj_objectArrayWithKeyValuesArray:responseObject[@"T1348647853363"]];
             if (tempArray.count == 0) {
                 
             }
             
             [self.dataList addObjectsFromArray:tempArray];
             [self.tableView reloadData];
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);
             
         }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    self.tableView.mj_footer.hidden = self.dataList.count>0?NO:YES;
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"news"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"news"];
    }
    //当前数据模型
    NewData *newData = self.dataList[indexPath.row];
    //标题
    cell.textLabel.text = newData.title;
    //副标题
    cell.detailTextLabel.text = newData.digest;
    //缩略图片
    [cell.imageView setImageWithURL:[NSURL URLWithString:newData.imgsrc]];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

     NewData *newData = self.dataList[indexPath.row];
    DetailViewController *detailVc = [[DetailViewController alloc]init];
    if (newData.url.length == 0) {
        return;
    }
    detailVc.urlString = newData.url;
    [self.navigationController pushViewController:detailVc animated:YES];
}
@end
