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


@end
