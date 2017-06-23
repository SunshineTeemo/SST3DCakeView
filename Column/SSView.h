//
//  SSView.h
//  Column
//
//  Created by 梅琰培 on 2016/12/29.
//  Copyright © 2016年 梅琰培. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSView : UIView
@property(nonatomic,copy) NSArray *dataArray;
@property(nonatomic,copy) NSArray *colorArray;
@property(nonatomic,copy) NSArray *nameArray;
//饼的厚度
@property(nonatomic,assign) CGFloat cakeHeight;
//饼的中心位置
@property(nonatomic,assign) CGPoint cakeCenter;


@end
