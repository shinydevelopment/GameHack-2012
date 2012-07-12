#import "Animal.h"
#import "CCDirectorIOS.h"
#import "CCTouchDispatcher.h"

@implementation Animal

#pragma mark Object lifecycle
- (id)init
{
  self = [super init];
  if (self) {    
  }
  return self;
}

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
  [[[CCDirectorIOS sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
  
  [super onEnter];
}

- (void)onExit
{
  [[[CCDirectorIOS sharedDirector] touchDispatcher] removeDelegate:self];
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
    
    [self scheduleUpdate];
}

- (void)update:(ccTime)dt
{
    if (self.state == AnimalStateNone) {
        self.targetLoc = [self.wayPoints[self.targetIndex] CGPointValue];
        
        CGPoint desiredDirection = [self normalizeVector:ccpSub(self.targetLoc, self.position)];
        self.velocity = ccpMult(desiredDirection, self.speed);
        self.position = ccpAdd(self.position, self.velocity);
        
        self.rotation = [self angleForVector:self.velocity];
        
        float dx = fabsf(self.position.x - self.targetLoc.x);
        float dy = fabsf(self.position.y - self.targetLoc.y);
        
        if (sqrtf(dx*dx+dy*dy) < 10) {
            self.targetIndex++;
        }
        
        if (self.targetIndex >= [self.wayPoints count]) {
            [self unscheduleUpdate];
            NSLog(@"Baaaaa!!! Made it! Phew!");
        }
    }
}

#pragma mark - math

- (float)randFrom:(float)start to:(float)end
{
    float randomFloat = (arc4random()%1000)/1000.0;
    return randomFloat*(end-start)+start;
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
