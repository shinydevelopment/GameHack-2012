#import "cocos2d.h"

enum {
  AnimalStateNone,
  AnimalStateWalking,
  AnimalStateCaptured,
  AnimalStateInPen
};
typedef NSInteger AnimalStates;

@interface Animal : CCNode <CCTargetedTouchDelegate>

@property (strong) CCSprite *sprite;
@property (assign) AnimalStates state;
@property (assign) ccTime startTime;
@property (readonly) NSUInteger points;
@property (assign) NSInteger livesLostOnEscape;

- (void)walkPath:(NSArray*)pathArray;
- (NSMutableArray *)actionsForPath:(NSArray *)pathPoints withLoop:(BOOL)loops;
- (float)angleFromPoint:(CGPoint)from to:(CGPoint)to;
- (void) wasTouched;

// whether or not it will receive Touch events. You can enable / disable touch events with this property. Only the touches of this node will be affected. This “method” is not propagated to its children.
@property (assign) BOOL touchEnabled;


@end
