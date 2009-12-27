#include "puzzleBoard.h"


@implementation PuzzleBoard

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
    if([self iCanPut:i atRow:row column:column])
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

-(BOOL) iCanPut:(NSInteger)value atRow:(NSInteger)row column:(NSInteger)column
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
