#import "Sheep.h"
#import "PathManager.h"

NSUInteger const SheepPoints = 100;

@implementation Sheep

#pragma mark Object lifecycle
- (id)init
{
  self = [super init];
  if (self) {
    // Load sheep sprite
    self.sprite = [CCSprite spriteWithFile:@"Sheep.png"];
    self.livesLostOnEscape = 1;
    [self addChild:self.sprite];
  }
  return self;
}

#pragma mark Class methods
+ (void)cullSheepInLayer:(CCLayer *)layer
{
  const NSInteger maxSheepInPen = 5;
  NSMutableArray *caughtSheep = [Sheep sheepInPenInlayer:layer];
  
  Sheep *sheep;
  if ([caughtSheep count] > maxSheepInPen) {
    for (NSInteger killIndex=maxSheepInPen; killIndex < [caughtSheep count]; killIndex++) {
      sheep = (Sheep *)caughtSheep[killIndex];
      [sheep cull];
    }
  }
  
  NSLog(@"Culling some sheep");
}

+ (NSMutableArray *)sheepInPenInlayer:(CCLayer *)layer
{
  NSMutableArray *caughtSheep = [NSMutableArray array];
  Sheep *sheep;
  for (CCNode *child in layer.children) {
    if ([child isKindOfClass:[Sheep class]]) {
      sheep = (Sheep *)child;
      if (sheep.state == AnimalStateInPen) {
        [caughtSheep addObject:sheep];
      }
    }
  }
  return caughtSheep;
}

+ (void)cullSheepInPenInLayer:(CCLayer *)layer
{
  NSMutableArray *caughtSheep = [Sheep sheepInPenInlayer:layer];
  [(Sheep *)[caughtSheep lastObject] cull];
  NSLog(@"WOLF KILLED SHEEP!");
}

- (void)cull
{
  id fadeOut = [CCFadeOut actionWithDuration:1.5];
  id remove = [CCCallBlock actionWithBlock:^{
    [self removeFromParentAndCleanup:YES];
  }];
  
  [self.sprite runAction:[CCSequence actionWithArray:@[fadeOut, remove]]];
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

- (void)animateLabelWithScore:(int)score
{
    __block CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", score] fontName:@"Marker Felt" fontSize:16];
    [label setColor:ccc3(255, 255, 255)];
    label.position = self.position;
    label.scale = 0;
    
    id transform = [CCMoveBy actionWithDuration:0.3 position:ccp(0, 10)];
    id scale = [CCScaleTo actionWithDuration:0.5 scale:2];
    
    id spawn = [CCSpawn actionWithArray:@[ transform, scale ]];
    
    id fade = [CCFadeOut actionWithDuration:0.2];
    
    id callBlock = [CCCallBlock actionWithBlock:^{
        [label removeFromParentAndCleanup:YES];
    }];
    
    id sequence = [CCSequence actionWithArray:@[spawn, fade, callBlock]];
    
    [self.parent addChild:label];
    [label runAction:sequence];
}

#pragma mark Touch methods
- (void) wasTouched
{
  [super wasTouched];
  
  // nothing in animal classes, subclasses implement
    NSLog(@"Baaaa, I was touched");
    [[GameManager sharedInstance] updateScore:self.points];
    
    [self animateLabelWithScore:self.points];
  

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
  [self walkPenPath];
}

- (void)walkPenPath
{

  NSArray *pathArray = [[PathManager sharedInstance] arrayWithPaddockWaypoints];
  
  NSMutableArray *actions = [self actionsForPath:pathArray withLoop:YES];
  
  // Move to the first point in the path
  CGPoint firstPoint = [pathArray[0] CGPointValue];
  id rotation = [CCRotateTo actionWithDuration:0.3 angle:[self angleFromPoint:self.position to:firstPoint]];
  id transform = [CCMoveTo actionWithDuration:1.0 position:firstPoint];
  id moveToFirstPoint = [CCSequence actionWithArray:@[rotation, transform]];
  
  // Have to do this as a block as we can't have repeat forever in a sequence
  id arrived = [CCCallBlock actionWithBlock:^{
    id repeatSequence = [CCRepeatForever actionWithAction:[CCSequence actionWithArray:actions]];
    [self runAction:repeatSequence];
  }];
  
  // move then repeat forever
  [self runAction:[CCSequence actionWithArray:@[moveToFirstPoint, arrived]]];
}


@end
