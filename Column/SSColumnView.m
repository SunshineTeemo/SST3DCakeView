//
//  SSColumnView.m
//  Column
//
//  Created by 梅琰培 on 2016/12/28.
//  Copyright © 2016年 梅琰培. All rights reserved.
//

#import "SSColumnView.h"

@implementation SSColumnView
//core Graphics 绘图的基本使用
- (void)drawTryRect:(CGRect)rect
{
    //第一步获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置边界颜色
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    //设置笔触宽度
    CGContextSetLineWidth(context, 20);
    //填充颜色
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    //设置拐点样式
    CGContextSetLineJoin(context, kCGLineJoinRound);
    //设置线两端样式
    CGContextSetLineCap(context, kCGLineCapRound);
    
//    [self drawLineOne:context];
//    [self drawLineTwo:context];
//    [self drawLineTree:context];
//    [self drawEllipse:context];
//    [self drawSomeRect:context];
//    [self drawText:context];
    [self drawCircle:context];
     //描出笔触
    CGContextStrokePath(context);
    //填充
//    CGContextFillPath(context);
    
    
}
#pragma mark 画圆弧
- (void)drawCircle:(CGContextRef)contextRef
{
    //画圆弧
    CGContextAddArc(contextRef, 100, 100, 50, 0, M_PI, 0);
    CGContextMoveToPoint(contextRef, 200, 200);
    CGContextAddArcToPoint(contextRef, 200, 100,300, 100, 100);
//    CGContextAddArcToPoint(contextRef, 400, 100,400, 200, 100);
//    CGContextAddArcToPoint(contextRef, 400, 300,300, 300, 100);
//    CGContextAddArcToPoint(contextRef, 200, 300,200, 200, 100);
    
}
#pragma mark 画椭圆
- (void)drawEllipse:(CGContextRef)contextRef
{
    //长宽不一样是椭圆
    
    CGContextAddEllipseInRect(contextRef, CGRectMake(20, 80, 300, 130));
    //长宽一样是圆
    CGContextAddEllipseInRect(contextRef, CGRectMake(20, 200, 100, 100));
}
#pragma mark 画矩形
- (void)drawSomeRect:(CGContextRef)contextRef
{
    //长方形
    CGContextAddRect(contextRef, CGRectMake(30, 80, 100, 280));
    //正方形
    CGContextAddRect(contextRef, CGRectMake(30, 400, 100, 100));
    
}

