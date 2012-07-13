@interface PathManager : NSObject

@property (nonatomic) int lastPathIndex;

- (NSArray *)arrayWithGameWaypoints;
- (NSArray *)arrayWithPaddockWaypoints;

+ (PathManager *)sharedInstance;

@end
