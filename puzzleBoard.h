#ifndef _PuzzleBoard_H_
#define _PuzzleBoard_H_

#include <AppKit/NSMatrix.h>
#include <AppKit/NSCell.h>

@interface PuzzleBoard : NSMatrix
{
}

-(id) init;
-(BOOL) solvePuzzleBoardStartingAtRow:(NSInteger) row column:(NSInteger) column;
-(BOOL) iCanPut:(NSInteger)value atRow:(NSInteger)row column:(NSInteger)column;
-(BOOL) checkSubSquareatRow:(NSInteger)row column:(NSInteger)column digit:(NSInteger)digit;
-(BOOL) checkRow:(NSInteger)row digit:(NSInteger)digit;
-(BOOL) checkColumn:(NSInteger)column digit:(NSInteger)digit;

@end

#endif
