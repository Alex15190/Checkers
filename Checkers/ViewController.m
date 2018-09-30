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
@property (strong, nonatomic) NSMutableDictionary *dictIndexOfDeletableObj;

@end

@implementation ViewController

/*
 
- - - - -     - - m - -     - - m - -
- b - b -     - b - b -     - b - b -
- - - - x     - - - - x     m - - - x
 
*/








#pragma mark viewWiil/viewDid

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.arrayOfColors = @[@0,@1,@0,@1,@0,@1,@0,@1,@1,@0,@1,@0,@1,@0,@1,@0];
    self.latsTouchedIndex = -1;
    self.dictIndexOfDeletableObj = [[NSMutableDictionary alloc] init];
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
    if ([self gameViewWithIndex:indexPath.row].isHighlighted){
        [self moveToIndex:indexPath.row From:self.latsTouchedIndex];
        [self checkForKing];
    }
    else{
        self.latsTouchedIndex = indexPath.row;
        [self highlightCellsForStep:0 atIndex:indexPath.row];
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

-(void)highlightCellsForStep:(NSInteger)step atIndex:(NSInteger)index
{
//    [self unHighlightCells];
    ALEXCustomView *gameView = [self gameViewWithIndex:index];
    if (step == 0){
        [self unHighlightCells];
        if (index % 8 == 0){
            switch (gameView.state) {
                case GameViewStateRed:
                    if ([self gameStateWithIndex:index - 7] == GameViewStateEmpty)
                        [[self gameViewWithIndex:index - 7] showAsHighlighted];
                    else if (([self gameStateWithIndex:index - 7] == GameViewStateBlack)||([self gameStateWithIndex:index - 7] == GameViewStateBlackKing))
                        [self highlightCellsForStep: -7 atIndex:index];
                    if (([self gameStateWithIndex:index + 7] == GameViewStateBlack)||([self gameStateWithIndex:index + 7] == GameViewStateBlackKing))
                        [self highlightCellsForStep: 7 atIndex:index];
                    break;
                case GameViewStateBlack:
                    if ([self gameStateWithIndex:index + 9] == GameViewStateEmpty)
                        [[self gameViewWithIndex:index + 9] showAsHighlighted];
                    else if (([self gameStateWithIndex:index + 9] == GameViewStateRed)||([self gameStateWithIndex:index + 9] == GameViewStateRedKing))
                        [self highlightCellsForStep: 9 atIndex:index];
                    if (([self gameStateWithIndex:index - 9] == GameViewStateRed)||([self gameStateWithIndex:index - 9] == GameViewStateRedKing))
                        [self highlightCellsForStep: -9 atIndex:index];
                    break;
                case GameViewStateRedKing:
                    if (([self gameStateWithIndex:index - 7] == GameViewStateBlack)||([self gameStateWithIndex:index - 7] == GameViewStateBlackKing))
                        [self highlightCellsForStep: -7 atIndex:index];
                    if (([self gameStateWithIndex:index + 7] == GameViewStateBlack)||([self gameStateWithIndex:index + 7] == GameViewStateBlackKing))
                        [self highlightCellsForStep: 7 atIndex:index];
                    break;
                case GameViewStateBlackKing:
                    if (([self gameStateWithIndex:index + 9] == GameViewStateRed)||([self gameStateWithIndex:index + 9] == GameViewStateRedKing))
                        [self highlightCellsForStep: 9 atIndex:index];
                    if (([self gameStateWithIndex:index - 9] == GameViewStateRed)||([self gameStateWithIndex:index - 9] == GameViewStateRedKing))
                        [self highlightCellsForStep: -9 atIndex:index];
                    break;
                case GameViewStateEmpty:
                    break;
                case GameViewStateUnplayable:
                    break;
            }
        } else if (index % 8 == 7){
            switch (gameView.state) {
                case GameViewStateRed:
                    if ([self gameStateWithIndex:index - 9] == GameViewStateEmpty)
                        [[self gameViewWithIndex:index - 9] showAsHighlighted];
                    else if (([self gameStateWithIndex:index - 9] == GameViewStateBlack)||([self gameStateWithIndex:index - 9] == GameViewStateBlackKing))
                        [self highlightCellsForStep: -9 atIndex:index];
                    if (([self gameStateWithIndex:index + 9] == GameViewStateBlack)||([self gameStateWithIndex:index + 9] == GameViewStateBlackKing))
                        [self highlightCellsForStep: 9 atIndex:index];
                    break;
                case GameViewStateBlack:
                    if ([self gameStateWithIndex:index + 7] == GameViewStateEmpty)
                        [[self gameViewWithIndex:index + 7] showAsHighlighted];
                    else if (([self gameStateWithIndex:index + 7] == GameViewStateRed)||([self gameStateWithIndex:index + 7] == GameViewStateRedKing))
                        [self highlightCellsForStep: 7 atIndex:index];
                    if (([self gameStateWithIndex:index - 7] == GameViewStateRed)||([self gameStateWithIndex:index - 7] == GameViewStateRedKing))
                        [self highlightCellsForStep: -7 atIndex:index];
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
            switch (gameView.state) {
                case GameViewStateRed:
                    if ([self gameStateWithIndex:index - 7] == GameViewStateEmpty)
                        [[self gameViewWithIndex:index - 7] showAsHighlighted];
                    else if (([self gameStateWithIndex:index - 7] == GameViewStateBlack)||([self gameStateWithIndex:index - 7] == GameViewStateBlackKing))
                        [self highlightCellsForStep: -7 atIndex:index];
                    if (([self gameStateWithIndex:index + 7] == GameViewStateBlack)||([self gameStateWithIndex:index + 7] == GameViewStateBlackKing))
                        [self highlightCellsForStep: 7 atIndex:index];
                    
                    
                    
                    if ([self gameStateWithIndex:index - 9] == GameViewStateEmpty)
                        [[self gameViewWithIndex:index - 9] showAsHighlighted];
                    else if (([self gameStateWithIndex:index - 9] == GameViewStateBlack)||([self gameStateWithIndex:index - 9] == GameViewStateBlackKing))
                        [self highlightCellsForStep: -9 atIndex:index];
                    if (([self gameStateWithIndex:index + 9] == GameViewStateBlack)||([self gameStateWithIndex:index + 9] == GameViewStateBlackKing))
                        [self highlightCellsForStep: 9 atIndex:index];
                    break;
                case GameViewStateBlack:
                    if ([self gameStateWithIndex:index + 9] == GameViewStateEmpty)
                        [[self gameViewWithIndex:index + 9] showAsHighlighted];
                    else if (([self gameStateWithIndex:index + 9] == GameViewStateRed)||([self gameStateWithIndex:index + 9] == GameViewStateRedKing))
                        [self highlightCellsForStep: 9 atIndex:index];
                    if (([self gameStateWithIndex:index - 9] == GameViewStateRed)||([self gameStateWithIndex:index - 9] == GameViewStateRedKing))
                        [self highlightCellsForStep: -9 atIndex:index];
                    
                    
                    if ([self gameStateWithIndex:index + 7] == GameViewStateEmpty)
                        [[self gameViewWithIndex:index + 7] showAsHighlighted];
                    else if (([self gameStateWithIndex:index + 7] == GameViewStateRed)||([self gameStateWithIndex:index + 7] == GameViewStateRedKing))
                        [self highlightCellsForStep: 7 atIndex:index];
                    if (([self gameStateWithIndex:index - 7] == GameViewStateRed)||([self gameStateWithIndex:index - 7] == GameViewStateRedKing))
                        [self highlightCellsForStep: -7 atIndex:index];
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
    } else {
        ALEXCustomView *gameView2 = [self gameViewWithIndex:index + step*2];
        if ((gameView2.state == GameViewStateEmpty)&&(!gameView2.isHighlighted)){
            NSMutableArray *array = [self.dictIndexOfDeletableObj objectForKey:@(index)];
            if (!array)
                array = [[NSMutableArray alloc] init];
            [array addObject:@(index + step)];
            [self.dictIndexOfDeletableObj setObject:array forKey:@(index + 2*step)];
            [gameView2 showAsHighlighted];
        }
    }
}

-(void)eatEnemyForMoveToIndex:(NSInteger)index
{
    NSArray *arr = self.dictIndexOfDeletableObj[@(index)];
    for (NSNumber *number in arr){
        [[self gameViewWithIndex:[number integerValue]] clear];
    }
    self.dictIndexOfDeletableObj = [[NSMutableDictionary alloc] init];
}


-(void)moveToIndex:(NSInteger)toIndex From:(NSInteger)fromIndex
{
    ALEXCustomView *gameView1 = [self gameViewWithIndex:fromIndex];
    ALEXCustomView *gameView2 = [self gameViewWithIndex:toIndex];
    
    [self eatEnemyForMoveToIndex:toIndex];
    
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

-(void)checkForKing{
    for (int i = 0; i < 8; i++){
        ALEXCustomView *gameView1 = [self gameViewWithIndex:i];
        ALEXCustomView *gameView2 = [self gameViewWithIndex:8*8 - 1 - i];
        if (gameView1.state == GameViewStateRed)
            [gameView1 spawnRedKingCheck];
        else if (gameView2.state == GameViewStateBlack)
            [gameView2 spawnBlackKingCheck];
    }
}

@end
