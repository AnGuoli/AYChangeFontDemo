//
//  FontViewController.m
//  ChangeFontDemo
//
//  Created by hl on 17/2/14.
//  Copyright © 2017年 ay. All rights reserved.
//

#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height

#import "FontViewController.h"
#import "FontCell.h"
#import "AYFontManager.h"

@interface FontViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *fontTableView;
@property (nonatomic, weak) UISlider *fontSlider;
@property (nonatomic, weak) UIView *bottomView;
@property (nonatomic, weak) UILabel *smallLabel;
@property (nonatomic, weak) UILabel *normalLabel;
@property (nonatomic, weak) UILabel *bigLabel;

@end

@implementation FontViewController
static NSString * const FontCellID = @"FontCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"字体大小";
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];

    UITableView *fontTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    fontTableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:fontTableView];
    fontTableView.delegate = self;
    fontTableView.dataSource = self;
    
    
    // self-sizing(iOS8以后才支持)
    // 设置tableView所有的cell的真实高度是自动计算的(根据设置的约束)
    fontTableView.rowHeight = UITableViewAutomaticDimension;
    // 设置tableView的估算高度
    fontTableView.estimatedRowHeight = 88;
    
    _fontTableView = fontTableView;
    [fontTableView registerNib:[UINib nibWithNibName:NSStringFromClass([FontCell class])bundle:nil] forCellReuseIdentifier:FontCellID];
    
    [self createSlider];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FontCell *cell = [tableView dequeueReusableCellWithIdentifier:FontCellID];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.titleText = @"标准列表文字";
    cell.detailTitleText = @"标准辅助文字";
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"列表文字预览";
}

- (void)createSlider {
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 150 - 64, ScreenWidth, 150)];
    bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView = bottomView;
    
    UILabel *smallLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    [bottomView addSubview:smallLabel];
    smallLabel.text = @"小号";
    CGPoint smallCenter = CGPointMake(30, 50);
    smallLabel.center = smallCenter;
    _smallLabel = smallLabel;
    smallLabel.tag = 1000;
    [self.view addSubview:bottomView];
    
    UILabel *normalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    normalLabel.text = @"标准";
    CGPoint normalCenter = CGPointMake(ScreenWidth/2, 50);
    normalLabel.center = normalCenter;
    _normalLabel = normalLabel;
    normalLabel.tag = 1001;
    [bottomView addSubview:normalLabel];
    
    UILabel *bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    bigLabel.text = @"大号";
    CGPoint bigCenter = CGPointMake(ScreenWidth-30, 50);
    bigLabel.center = bigCenter;
    _bigLabel = bigLabel;
    bigLabel.tag = 1002;
    [bottomView addSubview:bigLabel];
    
    
    for (NSInteger i = 0; i < 3; i ++) {
        UILabel *label = [self.bottomView viewWithTag:i + 1000];
        if (self.fontSlider.value == i) {
            label.textColor = [UIColor blueColor];
        } else {
            label.textColor = [UIColor blackColor];
        }
    }
    
    
    //添加滑动事件
    [self.fontSlider addTarget:self
                        action:@selector(fontSliderValueChanged:)
              forControlEvents:UIControlEventValueChanged];
    //添加点击手势
    [self.fontSlider addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fontSliderTapped:)]];
    
    
}

- (UISlider *) fontSlider {
    if (!_fontSlider) {
        
        UISlider *fontSlider = [[UISlider alloc] initWithFrame:CGRectMake(15,80, CGRectGetWidth(self.view.bounds) - 15 * 2, 44)];
        
        UIImageView *sliderBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30,80 + 22 - 5, CGRectGetWidth(self.view.bounds) - 30 * 2, 5)];
        sliderBackImageView.image = [UIImage imageNamed:@"set-word-img@2x"];
        [self.bottomView addSubview:sliderBackImageView];
        
        [self.bottomView addSubview:fontSlider];
        fontSlider.minimumValue = 0;
        fontSlider.maximumValue = 2;
        
        fontSlider.minimumTrackTintColor = [UIColor clearColor];
        fontSlider.maximumTrackTintColor = [UIColor clearColor];
        
        CGFloat sizeScale = [AYFontManager sharedManager].size;
        if (sizeScale < 1) {
            [fontSlider setValue:0 animated:YES];
        } else if (sizeScale == 1) {
            [fontSlider setValue:1 animated:YES];
        } else {
            [fontSlider setValue:2 animated:YES];
        }
        
        _fontSlider = fontSlider;
    }
    return _fontSlider;
}

- (void)fontSliderValueChanged:(id)sender {
    UISlider *slider = sender;
    //将slider的value+0.5然后取整(向下取整)，那么index只能是0，1，2和3这四个数字了，所以slider只能在这四个位置上跳动
    NSUInteger index = (NSUInteger)(slider.value + 0.5);
    [self sendIndexInSlider:index];
    
    
}

- (void)fontSliderTapped:(UITapGestureRecognizer *)tapGesture {
    CGPoint touchPoint = [tapGesture locationInView:self.fontSlider];
    CGFloat value = (self.fontSlider.maximumValue - self.fontSlider.minimumValue) * (touchPoint.x / self.fontSlider.frame.size.width );
    NSUInteger index = (NSUInteger)(value + 0.5);
    [self sendIndexInSlider:index];
    
}

- (void)sendIndexInSlider:(NSInteger)index {
    [self.fontSlider setValue:index animated:YES];
    if (index == 0) {
        [[NSUserDefaults standardUserDefaults] setObject:@0.9 forKey:@"Mode"];
        [AYFontManager sharedManager].size = 0.9;
        [self fontSliderEndChangedWithSliderIndex:index];
    } else if (index == 1) {
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"Mode"];
        [AYFontManager sharedManager].size = 1;
        [self fontSliderEndChangedWithSliderIndex:index];
    } else if (index == 2) {
        [[NSUserDefaults standardUserDefaults] setObject:@1.1 forKey:@"Mode"];
        [AYFontManager sharedManager].size = 1.1;
        [self fontSliderEndChangedWithSliderIndex:index];
    }

}

- (void)fontSliderEndChangedWithSliderIndex:(NSInteger)index {

    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeFont" object:nil];
    [self.fontTableView reloadData];
    
    for (NSInteger i = 0; i < 3; i ++) {
        UILabel *label = [self.bottomView viewWithTag:i + 1000];
        if (index == i) {
            label.textColor = [UIColor blueColor];
        } else {
            label.textColor = [UIColor blackColor];
        }
    }
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