//画文字
-(void)drawText:(CGContextRef)ctx{
    
    
    //文字样式
    UIFont *font = [UIFont systemFontOfSize:18];
    NSDictionary *dict = @{NSFontAttributeName:font,
                           NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    [@"hello world" drawInRect:CGRectMake(120 , 350, 500, 50) withAttributes:dict];
}

#pragma mark 画直线的第一种方法
- (void)drawLineOne:(CGContextRef)contextRef
{
    //起点
    CGContextMoveToPoint(contextRef, 30, 200);
    //添加直线，以上次的终点为起点
    CGContextAddLineToPoint(contextRef, 80, 250);
    
    //移到另一个点，不与上一次的终点连线，换一个新的起点
    CGContextMoveToPoint(contextRef, 100, 300);
    //连线
    CGContextAddLineToPoint(contextRef, 20, 500);
   
    
}
#pragma mark 画直线的第二种方法
- (void)drawLineTwo:(CGContextRef)contextRef
{
    //效果是依次连接这些点
    CGPoint points[] = {CGPointMake(20, 50),CGPointMake(60, 100),CGPointMake(300, 200)};
    CGContextAddLines(contextRef, points, 3);

    
}
#pragma mark 画直线的第三种方法，用path
- (void)drawLineTree:(CGContextRef)comtextRef
{
    //创建mutablePath
    CGMutablePathRef linePath = CGPathCreateMutable();
    //起点
    CGPathMoveToPoint(linePath, nil, 20, 30);
    //添加直线
    CGPathAddLineToPoint(linePath, nil, 300, 50);
    //新起点
    CGPathMoveToPoint(linePath, nil, 100, 100);
    //添加直线
    CGPathAddLineToPoint(linePath, nil, 50, 500);
    //将path加入context
    CGContextAddPath(comtextRef, linePath);
    
}
- (void)drawRect:(CGRect)rect
{
    //绘图
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //反锯齿
    CGContextSetAllowsAntialiasing(context, TRUE);
    
    
    float sum = 0;
    
    
    for(int j=0;j< _dataArray.count; j++)
    {
        sum  += [_dataArray[j] floatValue];
    }
    
    
    CGContextMoveToPoint(context, 160, 230);
    
    
    //饼图
    CGContextSaveGState(context);
    CGContextScaleCTM(context, 1.0, 0.5);
    
    float currentangel = 0;

    currentangel = 0;
    
    for(int i = 0; i< _dataArray.count; i++)
    {
        
        float startAngle = currentangel*2*M_PI;
        
        currentangel += [_dataArray[i] floatValue];
        
        float endAngle = currentangel*2*M_PI;
        
        
        //绘制上面的扇形
        CGContextMoveToPoint(context, 160, 230);
        
        [[_colorArray objectAtIndex:i] setFill];
        
        [[UIColor colorWithWhite:1.0 alpha:0.8] setStroke];
        
        CGContextAddArc(context, 160, 230, 150, startAngle, endAngle, 0);
        
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFill);
        
        
        
        //绘制侧面
        float starx = cos(startAngle) * 150  +160;
        float stary = sin(startAngle) * 150 + 230;
        
        float endx = cos(endAngle) * 150 + 160;
        float endy = sin(endAngle) * 150 + 230;
        
        //float starty1 = stary + spaceHeight;
        float endy1 = endy + 15;
        
        
        if(endAngle < 3.14)
        {
        }
        
        //只有弧度《 3.14 的才会画前面的厚度
        else if(startAngle < 3.14)
        {
            endAngle = 3.14;
            endx = 10;
            endy1 = 230+15;
        }
        
        else
            break;
        
        
        //CGContextSetBlendMode(context, kCGBlendModeMultiply);
        
        
        //绘制厚度
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, starx, stary);
        CGPathAddArc(path, nil, 160, 230, 150, startAngle, endAngle, 0);
        CGPathAddLineToPoint(path, nil, endx, endy1);
        
        CGPathAddArc(path, nil, 160, 230 + 15, 150, endAngle, startAngle, 1);
        CGContextAddPath(context, path);
        
        [[_colorArray objectAtIndex:i] setFill];
        [[UIColor colorWithWhite:0.9 alpha:1.0] setStroke];
        
        CGContextDrawPath(context, kCGPathFill);
        
        [[UIColor colorWithWhite:0.1 alpha:0.4] setFill];
        CGContextAddPath(context, path);
        CGContextDrawPath(context, kCGPathFill);
        
        
    }
    
    
    //整体渐变
    CGFloat componets [] = {0.0, 0.0, 0.0, 0.5,0.0,0.0,0.0,0.1};
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, componets, nil, 2);
    
    CGContextDrawRadialGradient(context, gradient, CGPointMake(160,230), 0, CGPointMake(160,230), 150, 0 );
    
    CFRelease(colorspace);
    CGGradientRelease(gradient);
    
    
    CGContextRestoreGState(context);
    
    //绘制文字
    
    for(int i = 0; i< [_dataArray count]; i++)
    {
        float origionx = 50 ;
        float origiony = i * 30 + 200;
        
        [[_colorArray objectAtIndex:i %  [_dataArray count]] setFill];
        
        CGContextFillRect(context, CGRectMake(origionx, origiony, 20, 20));
        CGContextDrawPath(context, kCGPathFill);
        
        
        if(i< [_nameArray count])
        {
            NSString *title = [ _nameArray objectAtIndex:i];
            [title drawAtPoint:CGPointMake(origionx + 50, origiony) withFont:[UIFont systemFontOfSize:16]];
        }
        
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
