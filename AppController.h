////////////////////////////////////////////////////////////////////////////////
/// @file AppController.h
/// @author Michael Wisely
/// @brief Header for AppController class
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @class AppController
/// @brief The central class for the application. It houses the window, menus, 
///        and buttons, as well as an instance of the PuzzleBoard
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @fn applicationWillFinishLaunching: (NSNotification *) notification
/// @brief sets up the UI elements of the window and any other pre-launch prep
/// @pre none
/// @post a Window is created and menus are created and set up
/// @param notification, an NSNotification
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @fn applicationDidFinishLaunching: (NSNotification *) notification
/// @brief sets the window as the key item
/// @pre appWillFinish was called and items are set up
/// @post the created window is made key and ordered front
/// @param notification, an NSNotification
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @fn open: (NSString *) fileName
/// @brief reads in a sudoku file and fills in the board
/// @pre none
/// @post the AppController's board object is filled in according to the file
/// @param fileName, the entire path of the file, including the name.
///        for example, /home/bob/UnfinishedPuzzles/hard.sudoku
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @fn setEasy: (id)sender
/// @brief sets the current difficulty to easy
/// @pre none
/// @post the AppController's current difficulty is set to easy/novice
/// @param sender
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @fn setMedium: (id)sender
/// @brief sets the current difficulty to medium
/// @pre none
/// @post the AppController's current difficulty is set to medium/intermediate
/// @param sender
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @fn setHard: (id)sender
/// @brief sets the current difficulty to hard
/// @pre none
/// @post the AppController's current difficulty is set to hard/expert
/// @param sender
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @fn loadNewGame: (id)sender
/// @brief opens an arbitrary game from a directory of premade games
/// @pre none
/// @post the AppController's board object is filled in according to a randomly
///       chosen game file of the specified difficulty
/// @paran sender
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @fn presentOpenMenu: (id)sender
/// @brief opens the game specified by the user
/// @pre the user has saved some past game which they can open
/// @post the AppController's board object is filled in according to the file
/// @paran sender
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @fn presentSaveMenu: (id)sender
/// @brief saves the game to a location specified by the user
/// @pre none
/// @post the AppController's board object is saved to disk
/// @paran sender
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @fn solve: (id)sender
/// @brief solves the sudoku puzzle entered in the matrix
/// @pre none
/// @post the AppController's puzzle is solved
/// @param sender
////////////////////////////////////////////////////////////////////////////////

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
  PuzzleBoard *board; //! An NSMatrix subclass
  NSButton *easy;
  NSButton *medium;
  NSButton *hard;
  NSString *current_diff; //! Current difficulty
}

-(void) applicationWillFinishLaunching: (NSNotification *) notification;
-(void) applicationDidFinishLaunching: (NSNotification *) notification;
-(void) open: (NSString*) fileName;
-(void) loadNewGame: (id)sender;
-(void) setEasy: (id)sender;
-(void) setMedium: (id)sender;
-(void) setHard: (id)sender;
-(void) presentOpenMenu:(id)sender;
-(void) solve: (id)sender;

@end

#endif
