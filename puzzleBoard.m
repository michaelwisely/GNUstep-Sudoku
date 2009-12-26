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

-(void) solve: (id) sender
{
  
}

-(Boolean) solvePuzzleBoardStartingAtRow:(NSInteger) row column:(NSInteger) column
{
  NSInteger i = 1;

  while(![[self cellAtRow:row column:column] isEditable])
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
    return true;
  }

  for(; i<10; i++)
  {
    if([self iCanPut:i atRow:row column:column])
    {
      [[self cellAtRow:row column:column] setStringValue:[NSString stringWithFormat:@"%c", i]];

      if(column < 8)
      {
        if ([self solvePuzzleBoardStartingAtRow:row column: column+1])
        {
          return true;
        }
      }
      else
      {
        if ([self solvePuzzleBoardStartingAtRow:row+1 column: 0])
        {
          return true;
        }
      }
    }
  }
  if([[self cellAtRow:row column:column] isEditable])
  {
    [[self cellAtRow:row column:column] setStringValue:[NSString stringWithString:@"0"]]
  }
  return false;
}


@end
