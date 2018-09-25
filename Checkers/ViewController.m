//
//  ViewController.m
//  Checkers
//
//  Created by Alex on 23.09.2018.
//  Copyright © 2018 Alex. All rights reserved.
//

#import "ViewController.h"

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
    UIView *gameView = [cell viewWithTag:2];
    if ([[self.arrayOfColors objectAtIndex:(indexPath.row % 16)] integerValue] == 1)
    {
        gameView.backgroundColor = [UIColor blackColor];
    }
    else
        gameView.backgroundColor = [UIColor yellowColor];
    return cell;
}

@end
