//
//  ScoreUpdateLabel.m
//  GameHack
//
//  Created by Oliver Foggin on 13/07/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ScoreUpdateLabel.h"


@implementation ScoreUpdateLabel

- (id)init
{
    self = [super init];
    if (self) {
        _label = [CCLabelTTF labelWithString:@"Lives Left: 5" fontName:@"Marker Felt" fontSize:32];
        _label.position = ccp(0,0);
        _label.color = ccc3(255, 255, 255);
        [self addChild:_label];
    }
    return self;
}

@end
