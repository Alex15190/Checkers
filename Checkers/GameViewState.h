//
//  GameViewState.h
//  Checkers
//
//  Created by Alex on 29.09.2018.
//  Copyright © 2018 Alex. All rights reserved.
//

#ifndef GameViewState_h
#define GameViewState_h

typedef NS_ENUM(NSUInteger, GameViewState) {
    GameViewStateUnplayable,
    GameViewStateEmpty,
    GameViewStateRed,
    GameViewStateRedKing,
    GameViewStateBlack,
    GameViewStateBlackKing
};


#endif /* GameViewState_h */
