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
        
        _scoreLabel = [CCLabelTTF labelWithString:@"Score: 0" fontName:@"Marker Felt" fontSize:40];
        _scoreLabel.anchorPoint = ccp(0, 1);
        _scoreLabel.position = ccp(20, size.height - 20);
        _scoreLabel.color = ccc3(0, 0, 0);
        [self addChild:_scoreLabel];
        
        _livesLabel = [CCLabelTTF labelWithString:@"Lives Left: 5" fontName:@"Marker Felt" fontSize:40];
        _livesLabel.anchorPoint = ccp(1, 1);
        _livesLabel.position = ccp(size.width - 20, size.height - 20);
        _livesLabel.color = ccc3(0, 0, 0);
        [self addChild:_livesLabel];
        
        [[GameManager sharedInstance] addObserver:self forKeyPath:@"score" options:NSKeyValueObservingOptionNew context:NULL];
        
        [[GameManager sharedInstance] addObserver:self forKeyPath:@"livesLeft" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"score"]) {
        [self updateScoreLabelWithScore:[change[@"new"] intValue]];
    }
    
    if ([keyPath isEqualToString:@"livesLeft"]) {
        [self updateLivesLabelWithLives:[change[@"new"] intValue]];
    }
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
