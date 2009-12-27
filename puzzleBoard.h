////////////////////////////////////////////////////////////////////////////////
/// @file puzzleBoard.h
/// @brief Header for PuzzleBoard class
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @class PuzzleBoard
/// @brief A subclass of NSMatrix which has functionality useful for Sudoku
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @fn -init
/// @brief initializes the board with all editable cells with specific format
/// @pre none
/// @post a new PuzzleBoard object is initialized
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @fn -clear
/// @brief iterates a PuzzleBoard, clearing every user-editable space
/// @pre none
/// @post the PuzzleBoard shows only game entries.
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @fn -solvePuzzleBoardStartingAtRow:(NSInteger) row column:(NSInteger) column
/// @brief a recursive method which solves the puzzleboard
/// @pre none
/// @post the puzzleboard is solved!
/// @param row, column = 0,0 to properly solve
/// @return a boolean which signifies if the puzzle was solved or not
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @fn -canIPut:(NSInteger)value 
///      atRow:(NSInteger)row 
///      column:(NSInteger)column
/// @brief determines if value can be placed at the specified row and column
/// @param row, column, values are NSIntegers representing the requested 
///        row and column, as well as the value which is attempted to place
/// @return a boolean which signifies whether the value can be placed there
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @fn -checkSubSquareatRow:(NSInteger)row 
///      column:(NSInteger)column 
///      digit:(NSInteger)digit
/// @brief determines if value can be placed in the specified sub-square
/// @param row, column, values are NSIntegers representing the requested 
///        row and column, as well as the value which is attempted to place
/// @return a boolean which signifies whether the value can be placed there
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @fn -checkRow:(NSInteger)row digit:(NSInteger)digit
/// @brief determines if value can be placed in the specified row
/// @param row and values are NSIntegers representing the requested row and 
///        the value which is attempted to place
/// @return a boolean which signifies whether the value can be placed there
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
/// @fn -checkColumn:(NSInteger)column digit:(NSInteger)digit
/// @brief determines if value can be placed in the specified row
/// @param column and values are NSIntegers representing the requested column and 
///        the value which is attempted to place
/// @return a boolean which signifies whether the value can be placed there
////////////////////////////////////////////////////////////////////////////////

#ifndef _PuzzleBoard_H_
#define _PuzzleBoard_H_

#include <AppKit/NSMatrix.h>
#include <AppKit/NSCell.h>

@interface PuzzleBoard : NSMatrix
{
}

-(id) init;
-(void) clear;
-(BOOL) solvePuzzleBoardStartingAtRow:(NSInteger) row column:(NSInteger) column;
-(BOOL) canIPut:(NSInteger)value atRow:(NSInteger)row column:(NSInteger)column;
-(BOOL) checkSubSquareatRow:(NSInteger)row column:(NSInteger)column digit:(NSInteger)digit;
-(BOOL) checkRow:(NSInteger)row digit:(NSInteger)digit;
-(BOOL) checkColumn:(NSInteger)column digit:(NSInteger)digit;

@end

#endif
