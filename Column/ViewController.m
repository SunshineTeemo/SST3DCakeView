//
//  ViewController.m
//  Column
//
//  Created by 梅琰培 on 2016/12/28.
//  Copyright © 2016年 梅琰培. All rights reserved.
//

#import "ViewController.h"
#define PhoneScreen_HEIGHT [UIScreen mainScreen].bounds.size.height
#define PhoneScreen_WIDTH [UIScreen mainScreen].bounds.size.width
#define RGBColorMaker(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#import "SSSolidCakeView.h"

@interface ViewController ()
//数据数组
@property(nonatomic,strong) NSMutableArray *dataArray;
//颜色数组
@property(nonatomic,copy) NSArray *colorArray;
//名字数组
@property(nonatomic,copy) NSArray *nameArray;
@property(nonatomic,strong) SSSolidCakeView *solidCakeView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self storeData];

    [self loadSolidCakeView];
    
}

#pragma mark 数据存储
-(void)storeData{
    
    NSArray *startArray = @[@"0.1",@"0.2",@"0.3",@"0.25",@"0.15"];
    self.dataArray = [NSMutableArray arrayWithArray:startArray];
    self.colorArray = @[RGBColorMaker(140, 233, 253, 1),RGBColorMaker(254, 246, 140, 1),RGBColorMaker(148, 199, 11, 1),RGBColorMaker(252, 139, 156, 1),RGBColorMaker(253, 208, 140, 1)];
    self.nameArray = @[@"提莫",@"璐璐",@"妖姬",@"狐狸",@"锐雯"];
    
    //更改数据的button
    UIButton *dataChangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dataChangeButton addTarget:self action:@selector(changeData:) forControlEvents:UIControlEventTouchUpInside];
    [dataChangeButton setTitle:@"更改数据" forState:UIControlStateNormal];
    [dataChangeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dataChangeButton setBackgroundImage:[UIImage imageNamed:@"屏幕快照 2016-12-28 上午11.05.06"] forState:UIControlStateNormal];
    [dataChangeButton setBackgroundImage:[UIImage imageNamed:@"屏幕快照 2016-12-28 上午11.05.06"] forState:UIControlStateHighlighted];

    
    dataChangeButton.frame = CGRectMake(PhoneScreen_WIDTH-100, 20, 100, 80);
    dataChangeButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:dataChangeButton];
}

#pragma mark 加载自己封装的视图
- (void)loadSolidCakeView
{
    self.solidCakeView = [[SSSolidCakeView alloc]init];
    self.solidCakeView.dataArray = _dataArray;
    self.solidCakeView.colorArray = _colorArray;
    self.solidCakeView.nameArray = _nameArray;
    self.solidCakeView.cakeCenter = CGPointMake(150, 200);
    self.solidCakeView.cakeRadius = 100;
    self.solidCakeView.cakeHeight = 30;
    self.solidCakeView.xScale = 1;
    self.solidCakeView.yScale = 0.8;
    self.solidCakeView.backgroundColor = [UIColor whiteColor];
    self.solidCakeView.frame = CGRectMake(0, 0, PhoneScreen_WIDTH-100, PhoneScreen_HEIGHT-20);
    [self.view addSubview:self.solidCakeView];

    
}
#pragma mark 数据更改button方法
- (void)changeData:(UIButton*)button
{
//    self.dataArray = [[NSMutableArray alloc]init];
    CGFloat dataSum = 0 ;
    NSMutableArray *randomArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<_dataArray.count; i++) {
        // 取0-1000的随机数
        CGFloat eachNumber = arc4random()%1000;
        //求和
        dataSum = dataSum + eachNumber;
        [randomArray addObject:[NSString stringWithFormat:@"%0.f",eachNumber]];
    }
    self.dataArray = [[NSMutableArray alloc]init];

    for (NSString *dataString in randomArray) {
        //求百分比
        CGFloat data = [dataString floatValue];
        CGFloat dataPrecent = data/dataSum;
        //将计算的百分比放在数组中
        [self.dataArray addObject:[NSString stringWithFormat:@"%0f",dataPrecent]];
//                NSLog(@"%0f",dataPrecent);
        
    }
    self.solidCakeView.dataArray = _dataArray;
//    self.circleView.dataArray = _postHeightArray;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
