//
//  ALEXCustomView.h
//  Checkers
//
//  Created by Alex on 29.09.2018.
//  Copyright © 2018 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALEXCustomView : UIView

-(void)spawnRedCheck;
-(void)spawnRedKingCheck;
-(void)spawnBlackCheck;
-(void)spawnBlackKingCheck;
-(void)showAsHighlighted;
-(void)clear;

@end

NS_ASSUME_NONNULL_END
