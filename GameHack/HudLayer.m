//
//  HudLayer.m
//  GameHack
//
//  Created by Oliver Foggin on 12/07/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HudLayer.h"

@implementation HudLayer

- (id)init
{
    self = [super init];
    if (self) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        _scoreLabel = [CCLabelTTF labelWithString:@"Score: 0" fontName:@"Marker Felt" fontSize:32];
        _scoreLabel.position = ccp(100, size.height - 100);
        _scoreLabel.color = ccc3(255, 255, 255);
        [self addChild:_scoreLabel];
        
        _livesLabel = [CCLabelTTF labelWithString:@"Lives Left: 5" fontName:@"Marker Felt" fontSize:32];
        _livesLabel.position = ccp(size.width - 100, size.height - 100);
        _livesLabel.color = ccc3(255, 255, 255);
        [self addChild:_livesLabel];
    }
    return self;
}

- (void)updateScoreLabelWithScore:(int)score
{
    [_scoreLabel setString:[NSString stringWithFormat:@"Score: %i", score]];
}

- (void)updateLivesLabelWithLives:(int)lives
{
    [_livesLabel setString:[NSString stringWithFormat:@"Lives Left: %i", lives]];
}

@end
