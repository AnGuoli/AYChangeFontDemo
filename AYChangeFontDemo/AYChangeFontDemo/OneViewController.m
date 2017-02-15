//
//  OneViewController.m
//  FontTest
//
//  Created by hl on 17/1/3.
//  Copyright © 2017年 hl. All rights reserved.
//

#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height


#import "OneViewController.h"
#import "FontViewController.h"
#import "AYBaseLabel.h"
#import "AYFontManager.h"

@interface OneViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation OneViewController
static NSString * const HLBasicCellID = @"HLBasicCellID";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    tableView.backgroundColor = self.view.backgroundColor;
    
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    footView.backgroundColor = [UIColor cyanColor];
    AYBaseLabel *footlabel = [[AYBaseLabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    footlabel.text = @"一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九";
//    footlabel.fontSize = 9;
    [footView addSubview:footlabel];
    
    self.tableView.tableFooterView = footView;
}

#pragma mark - UITableViewDelegate和UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat sizeScale = [AYFontManager sharedManager].size;
    CGFloat tempCellHeight = 17*sizeScale + 14*sizeScale + 12 + 30;
    CGFloat cellHeight = tempCellHeight > 60 ? tempCellHeight : 60;
    return cellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FontViewController *twoVC = [[FontViewController alloc] init];
    [self.navigationController pushViewController:twoVC animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        //从重用队列里面取
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HLBasicCellID];
        
        if (nil == cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:HLBasicCellID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        NSString *imageName = nil;
        
        switch (indexPath.row) {
            case 0:
            {
                imageName = @"list-icon-01";
                break;
            }
            case 1:
            {
                imageName = @"list-icon-02";
                break;
            }
            case 2:
            {
                imageName = @"list-icon-03";
                break;
            }
            case 3:
            {
                imageName = @"list-icon-04";
                break;
            }
            default:
                break;
        }
        
        cell.imageView.image = [UIImage imageNamed:imageName];
        cell.textLabel.text = @"一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九";
        cell.detailTextLabel.text = @"一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九";
    
    CGFloat sizeScale = [AYFontManager sharedManager].size;
    cell.textLabel.font = [UIFont systemFontOfSize:17*sizeScale];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14*sizeScale];

        return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
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
