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
  // nothing in animal classes, subclasses implement
}

#pragma mark - walking path

- (void)walkPath:(NSArray *)pathArray
{
    self.wayPoints = [[NSArray alloc] initWithArray:pathArray];
    
    CGPoint startPoint = [self.wayPoints[0] CGPointValue];
    self.targetIndex = 1;
    
    self.position = startPoint;
    
    NSMutableArray *actions = [NSMutableArray array];
    
    for (int i=self.targetIndex; i<[self.wayPoints count]; i++) {
        id rotation = [CCRotateTo actionWithDuration:0.3 angle:[self angleFromPoint:[self.wayPoints[i-1] CGPointValue] to:[self.wayPoints[i] CGPointValue]]];
        id transform = [CCMoveTo actionWithDuration:1.0 position:[self.wayPoints[i] CGPointValue]];
        
        [actions addObject:rotation];
        [actions addObject:transform];
    }
    
    id arrived = [CCCallBlock actionWithBlock:^{
        NSLog(@"Baaaaa! Made it! Phew!");
    }];
    
    [actions addObject:arrived];
    
    id sequence = [CCSequence actionWithArray:actions];
    
    [self runAction:sequence];
}

- (float)angleFromPoint:(CGPoint)from to:(CGPoint)to
{
    CGPoint desiredDirection = [self normalizeVector:ccpSub(to, from)];
    CGPoint velocity = ccpMult(desiredDirection, self.speed);
    return [self angleForVector:velocity];
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
