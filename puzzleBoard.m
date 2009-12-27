#include "puzzleBoard.h"


@implementation PuzzleBoard

////////////////////////////////////////////////////////////////////////////////
/// @fn -init
/// @brief initializes the board with all editable cells with specific format
/// @pre none
/// @post a new PuzzleBoard object is initialized
////////////////////////////////////////////////////////////////////////////////
-(id) init
{
  NSCell* tempCell = [[NSCell alloc] initTextCell: @""];

  [tempCell setEditable:YES];
  [tempCell setBezeled:YES];
  [tempCell setFont:[NSFont labelFontOfSize:36]];
  [tempCell setAlignment: NSCenterTextAlignment];

  [self initWithFrame: NSMakeRect(0, 0, 500, 500)
	mode: NSTrackModeMatrix
	prototype: tempCell
	numberOfRows: 9
	numberOfColumns: 9];

  RELEASE(tempCell);

  return self;
}

////////////////////////////////////////////////////////////////////////////////
/// @fn -clear
/// @brief iterates a PuzzleBoard, clearing every user-editable space
/// @pre none
/// @post the PuzzleBoard shows only game entries.
////////////////////////////////////////////////////////////////////////////////
-(void) clear
{
  NSInteger i=0, j=0;
  for(; i < 9; i+=1)
  {
    for(;j < 9; j+=1)
    {
      if([[self cellAtRow:i column:j]isEditable])
      {
	[[self cellAtRow:i column:j] setStringValue:@""];
      }
    }
  }
}

////////////////////////////////////////////////////////////////////////////////
/// @fn -solvePuzzleBoardStartingAtRow:(NSInteger) row column:(NSInteger) column
/// @brief a recursive method which solves the puzzleboard
/// @pre none
/// @post the puzzleboard is solved!
/// @param row, column = 0,0 to properly solve
/// @return a boolean which signifies if the puzzle was solved or not
////////////////////////////////////////////////////////////////////////////////
-(BOOL) solvePuzzleBoardStartingAtRow:(NSInteger) row column:(NSInteger) column
{
  NSInteger i = 1;

  while(![[self cellAtRow:row column:column] isEditable] &&
	column < 9 && 
	row < 9)
  {
    if(column < 8)
    {
      column+=1;
    }
    else
    {
      column = 0;
      row+=1;
    }
  }

  if(row > 8 || column > 8)
  {
    return YES;
  }

  for(; i<10; i++)
  {
    if([self canIPut:i atRow:row column:column])
    {
      [[self cellAtRow:row column:column] setStringValue:[NSString stringWithFormat:@"%i", i]];

      if(column < 8)
      {
        if ([self solvePuzzleBoardStartingAtRow:row column: column+1])
        {
          return YES;
        }
      }
      else
      {
        if ([self solvePuzzleBoardStartingAtRow:row+1 column: 0])
        {
          return YES;
        }
      }
    }
  }
  if([[self cellAtRow:row column:column] isEditable])
  {
    [[self cellAtRow:row column:column] setStringValue:@""];
  }
  return NO;
}

////////////////////////////////////////////////////////////////////////////////
/// @fn -canIPut:(NSInteger)value 
///      atRow:(NSInteger)row 
///      column:(NSInteger)column
/// @brief determines if value can be placed at the specified row and column
/// @param row, column, values are NSIntegers representing the requested 
///        row and column, as well as the value which is attempted to place
/// @return a boolean which signifies whether the value can be placed there
////////////////////////////////////////////////////////////////////////////////
-(BOOL) canIPut:(NSInteger)value atRow:(NSInteger)row column:(NSInteger)column
{
  BOOL ret_val = NO;

  if([self checkSubSquareatRow:row column:column digit:value] && 
     [self checkRow:row digit:value] && 
     [self checkColumn:column digit:value])
  {
    ret_val = YES;
  }

  return ret_val;

}
 
////////////////////////////////////////////////////////////////////////////////
/// @fn -checkSubSquareatRow:(NSInteger)row 
///      column:(NSInteger)column 
///      digit:(NSInteger)digit
/// @brief determines if value can be placed in the specified sub-square
/// @param row, column, values are NSIntegers representing the requested 
///        row and column, as well as the value which is attempted to place
/// @return a boolean which signifies whether the value can be placed there
////////////////////////////////////////////////////////////////////////////////
-(BOOL) checkSubSquareatRow:(NSInteger)row column:(NSInteger)column digit:(NSInteger)digit
{
  NSInteger rowIndex = (row/3)*3;
  NSInteger rowStop = rowIndex+3;
  NSInteger columnIndex = (column/3)*3;
  NSInteger columnStop = columnIndex+3;
  NSInteger columnTemp;
  BOOL ret_val = YES;

  for(; rowIndex<rowStop; rowIndex+=1)
  {
    columnTemp = columnIndex;
    for(; columnTemp<columnStop; columnTemp++)
    {
      if([[self cellAtRow:rowIndex column:columnTemp]intValue] == digit)
      {
        ret_val = NO;
      }
    }
  }

  return ret_val;
}


////////////////////////////////////////////////////////////////////////////////
/// @fn -checkRow:(NSInteger)row digit:(NSInteger)digit
/// @brief determines if value can be placed in the specified row
/// @param row and values are NSIntegers representing the requested row and 
///        the value which is attempted to place
/// @return a boolean which signifies whether the value can be placed there
////////////////////////////////////////////////////////////////////////////////
-(BOOL) checkRow:(NSInteger)row digit:(NSInteger)digit
{
  BOOL ret_val = YES;
  NSInteger i = 0;

  for (; i<9; i+=1)
  {
    if([[self cellAtRow:row column:i]intValue] == digit)
    {
      ret_val = NO;
    }
  }

  return ret_val;
}

////////////////////////////////////////////////////////////////////////////////
/// @fn -checkColumn:(NSInteger)column digit:(NSInteger)digit
/// @brief determines if value can be placed in the specified row
/// @param column and values are NSIntegers representing the requested column and 
///        the value which is attempted to place
/// @return a boolean which signifies whether the value can be placed there
////////////////////////////////////////////////////////////////////////////////
-(BOOL) checkColumn:(NSInteger)column digit:(NSInteger)digit
{
  BOOL ret_val = YES;
  NSInteger i = 0;

  for (; i<9; i+=1)
  {
    if([[self cellAtRow:i column:column]intValue] == digit)
    {
      ret_val = NO;
    }
  }

  return ret_val;
}

@end
