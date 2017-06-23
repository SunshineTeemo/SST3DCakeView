//
//  SSSolidCakeView.h
//  Column
//
//  Created by 梅琰培 on 2017/1/3.
//  Copyright © 2017年 梅琰培. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSSolidCakeView : UIView
//比例数据数组
@property(nonatomic,copy) NSArray *dataArray;
//颜色数组
@property(nonatomic,copy) NSArray *colorArray;
//名字数组，也就是颜色介绍数组
@property(nonatomic,copy) NSArray *nameArray;
//饼的厚度
@property(nonatomic,assign) CGFloat cakeHeight;
//饼的中心位置
@property(nonatomic,assign) CGPoint cakeCenter;
//饼的半径
@property(nonatomic,assign) CGFloat cakeRadius;
//x轴的压缩比例
@property(nonatomic,assign) CGFloat xScale;
//y轴的压缩比例
@property(nonatomic,assign) CGFloat yScale;
////文本显示开始的地方
//@property(nonatomic,assign) CGPoint textStartPoint;
////文本左侧的颜色框的大小
//@property(nonatomic,assign) CGFloat colorRectangleWidth;
////颜色框之间的距离
//@property(nonatomic,assign) CGFloat colorRectangleCrack;
@end
