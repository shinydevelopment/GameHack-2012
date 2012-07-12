//
//  HudLayer.h
//  GameHack
//
//  Created by Oliver Foggin on 12/07/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HudLayer : CCLayer

@property (nonatomic, strong) CCLabelTTF *scoreLabel;
@property (nonatomic, strong) CCLabelTTF *livesLabel;

- (void)updateScoreLabelWithScore:(int)score;
- (void)updateLivesLabelWithLives:(int)lives;

@end
