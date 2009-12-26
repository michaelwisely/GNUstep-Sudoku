#ifndef _AppController_H_
#define _AppController_H_

#include "puzzleBoard.h"
#include <stdlib.h>
#include <time.h>
#include <Foundation/NSObject.h>
#include <AppKit/AppKit.h>

@class NSWindow;
@class NSTextField;
@class NSNotification;

@interface AppController : NSObject
{
  NSWindow *window;
  PuzzleBoard *board;
  NSButton *easy;
  NSButton *medium;
  NSButton *hard;
  NSString *current_diff;
}

-(void)applicationWillFinishLaunching: (NSNotification *) notification;
-(void)applicationDidFinishLaunching: (NSNotification *) notification;
-(NSMenu*) createMenus;
-(void) open: (NSString*) fileName;
-(void) loadNewGame: (id)sender;
-(void) setEasy: (id)sender;
-(void) setMedium: (id)sender;
-(void) setHard: (id)sender;

@end

#endif
