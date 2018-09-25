//
//  CHECKCustomImageView.m
//  Checkers
//
//  Created by Alex on 23.09.2018.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "CHECKCustomImageView.h"

#define kCoof 9.31

@implementation CHECKCustomImageView


//- (void)drawRect:(CGRect)rect
//{
//    [self addFigure];
//}

- (void)addFigure
{
    UIImageView *figure = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redCheck"]];
    [figure setFrame:CGRectMake(0, 0, self.bounds.size.width / kCoof, self.bounds.size.height / kCoof)];
//    figure.layer.borderWidth = 30;
//    figure.layer.borderColor = [[UIColor greenColor] CGColor];
    [self addSubview:figure];
    
    UIImageView *figure2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redCheckKing"]];
    [figure2 setFrame:CGRectMake(self.bounds.size.width / kCoof, self.bounds.size.height / kCoof, self.bounds.size.width / kCoof, self.bounds.size.height / kCoof)];
//    figure2.layer.borderWidth = 30;
//    figure2.layer.borderColor = [[UIColor greenColor] CGColor];
    [self addSubview:figure2];
    
    UIImageView *figure3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackCheckKing"]];
    [figure3 setFrame:CGRectMake(2*self.bounds.size.width / kCoof, 2*self.bounds.size.height / kCoof, self.bounds.size.width / kCoof, self.bounds.size.height / kCoof)];
//    figure3.layer.borderWidth = 30;
//    figure3.layer.borderColor = [[UIColor greenColor] CGColor];
    [self addSubview:figure3];
    
    UIImageView *figure4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackCheckKing"]];
    [figure4 setFrame:CGRectMake(3*self.bounds.size.width / kCoof, 3*self.bounds.size.height / kCoof, self.bounds.size.width / kCoof, self.bounds.size.height / kCoof)];
//    figure4.layer.borderWidth = 30;
//    figure4.layer.borderColor = [[UIColor greenColor] CGColor];
    [self addSubview:figure4];
    
    
    UIImageView *figure5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackCheckKing"]];
    [figure5 setFrame:CGRectMake(4*self.bounds.size.width / kCoof, 4*self.bounds.size.height / kCoof, self.bounds.size.width / kCoof, self.bounds.size.height / kCoof)];
//    figure5.layer.borderWidth = 30;
//    figure5.layer.borderColor = [[UIColor greenColor] CGColor];
    [self addSubview:figure5];
    
    UIImageView *figure6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackCheckKing"]];
    [figure6 setFrame:CGRectMake(5*self.bounds.size.width / kCoof, 5*self.bounds.size.height / kCoof, self.bounds.size.width / kCoof, self.bounds.size.height / kCoof)];
//    figure6.layer.borderWidth = 30;
//    figure6.layer.borderColor = [[UIColor greenColor] CGColor];
    [self addSubview:figure6];
    
    UIImageView *figure7 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackCheckKing"]];
    [figure7 setFrame:CGRectMake(6*self.bounds.size.width / kCoof, 6*self.bounds.size.height / kCoof, self.bounds.size.width / kCoof, self.bounds.size.height / kCoof)];
//    figure7.layer.borderWidth = 30;
//    figure7.layer.borderColor = [[UIColor greenColor] CGColor];
    [self addSubview:figure7];
    
    
    UIImageView *figure8 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackCheckKing"]];
    [figure8 setFrame:CGRectMake(7*self.bounds.size.width / kCoof, 7*self.bounds.size.height / kCoof, self.bounds.size.width / kCoof, self.bounds.size.height / kCoof)];
//    figure8.layer.borderWidth = 30;
//    figure8.layer.borderColor = [[UIColor greenColor] CGColor];
    [self addSubview:figure8];
}


@end
