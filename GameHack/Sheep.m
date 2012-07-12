#import "Sheep.h"

NSUInteger const SheepPoints = 100;

@implementation Sheep

#pragma mark Object lifecycle
- (id)init
{
  self = [super init];
  if (self) {
    // Load sheep sprite
    self.sprite = [CCSprite spriteWithFile:@"Sheep.png"];
      
    [self addChild:self.sprite];
  }
  return self;
}

#pragma mark Properties
- (NSUInteger)points
{
  return SheepPoints;
}

#pragma mark Cocos2d drawing stuff

//! called once per frame. time a value between 0 and 1
//! For example:
//! * 0 means that the action just started
//! * 0.5 means that the action is in the middle
//! * 1 means that the action is over
//-(void) update: (ccTime) time
//{
//
//}

#pragma mark Touch methods
- (void) wasTouched
{
  // We are no longer interested in touches, stop accepting them
  self.touchEnabled = NO;
  [self stopAllActions];
  self.state = AnimalStateCaptured;
  
  // nothing in animal classes, subclasses implement
  NSLog(@"Baaaa, I was touched");
  

  CGPoint penPoint = ccp(self.parent.contentSize.width/2, self.parent.contentSize.height/2);
 
  CGFloat distanceToCenter = ccpDistance(penPoint, self.position) / ccpDistance(penPoint, CGPointZero);
  // Takes two seconds from the very edge of the screen.  Faster if closer.
  CGFloat time = 2.0 * distanceToCenter;

  // Rotate to look at the pen
  id rotate = [CCRotateTo actionWithDuration:0.2 angle:CC_RADIANS_TO_DEGREES(atan2(penPoint.x - self.position.x,penPoint.y - self.position.y))];
  
  // Scale up and back to original over the time it takes to get back to pen
  id scaleUp = [CCScaleTo actionWithDuration:time/2 scale:1.5];
  id scaleDown = [CCScaleTo actionWithDuration:time/2 scale:1];
  id scale = [CCSequence actionWithArray:@[rotate, scaleUp, scaleDown]];
  
  // Move to pen
  id moveTo = [CCMoveTo actionWithDuration:time position: penPoint];
  
  // Scale and move at the same time
  id spawnAction = [CCSpawn actionWithArray:@[scale, moveTo]];

  // After in pen, callback to let us know
  id actionCallFunc = [CCCallFunc actionWithTarget:self selector:@selector(wasMovedToPen)];
  id actionSequence = [CCSequence actionWithArray:@[spawnAction, actionCallFunc]];

  [self runAction:actionSequence];
  
}

- (void) wasMovedToPen
{
  self.state = AnimalStateInPen;
  NSLog(@"Baaa, I'm stuck in a pen");
}


@end
