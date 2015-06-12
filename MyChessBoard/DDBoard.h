//
//  DDChessBoard.h
//  MyBoard
//
//  Created by DmitrJuga on 11.06.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDFigure.h"

@interface DDBoard : UIView

@property (assign, nonatomic) CGFloat cellSize;

+ (instancetype)boardWithSize:(CGFloat)size;

- (CGPoint)getPointForCell:(NSUInteger)cellNum;
- (NSUInteger)getCellForPoint:(CGPoint)point;
- (DDFigure *)getFigureAtCell:(NSUInteger)cellNum;
- (BOOL)isEmptyCell:(NSUInteger)cellNum;

@end
