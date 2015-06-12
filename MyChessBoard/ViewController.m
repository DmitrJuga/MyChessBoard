//
//  ViewController.m
//  MyChessBoard
//
//  Created by DmitrJuga on 05.05.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import "ViewController.h"
#import "DDBoard.h"
#import "DDFigure.h"

@interface ViewController ()

@property (nonatomic, weak) DDBoard *chessBoard;

@property (nonatomic, strong) DDFigure *movingFigure;
@property (nonatomic, assign) CGVector offsetToCenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Массив unicode-символов шахматных фигур в порядке начальной расстановки на доске
    NSArray *figuresOnBoard = @[ @"\u265C\u265E\u265D\u265B\u265A\u265D\u265E\u265C",
                                 @"\u265F\u265F\u265F\u265F\u265F\u265F\u265F\u265F",
                                 @"", @"", @"", @"",
                                 @"\u2659\u2659\u2659\u2659\u2659\u2659\u2659\u2659",
                                 @"\u2656\u2658\u2657\u2655\u2654\u2657\u2658\u2656" ];
    
    // Создаём доску
    CGFloat boardSize = MIN(self.view.frame.size.height, self.view.frame.size.width) * 0.85;
    DDBoard *board = [DDBoard boardWithSize:boardSize];
    [self.view addSubview:board];
    self.chessBoard = board;

    // Расставляем фигуры на доске
    for (int i = 0; i <= 7; i++) {
        NSString *line = figuresOnBoard[i];
        if (line.length > 0) {
            for (int j = 0; j <= 7; j++) {
                DDFigure *figure = [DDFigure figureWithSize:self.chessBoard.cellSize];
                figure.label = [line substringWithRange:NSMakeRange(j, 1)];
                figure.cell = i * 8 + j;;
                [self.chessBoard addSubview:figure];
            }
        }
    }
}


#pragma mark - Movements

// начало перемещения фигуры
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    UIView *touchedView = [self.view hitTest:touchPoint withEvent:event];
    if ([touchedView isKindOfClass:[DDFigure class]]) {
        self.movingFigure = (DDFigure *)touchedView;
        self.offsetToCenter = CGVectorMake(touchedView.center.x - touchPoint.x, touchedView.center.y - touchPoint.y);
        [self.view bringSubviewToFront:touchedView];
        // анимация: приподнимаем фигуру
        [UIView animateWithDuration:0.35 animations:^{
            touchedView.transform = CGAffineTransformMakeScale(1.3f, 1.3f);
            touchedView.alpha = 0.6;
        }];
    } else {
        self.movingFigure = nil;
    }
}

// продолжение перемещения фигуры
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.movingFigure) {
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        CGPoint newCenter = CGPointMake(touchPoint.x + self.offsetToCenter.dx, touchPoint.y + self.offsetToCenter.dy);
        self.movingFigure.center = newCenter;
    }
}

// завершение перемещения фигуры
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.movingFigure) {
        // вычисляем новую позицию - центр клетки, над которой отпустили фигуру
        CGPoint touchPoint = [[touches anyObject] locationInView:self.chessBoard];
        NSUInteger newCell = [self.chessBoard getCellForPoint:touchPoint];
        if (newCell < 64 && [self.chessBoard isEmptyCell:newCell]) {
            self.movingFigure.cell = newCell;
        }
        CGPoint newPoint = [self.chessBoard getPointForCell:self.movingFigure.cell];
        // анимация: опускаем фигуру на новое место
        [UIView animateWithDuration:0.35 animations:^{
            self.movingFigure.transform = CGAffineTransformIdentity;
            self.movingFigure.alpha = 1;
            self.movingFigure.center = newPoint;
        }];
    }
}

// отмена перемещения фигуры
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.movingFigure) {
        // анимация: возвращаем фигуру на старое место
        CGPoint originPoint = [self.chessBoard getPointForCell:self.movingFigure.cell];
        [UIView animateWithDuration:0.35 animations:^{
            self.movingFigure.transform = CGAffineTransformIdentity;
            self.movingFigure.alpha = 1;
            self.movingFigure.center = originPoint;
        }];
    }
}


#pragma mark - Layout

-(void)viewWillLayoutSubviews {
    self.chessBoard.center = self.view.center;
    [self.chessBoard setNeedsLayout];
}

@end
