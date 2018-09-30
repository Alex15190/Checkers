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

@property (nonatomic) NSInteger latsTouchedIndex;

@end

@implementation ViewController

#pragma mark viewWiil/viewDid

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.arrayOfColors = @[@0,@1,@0,@1,@0,@1,@0,@1,@1,@0,@1,@0,@1,@0,@1,@0];
    self.latsTouchedIndex = -1;
    self.isRotated = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startGame];
}

#pragma mark IBActions

- (IBAction)resetAction:(UIButton *)sender {
    [self startGame];
}

- (IBAction)rotateAction:(UIButton *)sender {
    self.rotateButton.userInteractionEnabled = NO;
    [self rotateCollectionView];
}

#pragma mark delegate and data source of colletionView

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
    if ([self gameViewWithIndex:indexPath.row].isHighlighted)
        [self moveToIndex:indexPath.row From:self.latsTouchedIndex];
    else{
        self.latsTouchedIndex = indexPath.row;
        [self highlightCellsForStepAtIndex:indexPath.row];
    }
    
}


#pragma mark Game methods


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
    [self unHighlightCells];
    if (self.isRotated)
        [self rotateCollectionView];
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


-(ALEXCustomView *)gameViewWithIndex:(NSInteger)index{
    return [[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]] viewWithTag:2];
}

-(GameViewState)gameStateWithIndex:(NSInteger)index{
    return [self gameViewWithIndex:index].state;
}

#pragma mark Game movement

-(void)highlightCellsForStepAtIndex:(NSInteger)index
{
    [self unHighlightCells];
    ALEXCustomView *view = [self gameViewWithIndex:index];
    if (index % 8 == 0){
        switch (view.state) {
            case GameViewStateRed:
                if ([self gameStateWithIndex:index - 7] == GameViewStateEmpty)
                    [[self gameViewWithIndex:index - 7] showAsHighlighted];
                break;
            case GameViewStateBlack:
                if ([self gameStateWithIndex:index + 9] == GameViewStateEmpty)
                    [[self gameViewWithIndex:index + 9] showAsHighlighted];
                break;
            case GameViewStateRedKing:
                break;
            case GameViewStateBlackKing:
                break;
            case GameViewStateEmpty:
                break;
            case GameViewStateUnplayable:
                break;
        }
    } else if (index % 8 == 7){
        switch (view.state) {
            case GameViewStateRed:
                if ([self gameStateWithIndex:index - 9] == GameViewStateEmpty)
                    [[self gameViewWithIndex:index - 9] showAsHighlighted];
                break;
            case GameViewStateBlack:
                if ([self gameStateWithIndex:index + 7] == GameViewStateEmpty)
                    [[self gameViewWithIndex:index + 7] showAsHighlighted];
                break;
            case GameViewStateRedKing:
                break;
            case GameViewStateBlackKing:
                break;
            case GameViewStateEmpty:
                [self unHighlightCells];
                break;
            case GameViewStateUnplayable:
                [self unHighlightCells];
                break;
        }
    } else {
        switch (view.state) {
            case GameViewStateRed:
                if ([self gameStateWithIndex:index - 7] == GameViewStateEmpty)
                    [[self gameViewWithIndex:index - 7] showAsHighlighted];
                if ([self gameStateWithIndex:index - 9] == GameViewStateEmpty)
                    [[self gameViewWithIndex:index - 9] showAsHighlighted];
                break;
            case GameViewStateBlack:
                if ([self gameStateWithIndex:index + 9] == GameViewStateEmpty)
                    [[self gameViewWithIndex:index + 9] showAsHighlighted];
                if ([self gameStateWithIndex:index + 7] == GameViewStateEmpty)
                    [[self gameViewWithIndex:index + 7] showAsHighlighted];
                break;
            case GameViewStateRedKing:
                break;
            case GameViewStateBlackKing:
                break;
            case GameViewStateEmpty:
                [self unHighlightCells];
                break;
            case GameViewStateUnplayable:
                [self unHighlightCells];
                break;
        }
    }
}

-(void)moveToIndex:(NSInteger)toIndex From:(NSInteger)fromIndex
{
    ALEXCustomView *gameView1 = [self gameViewWithIndex:fromIndex];
    ALEXCustomView *gameView2 = [self gameViewWithIndex:toIndex];
    switch (gameView1.state) {
        case GameViewStateRed:
            [gameView2 spawnRedCheck];
            break;
        case GameViewStateRedKing:
            [gameView2 spawnRedKingCheck];
            break;
        case GameViewStateBlack:
            [gameView2 spawnBlackCheck];
            break;
        case GameViewStateBlackKing:
            [gameView2 spawnBlackKingCheck];
            break;
        default:
            break;
    }
    [gameView1 clear];
    [self unHighlightCells];
}

-(void)unHighlightCells{
    for(int i = 0; i < 8*8; i++){
        ALEXCustomView *gameView = [self gameViewWithIndex:i];
        if (gameView.isHighlighted)
            [gameView removeHighlighted];
    }
}


@end
