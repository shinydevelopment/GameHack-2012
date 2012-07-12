#import "cocos2d.h"

enum {
  AnimalStateNone,
  AnimalStateCaptured
};
typedef NSInteger AnimalStates;

@interface Animal : CCNode <CCTargetedTouchDelegate>

@property (strong) CCSprite *sprite;
@property (assign) AnimalStates *state;
@property (assign) ccTime startTime;
@property (readonly) NSUInteger points;
@property (assign) CGPathRef *path;

@end
