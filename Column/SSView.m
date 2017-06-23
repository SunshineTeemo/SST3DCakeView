//
//  SSView.m
//  Column
//
//  Created by 梅琰培 on 2016/12/29.
//  Copyright © 2016年 梅琰培. All rights reserved.
//

#import "SSView.h"

@implementation SSView
#pragma mark 绘图
- (void)drawRect:(CGRect)rect
{
    //获得上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    //反锯齿,让图形边缘更加柔和（Sets whether or not to allow anti-aliasing for a graphics context.）
    CGContextSetAllowsAntialiasing(contextRef, TRUE);
    //保存图形状态
//    CGContextSaveGState(contextRef);
    //缩放坐标系
    CGContextScaleCTM(contextRef, 1.0, 0.6);
    //起点，也就是圆心
    CGContextMoveToPoint(contextRef, 160, 230);
    //设置边宽
    CGContextSetLineWidth(contextRef, 20);
    //饼图最先的起始角度
    CGFloat startAngle =0;
    
    for (int i = 0; i<_dataArray.count; i++) {
        //画饼的横截面
        //cake当前的角度
        CGFloat currentAngle = [_dataArray[i] floatValue];
        //结束的角度
        CGFloat endAngle = startAngle + currentAngle;
        //每一块cake的起点,也就是圆心
        CGContextMoveToPoint(contextRef, 160, 230);

        //添加对应角度扇形
        CGContextAddArc(contextRef, 160, 230, 100, startAngle*M_PI*2, endAngle*M_PI*2, 0);
       
        //得到对应的颜色
        UIColor *currentColor = _colorArray[i];
        //设置边界颜色
        CGContextSetStrokeColorWithColor(contextRef, currentColor.CGColor);
        //设置填充颜色
        CGContextSetFillColorWithColor(contextRef, currentColor.CGColor);
        //
        CGContextSetLineWidth(contextRef, 2);
        //结束子路径
        CGContextClosePath(contextRef);
        //画子路径
        CGContextDrawPath(contextRef, kCGPathFill);
        
        //画圆柱的侧面，饼图的厚度
        //圆柱的前半部分能看到，后半部分看不到
        //饼图厚度中竖直的部分的开始部分的起点坐标
        CGFloat startX = 160+100*cos(startAngle*2*M_PI);
        CGFloat startY = 230+100*sin(startAngle*2*M_PI);
        //竖直部分的结束部分终点坐标
        CGFloat endX = 160+100*cos(endAngle*2*M_PI);
        CGFloat endY = 230+100*sin(endAngle*2*M_PI);
    

        CGFloat endy1 = endY + _cakeHeight;
        if (endAngle>0.5) {
//            endAngle = 0.5;
        }
        
        if (startAngle<0.5) {
            //绘制厚度
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path, nil, startX, startY);

            if (endAngle>0.5) {
                CGPathAddArc(path, nil, 160, 230, 100, startAngle*2*M_PI, M_PI, 0);
                CGPathAddLineToPoint(path, nil, 160-100, 230+_cakeHeight);
                CGPathAddArc(path, nil, 160, 230 + _cakeHeight, 100, M_PI, startAngle*2*M_PI, 1);
                CGPathAddLineToPoint(path, nil, startX, startY);

            }else{
                CGPathAddArc(path, nil, 160, 230, 100, startAngle*2*M_PI, endAngle*2*M_PI, 0);
                CGPathAddLineToPoint(path, nil, endX, endy1);
                CGPathAddArc(path, nil, 160, 230 + _cakeHeight, 100, endAngle*2*M_PI, startAngle*2*M_PI, 1);
                CGPathAddLineToPoint(path, nil, startX, startY);

            }

            //之前这一段不是很明白，为啥设颜色和阴影都要draw一次
            //我自己尝试并理解分析了一下，每次draw一下想当于，把当前的设置画出来，再次draw就在这基础上，再画当前的设置，这里加颜色和阴影就是一层一层的画上去。要是不draw的话，再设置颜色相当于重新设置了颜色，之前设置的颜色就无效了。

            CGContextAddPath(contextRef, path);
            CGContextDrawPath(contextRef, kCGPathFill);
            
            //加阴影
            [[UIColor colorWithWhite:0.2 alpha:0.4] setFill];

            CGContextAddPath(contextRef, path);
            CGContextDrawPath(contextRef, kCGPathFill);

        }
        //最后一句，上一块的结束角度是下一块的开始角度
        startAngle = endAngle;
        
    }
    
    
        //此时不能用以下的方法填充，会导致饼图就一种颜色
        //CGContextFillPath(contextRef);
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
