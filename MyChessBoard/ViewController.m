//
//  ViewController.m
//  MyChessBoard
//
//  Created by DmitrJuga on 05.05.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView * chessBoard;
@property (nonatomic, strong) UIView * movingFigure;
@property (nonatomic, assign) CGPoint originPoint;
@property (nonatomic, assign) CGVector offsetToCenter;

@end

#define     CELL_SIZE   80
#define     BLACK_CELL_COLOR    lightGrayColor
#define     WHITE_CELL_COLOR    whiteColor
#define     FIGURE_COLOR        blackColor



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Массив unicode-символов шахматных фигур в порядке начальной расстановки на доске
    NSArray *figuresOnBoard = @[@"\u265C\u265E\u265D\u265B\u265A\u265D\u265E\u265C",
                                @"\u265F\u265F\u265F\u265F\u265F\u265F\u265F\u265F",
                                @"", @"", @"", @"",
                                @"\u2659\u2659\u2659\u2659\u2659\u2659\u2659\u2659",
                                @"\u2656\u2658\u2657\u2655\u2654\u2657\u2658\u2656"];
    
    // Создаём доску
    [self setChessBoardWithCellSize:CELL_SIZE];
    
    // Расставляем фигуры на доске
    for (int i = 0; i <= 7; i++) {
        NSString *line = figuresOnBoard[i];
        if (line.length > 0) {
            for (int j = 0; j <= 7; j++) {
                // фигура - UILabel
                UILabel *figure = [[UILabel alloc] init];
                figure.textColor = [UIColor FIGURE_COLOR];
                figure.font = [UIFont systemFontOfSize: CELL_SIZE];
                figure.text = [line substringWithRange:NSMakeRange(j, 1)];
                [figure sizeToFit];
                // ставим по центру клетки
                UIView *cell = self.chessBoard.subviews[i * 8 + j];
                figure.center = [self.chessBoard convertPoint:cell.center toView:self.view];
                figure.userInteractionEnabled = true;
                
                [self.view addSubview:figure];
            }
        }
    }
}


#pragma mark - Board

// Создание шахматной доски
- (void)setChessBoardWithCellSize:(CGFloat)cellSize{
    CGRect boardFrame = CGRectMake(0, 0, cellSize * 8, cellSize * 8);
    self.chessBoard = [[UIView alloc] initWithFrame:boardFrame];
    self.chessBoard.userInteractionEnabled = false;
    self.chessBoard.layer.borderColor = [UIColor BLACK_CELL_COLOR].CGColor;
    self.chessBoard.layer.borderWidth = 1;
    self.chessBoard.center = self.view.center;
    
    // расстановка клеток
    BOOL isWhite = true;
    for (int i = 0; i <= 7; i++) {
        for (int j = 0; j <= 7; j++) {
            CGRect cellFrame = CGRectMake(cellSize * j, cellSize * i, cellSize, cellSize);
            UIView *cell = [[UIView alloc] initWithFrame:cellFrame];
            cell.backgroundColor = isWhite ? [UIColor WHITE_CELL_COLOR] : [UIColor BLACK_CELL_COLOR];
            [self.chessBoard addSubview:cell];
            isWhite = !isWhite;
        }
        isWhite = !isWhite;
    }

    [self.view addSubview:self.chessBoard];
}


#pragma mark - Movements

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    UIView *view = [self.view hitTest:touchPoint withEvent:event];
    if (![view isEqual:self.view]) {
        self.movingFigure = view;
        self.originPoint = view.center;
        self.offsetToCenter = CGVectorMake(view.center.x - touchPoint.x, view.center.y - touchPoint.y);
        [self.view bringSubviewToFront:view];
        // анимация: приподнимаем фигуру
        [UIView animateWithDuration:0.35 animations:^{
            self.movingFigure.transform = CGAffineTransformMakeScale(1.3f, 1.3f);
            self.movingFigure.alpha = 0.6;
        }];
    } else {
        self.movingFigure = nil;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.movingFigure) {
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        CGPoint newCenter = CGPointMake(touchPoint.x + self.offsetToCenter.dx, touchPoint.y + self.offsetToCenter.dy);
        self.movingFigure.center = newCenter;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.movingFigure) {
        // вычисляем новую позицию - центр клетки, над которой отпустили фигуру
        CGPoint newCenter = self.originPoint; // если не найдём - вернём на исходную позицию
        CGPoint touchPoint = [[touches anyObject] locationInView:self.chessBoard];
        for (UIView *cell in self.chessBoard.subviews) {
            if (CGRectContainsPoint(cell.frame, touchPoint)) {
                newCenter = [self.chessBoard convertPoint:cell.center toView:self.view];
                break;
            }
        }
        // анимация: опускаем фигуру на новое место
        [UIView animateWithDuration:0.35 animations:^{
            self.movingFigure.transform = CGAffineTransformIdentity;
            self.movingFigure.alpha = 1;
            self.movingFigure.center = newCenter;
        }];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.movingFigure) {
        // анимация: возвращаем фигуру на старое место
        [UIView animateWithDuration:0.35 animations:^{
            self.movingFigure.transform = CGAffineTransformIdentity;
            self.movingFigure.alpha = 1;
            self.movingFigure.center = self.originPoint;
        }];
    }
}

@end
