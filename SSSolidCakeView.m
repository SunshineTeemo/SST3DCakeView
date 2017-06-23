//
//  SSSolidCakeView.m
//  Column
//
//  Created by 梅琰培 on 2017/1/3.
//  Copyright © 2017年 梅琰培. All rights reserved.
//

#import "SSSolidCakeView.h"

@implementation SSSolidCakeView
//封装立体饼图
#pragma mark 重写绘制方法
- (void)drawRect:(CGRect)rect
{
    //第一步获得上下文
    CGContextRef cakeContextRef = UIGraphicsGetCurrentContext();
    //反锯齿,让图形边缘更加柔和（Sets whether or not to allow anti-aliasing for a graphics context.）
    CGContextSetAllowsAntialiasing(cakeContextRef, TRUE);
    //缩放坐标系的比例，通过设置y轴压缩，然后画代阴影的厚度，就画出了像是3D饼图的效果
    CGContextScaleCTM(cakeContextRef, _xScale, _yScale);
    //饼图最先的起始角度
    CGFloat startAngle =0;
    
    for (int i = 0; i<_dataArray.count; i++) {
        //画饼的横截面，上一部分完整的圆
        //cake当前的角度
        CGFloat currentAngle = [_dataArray[i] floatValue];
        //结束的角度
        CGFloat endAngle = startAngle + currentAngle;
        //每一块cake的起点,也就是圆心
        CGContextMoveToPoint(cakeContextRef, _cakeCenter.x, _cakeCenter.y);
        
        //添加对应角度扇形
        CGContextAddArc(cakeContextRef, _cakeCenter.x, _cakeCenter.y, _cakeRadius, startAngle*M_PI*2, endAngle*M_PI*2, 0);
        
        //得到对应的颜色
        UIColor *currentColor = _colorArray[i];
        //设置边界颜色
        CGContextSetStrokeColorWithColor(cakeContextRef, currentColor.CGColor);
        //设置填充颜色
        CGContextSetFillColorWithColor(cakeContextRef, currentColor.CGColor);
        //画子路径，这里就绘制还不是在画完厚度再绘制，是因为并不需要绘制所有cake的厚度，但是上一部分的圆是都要绘制的
        CGContextDrawPath(cakeContextRef, kCGPathFill);
        //饼图上一部分圆，startAngle处的起点坐标
        CGFloat upStartX = _cakeCenter.x+_cakeRadius*cos(startAngle*2*M_PI);
        CGFloat upStartY = _cakeCenter.y+_cakeRadius*sin(startAngle*2*M_PI);
       //饼图上一部分圆，endAngle处的终点坐标
        CGFloat upEndX = _cakeCenter.x+_cakeRadius*cos(endAngle*2*M_PI);
        CGFloat upEndY = _cakeCenter.y+_cakeRadius*sin(endAngle*2*M_PI);
        
        //饼图厚度在角度结束处y坐标
        CGFloat downEndY = upEndY + _cakeHeight;
        //画圆柱的侧面，饼图的厚度，圆柱的前半部分能看到，后半部分是看不到
        //开始的角度如果>=M_PI，就会在圆柱的后面，侧面厚度就没必要画了
        if (startAngle<0.5) {
            //绘制厚度
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path, nil, upStartX, upStartY);
            //当结束的角度>0.5*2*M_PI时，结束的角度该是M_PI的地方（视觉原因）
            if (endAngle>0.5) {
                //上部分的弧
                CGPathAddArc(path, nil, _cakeCenter.x, _cakeCenter.y, _cakeRadius, startAngle*2*M_PI, M_PI, 0);
                //在角度结束的地方，上部分到下部分的直线
                CGPathAddLineToPoint(path, nil, _cakeCenter.x-_cakeRadius, _cakeCenter.y+_cakeHeight);
                //下部分的弧
                CGPathAddArc(path, nil,  _cakeCenter.x, _cakeCenter.y + _cakeHeight, _cakeRadius, M_PI, startAngle*2*M_PI, 1);
                //在角度开始的地方，从下部分到上部分的直线
                CGPathAddLineToPoint(path, nil, upStartX, upStartY);
                
            }
            else{
                //上部分的弧
                CGPathAddArc(path, nil, _cakeCenter.x, _cakeCenter.y, _cakeRadius, startAngle*2*M_PI, endAngle*2*M_PI, 0);
                //在角度结束的地方，上部分到下部分的直线
                CGPathAddLineToPoint(path, nil, upEndX, downEndY);
                //下部分的弧
                CGPathAddArc(path, nil, _cakeCenter.x, _cakeCenter.y + _cakeHeight, _cakeRadius, endAngle*2*M_PI, startAngle*2*M_PI, 1);
                //在角度开始的地方，从下部分到上部分的直线
                CGPathAddLineToPoint(path, nil, upStartX, upStartY);
                
            }
            //之前这一段不是很明白，为啥设颜色和阴影都要draw一次
            //我自己尝试并理解分析了一下，每次draw一下想当于，把当前的设置画出来，再次draw就在这基础上，再画当前的设置，这里加颜色和阴影就是一层一层的画上去。要是不draw的话，再设置颜色相当于重新设置了颜色，之前设置的颜色就无效了。
            CGContextAddPath(cakeContextRef, path);
            CGContextDrawPath(cakeContextRef, kCGPathFill);
            //加阴影
            [[UIColor colorWithWhite:0.2 alpha:0.4] setFill];
            CGContextAddPath(cakeContextRef, path);
            CGContextDrawPath(cakeContextRef, kCGPathFill);
            
        }
      
        //最后一句，上一块的结束角度是下一块的开始角度
        startAngle = endAngle;
        
    }
    //此时不能用以下的方法填充，会导致饼图就一种颜色
    //CGContextFillPath(contextRef);
}
-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    //重新绘制
    [self setNeedsDisplay];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
