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

@property (nonatomic, strong) NSArray *wayPoints;
@property (nonatomic) int targetIndex;
@property (nonatomic) CGPoint velocity;
@property (nonatomic) float speed;
@property (nonatomic) float radius;
@property (nonatomic) float distance;
@property (nonatomic) float angle;
@property (nonatomic) float noise;
@property (nonatomic) CGPoint targetLoc;

- (void)walkPath:(NSArray*)pathArray;

// whether or not it will receive Touch events. You can enable / disable touch events with this property. Only the touches of this node will be affected. This “method” is not propagated to its children.
@property (assign) BOOL touchEnabled;

@end
