#import "Wolf.h"
#import "PathManager.h"
#import "Sheep.h"

NSUInteger const WolfPoints = 0;

@implementation Wolf

#pragma mark Object lifecycle
- (id)init
{
  self = [super init];
  if (self) {
    // Load wolf sprite
    self.sprite = [CCSprite spriteWithFile:@"Wolf1.png"];
      
      [self animate];
      
    [self addChild:self.sprite];
    self.livesLostOnEscape = 0;
    // Wolf isn't worth any points
  }
  return self;
}

- (void)animate
{
    self.animation = [CCAnimation animation];
    self.animation.delayPerUnit = 0.2;
    
    [self.animation addSpriteFrameWithFilename:@"Wolf1.png"];
    [self.animation addSpriteFrameWithFilename:@"Wolf2.png"];
    
    id animate = [CCAnimate actionWithAnimation:self.animation];
    
    id animateForever = [CCRepeatForever actionWithAction:animate];
    
    [self.sprite runAction:animateForever];
}

#pragma mark Properties
- (NSUInteger)points
{
  return WolfPoints;
}

#pragma mark Cocos2d drawing stuff

//! called once per frame. time a value between 0 and 1
//! For example:
//! * 0 means that the action just started
//! * 0.5 means that the action is in the middle
//! * 1 means that the action is over
-(void) update: (ccTime) time
{
  
}

#pragma mark Touch methods
- (CGRect)rect
{
  // hack, make wolf easier to tap by redefining rect from animal.
  CGSize s = [self.sprite contentSize];
  return CGRectMake(-s.width / 2, -s.height / 2, s.width*5, s.height*2);
}


- (void) wasTouched
{
  [super wasTouched];
  
  NSLog(@"Wolf, I was touched");
  
  CGPoint penPoint = ccp(self.parent.contentSize.width/2, self.parent.contentSize.height/2);
  
  CGFloat distanceToCenter = ccpDistance(penPoint, self.position) / ccpDistance(penPoint, CGPointZero);
  // Takes two seconds from the very edge of the screen.  Faster if closer.
  CGFloat time = 1.0 * distanceToCenter;
  
  // Rotate to look at the pen
  id rotate = [CCRotateTo actionWithDuration:0.1 angle:CC_RADIANS_TO_DEGREES(atan2(penPoint.x - self.position.x,penPoint.y - self.position.y))];
  
  // Scale up and back to original over the time it takes to get back to pen
  id scaleUp = [CCScaleTo actionWithDuration:time/2 scale:2];
  id scaleDown = [CCScaleTo actionWithDuration:time/2 scale:1];
  id scale = [CCSequence actionWithArray:@[rotate, scaleUp, scaleDown]];
  
  // Move to pen
  id moveTo = [CCMoveTo actionWithDuration:time position: penPoint];
  
  // Scale and move at the same time
  id spawnAction = [CCSpawn actionWithArray:@[scale, moveTo]];
  
  // After in pen, callback to let us know
  id actionCallFunc = [CCCallFunc actionWithTarget:self selector:@selector(wasMovedToPen)];
  
  id callBack = [CCCallBlock actionWithBlock:^{
    id shake1 = [CCMoveBy actionWithDuration:0.05 position:ccp(10, 5)];
    id shake2 = [CCMoveBy actionWithDuration:0.05 position:ccp(-5, -10)];
    id shake3 = [CCMoveBy actionWithDuration:0.05 position:ccp(-5, 5)];
    id sequence1 = [CCSequence actionWithArray:@[ shake1, shake2, shake3 ]];
    
    id grow = [CCScaleTo actionWithDuration:0.075 scale:1.05];
    id shrink = [CCScaleTo actionWithDuration:0.075 scale:1];
    id sequence2 = [CCSequence actionWithArray:@[ grow, shrink ]];
    
    id shakeAction = [CCSpawn actionWithArray:@[ sequence1, sequence2 ]];
    
    [[[CCDirector sharedDirector] runningScene] runAction:shakeAction];
  }];
    
  id actionSequence = [CCSequence actionWithArray:@[spawnAction, callBack, actionCallFunc]];
  
  [self runAction:actionSequence];
  
}

- (void) wasMovedToPen
{
  self.state = AnimalStateInPen;
  NSLog(@"Wolf, I'm in the pen, time to eat");
  [[GameManager sharedInstance] updateScore:-100.0];
  [self walkPenPath];
}

// Walk and eat some sheep in the pen
- (void)walkPenPath
{
  
  NSArray *pathArray = [[PathManager sharedInstance] arrayWithPaddockWaypoints];
  
  NSMutableArray *actions = [self actionsForPath:pathArray withLoop:YES];
  
  // Move to the first point in the path
  CGPoint firstPoint = [pathArray[0] CGPointValue];
  id rotation = [CCRotateTo actionWithDuration:0.3 angle:[self angleFromPoint:self.position to:firstPoint]];
  id transform = [CCMoveTo actionWithDuration:0.5 position:firstPoint];
  id moveToFirstPoint = [CCSequence actionWithArray:@[rotation, transform]];
  
  // Run around 3 times and eat three sheep
  id arrived = [CCCallBlock actionWithBlock:^{
    // Take a life
    [[GameManager sharedInstance] lostLives:1];
    
    // Run around the pen three times
    // Cull a sheep each time (if there is one available)
    id killSheep = [CCCallBlock actionWithBlock:^{
      [Sheep cullSheepInPenInLayer:(CCLayer *)self.parent];
    }];
    
    id fasterWolf = [CCSequence actionWithArray:actions];
    
    // Run around 3 times and kill 3 sheep
    id repeatSequence = [CCRepeat actionWithAction:[CCSequence actionWithArray:@[killSheep,fasterWolf]] times:3];
    
    id wolfDies = [CCCallBlock actionWithBlock:^{
      id fadeOut = [CCFadeOut actionWithDuration:1.5];
      id remove = [CCCallBlock actionWithBlock:^{
        [self removeFromParentAndCleanup:YES];
      }];
      
      [self.sprite runAction:[CCSequence actionWithArray:@[fadeOut, remove]]];

    }];
    
    id fullAnimation = [CCSpeed actionWithAction:[CCSequence actionWithArray:@[repeatSequence, wolfDies]] speed:5];
    
    // Run around then die
    [self runAction:fullAnimation];
  }];
  
  // move to first position
  [self runAction:[CCSequence actionWithArray:@[moveToFirstPoint, arrived]]];
}

@end
