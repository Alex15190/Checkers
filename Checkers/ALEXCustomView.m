//
//  ALEXCustomView.m
//  Checkers
//
//  Created by Alex on 29.09.2018.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ALEXCustomView.h"

@implementation ALEXCustomView


- (void)drawRect:(CGRect)rect {
    // Drawing code
}

-(void)spawnRedCheck
{
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redCheck"]];
    image.tag = 3;
    [image setFrame:self.bounds];
    [self addSubview:image];
}

-(void)spawnRedKingCheck
{
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redKingCheck"]];
    image.tag = 3;
    [image setFrame:self.bounds];
    [self addSubview:image];
}

-(void)spawnBlackCheck
{
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackCheck"]];
    image.tag = 3;
    [image setFrame:self.bounds];
    [self addSubview:image];
}

-(void)spawnBlackKingCheck
{
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackKingCheck"]];
    image.tag = 3;
    [image setFrame:self.bounds];
    [self addSubview:image];
}

-(void)showAsHighlighted
{
    
}

-(void)clear
{
    [[self viewWithTag:3] removeFromSuperview];
}

@end
