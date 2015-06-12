//
//  DDFigure.h
//  MyChessBoard
//
//  Created by DmitrJuga on 11.06.15.
//  Copyright (c) 2015 Dmitriy Dolotenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDFigure : UIView

@property (copy, nonatomic) NSString *label;
@property (assign, nonatomic) NSUInteger cell;

+ (instancetype)figureWithSize:(CGFloat)size;

@end
