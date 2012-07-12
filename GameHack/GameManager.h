//
//  GameManager.h
//  GameHack
//
//  Created by Oliver Foggin on 13/07/2012.
//
//

#import <Foundation/Foundation.h>

@interface GameManager : NSObject

@property (nonatomic) int score;
@property (nonatomic) int livesLeft;

- (void)newGame;

- (void)updateScore:(int)points;
- (void)updateLives:(int)livesLost;

+ (GameManager *)sharedInstance;

@end
