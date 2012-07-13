#import "Animal.h"
#import "CCDirectorIOS.h"
#import "CCTouchDispatcher.h"

@implementation Animal

@synthesize touchEnabled = _touchEnabled;

#pragma mark Object lifecycle
- (id)init
{
  self = [super init];
  if (self) {    
  }
  return self;
}

- (void)dealloc
{
  NSLog(@"Dealloc called on animal");
  [super dealloc];
}

#pragma mark Properties
- (BOOL)touchEnabled
{
  return _touchEnabled;
}

- (void)setTouchEnabled:(BOOL)touchEnabled
{
  if (touchEnabled) {
    [[[CCDirectorIOS sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
  } else {
    [[[CCDirectorIOS sharedDirector] touchDispatcher] removeDelegate:self];
  }
  _touchEnabled = touchEnabled;
}

#pragma mark Touch
- (CGRect)rect
{
  CGSize s = [self.sprite contentSize];
  return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

- (BOOL)containsTouchLocation:(UITouch *)touch
{
  return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

- (void)onEnter
{
  self.touchEnabled = YES;
  [super onEnter];
}

- (void)onExit
{
  self.touchEnabled = NO;
  [super onExit];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
  NSLog(@"ccTouchBegan Called");
  if ( ![self containsTouchLocation:touch] ) return NO;
  [self wasTouched];
  NSLog(@"ccTouchBegan returns YES");
  return YES;
}

//- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
//{
//  CGPoint touchPoint = [touch locationInView:[touch view]];
//  touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
//  
//  NSLog(@"ccTouch Moved is called");
//}
//
//- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
//{
//  NSLog(@"ccTouchEnded is called");
//}

- (void) wasTouched
{
  // We are no longer interested in touches, stop accepting them
  self.touchEnabled = NO;
  [self stopAllActions];
  self.state = AnimalStateCaptured;
}

#pragma mark - walking path

- (void)walkPath:(NSArray *)pathArray
{
    CGPoint startPoint = [pathArray[0] CGPointValue];
  
    // Move to the start
    self.position = startPoint;
  
    // Get the actions to move along the path
    NSMutableArray *actions = [self actionsForPath:pathArray withLoop:NO];

    id arrived = [CCCallBlock actionWithBlock:^{
      NSLog(@"Baaaaa! Made it! Phew!");
      [self removeFromParentAndCleanup:YES];
        [[GameManager sharedInstance] lostLives:self.livesLostOnEscape];
    }];
    
    [actions addObject:arrived];
  
    id sequence = [CCSequence actionWithArray:actions];

    [self runAction:sequence];
}

- (NSMutableArray *)actionsForPath:(NSArray *)pathPoints withLoop:(BOOL)loops
{
  CGPoint startPoint = [pathPoints[0] CGPointValue];
  
  NSInteger targetIndex = 1;
  
  NSMutableArray *actions = [NSMutableArray array];
  
  for (NSInteger i=targetIndex; i<[pathPoints count]; i++) {
    id rotation = [CCRotateTo actionWithDuration:0.3 angle:[self angleFromPoint:[pathPoints[i-1] CGPointValue] to:[pathPoints[i] CGPointValue]]];
    id transform = [CCMoveTo actionWithDuration:1.0 position:[pathPoints[i] CGPointValue]];
    
    [actions addObject:rotation];
    [actions addObject:transform];
  }
  
  if (loops) {
    id rotation = [CCRotateTo actionWithDuration:0.3 angle:[self angleFromPoint:[pathPoints[[pathPoints count]-1] CGPointValue] to:startPoint]];
    id transform = [CCMoveTo actionWithDuration:1.0 position:startPoint];
    
    [actions addObject:rotation];
    [actions addObject:transform];
  }
  
  return actions;
}

- (float)angleFromPoint:(CGPoint)from to:(CGPoint)to
{
    CGPoint desiredDirection = [self normalizeVector:ccpSub(to, from)];
    return [self angleForVector:desiredDirection];
}

- (CGPoint)normalizeVector:(CGPoint)vector
{
    float length = sqrtf(vector.x*vector.x+vector.y*vector.y);
    if (length < 0.000001) {
        return ccp(0, 1);
    }
    return ccpMult(vector, 1/length);
}

- (float)angleForVector:(CGPoint)vector
{
    float alfa = atanf(vector.x/vector.y)*180/M_PI;
    if (vector.y < 0) {
        alfa = alfa + 180;
    }
    return alfa;
}

@end
