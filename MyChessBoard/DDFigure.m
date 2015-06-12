//
//  DDFigure.m
//  MyChessBoard
//
//  Created by DmitrJuga on 11.06.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import "AppConstants.h"
#import "DDFigure.h"

@implementation DDFigure

// convenience init
+ (instancetype)figureWithSize:(CGFloat)size {
    DDFigure *figure = [[DDFigure alloc]initWithFrame:CGRectMake(0, 0, size, size)];
    figure.backgroundColor = [UIColor clearColor];
    figure.userInteractionEnabled = YES;
    return figure;
}

// рисуем фигуру
- (void)drawRect:(CGRect)rect {
    NSDictionary *attributes =  @{ NSForegroundColorAttributeName: [UIColor FIGURE_COLOR],
                                   NSFontAttributeName: [UIFont systemFontOfSize: rect.size.width] };
    CGRect drawRect = CGRectOffset(rect, rect.size.width * .05, -rect.size.width * .05);
    [self.label drawInRect:drawRect withAttributes:attributes];
}


@end
