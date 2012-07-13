//
//  DecorationLayer.m
//  GameHack
//
//  Created by Oliver Foggin on 12/07/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DecorationLayer.h"


@implementation DecorationLayer

- (id)init
{
    self = [super init];
    if (self) {
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite *bgImage = [CCSprite spriteWithFile:@"Background.png"];
        bgImage.position = ccp(size.width * 0.5, size.height * 0.5);
        [self addChild:bgImage];
      
        CCSprite *paddockImage = [CCSprite spriteWithFile:@"Paddock.png"];
        paddockImage.position = ccp(size.width * 0.5, size.height * 0.5);
        [self addChild:paddockImage];
    }
    return self;
}

@end
