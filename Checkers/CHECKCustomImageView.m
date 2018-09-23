//
//  CHECKCustomImageView.m
//  Checkers
//
//  Created by Alex on 23.09.2018.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "CHECKCustomImageView.h"

@implementation CHECKCustomImageView


//- (void)drawRect:(CGRect)rect
//{
//    [self addFigure];
//}

- (void)addFigure
{
    UIImageView *figure = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redCheck"]];
    [figure setFrame:CGRectMake(0, 0, self.bounds.size.width / 9.0, self.bounds.size.height / 9.0)];
    figure.layer.borderWidth = 0;
    [self addSubview:figure];
    
    UIImageView *figure2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redCheckKing"]];
    [figure2 setFrame:CGRectMake(self.bounds.size.width / 9.0, self.bounds.size.height / 9.0, self.bounds.size.width / 9.0, self.bounds.size.height / 9.0)];
    figure2.layer.borderWidth = 0;
    [self addSubview:figure2];
    
    UIImageView *figure3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackCheckKing"]];
    [figure3 setFrame:CGRectMake(2*self.bounds.size.width / 9.0, 2*self.bounds.size.height / 9.0, self.bounds.size.width / 9.0, self.bounds.size.height / 9.0)];
    figure3.layer.borderWidth = 0;
    [self addSubview:figure3];
}


@end
