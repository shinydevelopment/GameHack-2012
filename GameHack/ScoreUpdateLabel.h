//
//  ScoreUpdateLabel.h
//  GameHack
//
//  Created by Oliver Foggin on 13/07/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ScoreUpdateLabel : CCNode

@property (nonatomic, strong) CCLabelTTF *label;
@property (nonatomic) int score;

@end
