//
//  DDBoard.m
//  MyChessBoard
//
//  Created by DmitrJuga on 11.06.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import "AppConstants.h"
#import "DDBoard.h"

@implementation DDBoard

// convenience init
+ (instancetype)boardWithSize:(CGFloat)size {
    int cellSize = size / 8; //
    CGRect boardFrame = CGRectMake(0, 0, cellSize * 8, cellSize * 8);
    DDBoard *board = [[DDBoard alloc] initWithFrame:boardFrame];
    board.backgroundColor = [UIColor WHITE_CELL_COLOR];
    board.cellSize = cellSize;
    return board;
}


#pragma mark - UIView routines

// рисуем доску с клетками
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    // рисуем только "чёрные" клетки
    CGContextSetFillColorWithColor(context, [UIColor BLACK_CELL_COLOR].CGColor);
    for (int i = 0; i <= 7; i++) {
        for (int j = 0; j <= 7; j++) {
            if (j % 2 != i % 2) {
                CGRect cellRect = CGRectMake(self.cellSize * j, self.cellSize * i, self.cellSize, self.cellSize);
                CGContextFillRect(context, cellRect);
            }
        }
    }
    // общая рамка
    CGContextSetStrokeColorWithColor(context, [UIColor BLACK_CELL_COLOR].CGColor);
    CGContextSetLineWidth(context, self.cellSize * 0.1);
    CGContextStrokeRect(context, rect);
}

// обновление расположения фигур на доске
-(void)layoutSubviews {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[DDFigure class]]) {
            DDFigure *figure = (DDFigure *)view;
            figure.center = [self getPointForCell:figure.cell];
        }
    }
}


#pragma mark - ChessBoard routines

// возвращает целевые координаты (центр) для клетки на доске
- (CGPoint)getPointForCell:(NSUInteger)cellNum {
    NSUInteger row = cellNum / 8;
    NSUInteger col = cellNum % 8;
    NSUInteger offset = self.cellSize / 2;
    return CGPointMake(self.bounds.origin.x + col * self.cellSize + offset,
                       self.bounds.origin.y + row * self.cellSize + offset);
}

// возвращает клетку в которую попадает переданая точка
- (NSUInteger)getCellForPoint:(CGPoint)point {
    if (!CGRectContainsPoint(self.bounds, point)) {
        return 64;
    };
    NSUInteger row = point.y / self.cellSize;
    NSUInteger col = point.x / self.cellSize;
    return row * 8 + col;
}

// возвращает фигуру в указанной клетке (если нет - nil)
- (DDFigure *)getFigureAtCell:(NSUInteger)cellNum {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[DDFigure class]]) {
            DDFigure *figure = (DDFigure *)view;
            if (figure.cell == cellNum) {
                return figure;
            }
        }
    }
    return nil;
}

// есть ли фигура в клетке
- (BOOL)isEmptyCell:(NSUInteger)cellNum {
    return ([self getFigureAtCell:cellNum] == nil);
}


@end
