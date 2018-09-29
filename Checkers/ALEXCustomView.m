//
//  ALEXCustomView.m
//  Checkers
//
//  Created by Alex on 29.09.2018.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ALEXCustomView.h"

@implementation ALEXCustomView

//
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}

-(void)spawnRedCheck
{
    [self clear];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redCheck"]];
    image.tag = 3;
    [image setFrame:self.bounds];
    self.state = GameViewStateRed;
    if(self.isUpsideDown)
        image.transform = CGAffineTransformMakeRotation(M_PI);
    [self addSubview:image];
}

-(void)spawnRedKingCheck
{
    [self clear];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redCheckKing"]];
    image.tag = 3;
    [image setFrame:self.bounds];
    self.state = GameViewStateRedKing;
    if(self.isUpsideDown)
        image.transform = CGAffineTransformMakeRotation(M_PI);
    [self addSubview:image];
}

-(void)spawnBlackCheck
{
    [self clear];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackCheck"]];
    image.tag = 3;
    [image setFrame:self.bounds];
    self.state = GameViewStateBlack;
    if(self.isUpsideDown)
        image.transform = CGAffineTransformMakeRotation(M_PI);
    [self addSubview:image];
}

-(void)spawnBlackKingCheck
{
    [self clear];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackCheckKing"]];
    image.tag = 3;
    [image setFrame:self.bounds];
    self.state = GameViewStateBlackKing;
    if(self.isUpsideDown)
        image.transform = CGAffineTransformMakeRotation(M_PI);
    [self addSubview:image];
}

-(void)showAsHighlighted
{
    if(self.state == GameViewStateEmpty)
    {
        UIView *highlightView = [[UIView alloc] init];
        highlightView.frame = self.frame;
        highlightView.tag = 4;
        highlightView.backgroundColor = [UIColor blueColor];
        highlightView.alpha = 0.3;
        [self addSubview:highlightView];
    }
}

-(void)rotateView
{
    [UIView animateWithDuration:1.5 animations:^{
        [self viewWithTag:3].transform = CGAffineTransformMakeRotation(M_PI);
    }];
    if(self.isUpsideDown)
        self.isUpsideDown = NO;
    else
        self.isUpsideDown = YES;
}

-(void)removeHighlighted
{
    [[self viewWithTag:4] removeFromSuperview];
}

-(void)clear
{
    [[self viewWithTag:3] removeFromSuperview];
    if (CGColorEqualToColor(self.backgroundColor.CGColor, [UIColor yellowColor].CGColor))
        self.state = GameViewStateUnplayable;
    else
        self.state = GameViewStateEmpty;
}

@end
