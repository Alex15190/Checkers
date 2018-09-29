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


-(void)clearGame
{
    for(int i = 0;i < 8*8; i++)
    {
        ALEXCustomView *gameView = [[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:2];
        [gameView clear];
    }
}

-(void)startGame
{
    [self clearGame];
    for(int i = 0; i < 4*3*2;i++) {
        ALEXCustomView *gameView = [[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:2];
        if(CGColorEqualToColor(gameView.backgroundColor.CGColor, [UIColor colorWithRed:105.0/255 green:64.0/255 blue:11.0/255 alpha:1].CGColor))
        {
            [gameView spawnBlackCheck];
            ALEXCustomView *gameView2 = [[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:(8*8 - i - 1) inSection:0]] viewWithTag:2];
            [gameView2 spawnRedCheck];
        }
    }
}

@end
