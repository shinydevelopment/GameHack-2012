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

@end
