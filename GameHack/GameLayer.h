//
//  GameLayer.h
//  GameHack
//
//  Created by Oliver Foggin on 12/07/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HudLayer.h"
#import "DecorationLayer.h"
#import "EntityLayer.h"

@interface GameLayer : CCLayer

@property (nonatomic) int score;
@property (nonatomic) int livesLeft;
@property (nonatomic, strong) HudLayer *hudLayer;
@property (nonatomic, strong) EntityLayer *entityLayer;
@property (nonatomic, strong) DecorationLayer *decorationLayer;

+ (CCScene*)scene;

- (void)livesLost:(int)numberLivesLost;
- (void)updateScore:(int)points;

@end
