//
//  ViewController.m
//  Checkers
//
//  Created by Alex on 23.09.2018.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ViewController.h"
#import "ALEXCustomView.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *arrayOfColors;
@property (nonatomic) BOOL isRotated;
@property (weak, nonatomic) IBOutlet UIButton *rotateButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.arrayOfColors = @[@0,@1,@0,@1,@0,@1,@0,@1,@1,@0,@1,@0,@1,@0,@1,@0];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startGame];
}

- (IBAction)clearAction:(UIButton *)sender {
    [self clearGame];
}

- (IBAction)rotateAction:(UIButton *)sender {
    self.rotateButton.userInteractionEnabled = NO;
    [self rotateCollectionView];
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 64;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    ALEXCustomView *gameView = [cell viewWithTag:2];
    if ([[self.arrayOfColors objectAtIndex:(indexPath.row % 16)] integerValue] == 1)
    {
        gameView.backgroundColor = [UIColor colorWithRed:105.0/255 green:64.0/255 blue:11.0/255 alpha:1];
    }
    else
    {
        gameView.backgroundColor = [UIColor yellowColor];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALEXCustomView *gameView = [self gameViewWithIndex:indexPath.row];
    if (gameView.state == GameViewStateRed)
        [gameView spawnRedKingCheck];
    else if (gameView.state == GameViewStateBlack)
        [gameView spawnBlackKingCheck];
}





-(void)clearGame
{
    for(int i = 0;i < 8*8; i++)
    {
        ALEXCustomView *gameView = [self gameViewWithIndex:i];
        [gameView clear];
    }
}

-(void)startGame
{
    [self clearGame];
    for(int i = 0; i < 4*3*2;i++) {
        ALEXCustomView *gameView = [self gameViewWithIndex:i];
        if(gameView.state == GameViewStateEmpty)
        {
            [gameView spawnBlackCheck];
            ALEXCustomView *gameView2 = [self gameViewWithIndex:(8*8 - 1 - i)];
            [gameView2 spawnRedCheck];
        }
    }
}

-(void)rotateCollectionView
{
    CGAffineTransform t = CGAffineTransformMakeRotation(M_PI);
    CGAffineTransform t2 = CGAffineTransformMakeRotation(0);
    [UIView animateWithDuration:1.5 animations:^{
        if(self.isRotated)
            self.collectionView.transform = t2;
        else
            self.collectionView.transform = t;
        for (int i = 0; i < 8*8; i++)
        {
            [self rotateViewAtIndex:i];
        }
    } completion:^(BOOL finished) {
        self.rotateButton.userInteractionEnabled = YES;
    }];
    if (self.isRotated)
        self.isRotated = NO;
    else
        self.isRotated = YES;
}

-(void)rotateViewAtIndex:(NSInteger)index
{
    ALEXCustomView *gameView = [self gameViewWithIndex:index];
    [gameView rotateView];
    
}


-(ALEXCustomView *)gameViewWithIndex:(NSInteger)index
{
    return [[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]] viewWithTag:2];
}

@end
