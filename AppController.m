#include "AppController.h"

@implementation AppController

-(void) applicationWillFinishLaunching: (NSNotification *) notification
{
  NSSize size;
  [NSApp setMainMenu:[self createMenus]];

  window = [[NSWindow alloc] initWithContentRect: NSMakeRect(100, 100, 500, 600)
                                        styleMask: (NSTitledWindowMask |
                                                    NSMiniaturizableWindowMask |
                                                    NSResizableWindowMask)
                                          backing: NSBackingStoreBuffered
                                            defer: YES];
  [window setTitle: @"Sudoku!"];
  [window setMaxSize: NSMakeSize(500,600)];
  [window setMinSize: NSMakeSize(500,600)];
  
  easy = [NSButton new];
  [easy setButtonType:NSRadioButton];
  [easy setTitle:@"Easy"];
  [easy setFont:[NSFont labelFontOfSize:36]];
  [easy sizeToFit];
  [easy setTarget: self];
  [easy setAction: @selector(setEasy:)];
  size = [easy frame].size;
  [easy setFrame: NSMakeRect(5, 520, size.width, size.height)];
  [easy setState: 1];

  medium = [NSButton new];
  [medium setButtonType:NSRadioButton];
  [medium setTitle:@"Medium"];
  [medium setFont:[NSFont labelFontOfSize:36]];
  [medium sizeToFit];
  [medium setTarget: self];
  [medium setAction: @selector(setMedium:)];
  size = [medium frame].size;
  [medium setFrame: NSMakeRect(180, 520, size.width, size.height)];
  [medium setState:0];

  hard = [NSButton new];
  [hard setButtonType:NSRadioButton];
  [hard setTitle:@"Hard"];
  [hard setFont:[NSFont labelFontOfSize:36]];
  [hard sizeToFit];
  [hard setTarget: self];
  [hard setAction: @selector(setHard:)];
  size = [hard frame].size;
  [hard setFrame: NSMakeRect(400, 520, size.width, size.height)];
  [hard setState:0];

  current_diff = [[NSString alloc] initWithString: @"novice"];

  board = [[PuzzleBoard alloc]init];
  
  [[window contentView] addSubview: board];
  [[window contentView] addSubview: easy];
  [[window contentView] addSubview: medium];
  [[window contentView] addSubview: hard];
}

-(void) applicationDidFinishLaunching: (NSNotification *) notification
{
  [window makeKeyAndOrderFront: self];
}

-(void) setEasy: (id)sender
{
  NSLog(@"SET EASY!");
  [easy setState:1];
  [medium setState:0];
  [hard setState:0];

  RELEASE(current_diff);
  current_diff = @"novice";
}

-(void) setMedium: (id)sender
{
  NSLog(@"SET MEDIUM!");
  [easy setState:0];
  [medium setState:1];
  [hard setState:0];

  RELEASE(current_diff);
  current_diff = @"intermediate";
}

-(void) setHard: (id)sender
{
  NSLog(@"SET HARD!");
  [easy setState:0];
  [medium setState:0];
  [hard setState:1];

  RELEASE(current_diff);
  current_diff = @"expert";
}


-(void) solve: (id) sender
{
  [board clear];
  [board solvePuzzleBoardStartingAtRow:0 column:0];
  [board selectAll:nil];
}

-(void) loadNewGame: (id)sender
{
  srand(time(NULL));
  int index = rand()%3; 
  NSMutableString* fileName = [[NSMutableString alloc] init];

  [fileName appendFormat:@"%i.%@", index, current_diff];
  
  NSLog(@"Opening %@", fileName);

  @try
  {
    [self open:fileName];
  }
  @catch(NSException *e)
  {
    NSLog(@"%@ \n%@", [e name], [e reason]);
  }

  RELEASE(fileName);
}

-(void) presentOpenMenu: (id)sender
{
  //Currently you must open from the gamefiles folder. is there a way it can
  //pull the logs from /Resources instead?
  //  Well, saves make it a little different. They just open the files 
  //  they were working on. They don't really NEED to open the blanks.

  NSMutableString* path;

  NSLog(@"Presenting Open Panel");
  NSOpenPanel* fileSelector = [NSOpenPanel openPanel];
  [fileSelector setAllowsMultipleSelection: NO];
  [fileSelector setCanChooseFiles: YES];
  [fileSelector setCanChooseDirectories: NO];

  [fileSelector runModalForDirectory: nil
		file: nil 
		types: [NSArray arrayWithObjects:
				  @"novice",
				@"intermediate",
				@"expert",
				@"sudoku",
				nil]];

  path = [NSMutableString stringWithString: [[fileSelector filenames] 
					      objectAtIndex: 0 ]];
  [self open: [path lastPathComponent]];
}

-(void) presentSaveMenu: (id)sender
{
  NSInteger i = 0, j = 0;
  NSMutableString *data = [[NSMutableString alloc] init];

  NSLog(@"Presenting Open Panel");
  NSSavePanel* fileSelector = [NSSavePanel savePanel];
  [fileSelector setRequiredFileType:@"sudoku"];

  [fileSelector runModal];

  for(; i < 9; i++ )
  {
    j = 0;
    for(; j < 9; j++ )
    {
      if( ![[board cellAtRow: i column: j] isEditable] )
      {
	[data appendFormat: @"P%i", [[board cellAtRow:i column: j] intValue]];
      }

      else
      {
	[data appendString: @"U"];
	if ( [[[board cellAtRow: i column: j] stringValue] length] < 1 )
        {
	  [data appendString: @"X"];
	} 
	else
	{
	  [data appendFormat:@"%i", [[board cellAtRow: i column: j] intValue]];
	}
      }
    }
  }


  NSLog(@"Creating file at %@",[fileSelector filename]);

  [[NSFileManager defaultManager] createFileAtPath: [fileSelector filename]
				  contents: [data dataUsingEncoding: NSASCIIStringEncoding]
				  attributes: nil];

  RELEASE(data);
}



-(NSMenu* ) createMenus
{
   NSMenu *menu;
   NSMenu *difficulty;
   NSMenu *file;

   menu = [NSMenu new];
   [menu addItemWithTitle: @"File"
	 action: NULL
	 keyEquivalent: @""];

   [menu addItemWithTitle: @"Difficulty"
	 action: NULL
	 keyEquivalent: @""];

   [menu addItemWithTitle: @"Hide"
	 action: @selector(hide:)
	 keyEquivalent: @"h"];

   [menu addItemWithTitle: @"Solve"
	 action: @selector(solve:)
	 keyEquivalent:@""];

   [menu addItemWithTitle: @"Quit"
	 action: @selector(terminate:)
	 keyEquivalent: @"q"];

   file = [NSMenu new];
   [file addItemWithTitle: @"New"
	 action: @selector(loadNewGame:)
	 keyEquivalent: @"n"];

   [file addItemWithTitle: @"Open"
	 action: @selector(presentOpenMenu:)
	 keyEquivalent: @"o"];

   [file addItemWithTitle: @"Save"
	 action: @selector (presentSaveMenu:)
	 keyEquivalent: @"s"];

   difficulty = [NSMenu new];
   [difficulty addItemWithTitle: @"Easy"
	       action: @selector(setEasy:)
	       keyEquivalent: @""];
   [difficulty addItemWithTitle: @"Medium"
	       action:@selector(setMedium:)
	       keyEquivalent: @""];
   [difficulty addItemWithTitle: @"Hard"
	       action:@selector(setHard:)
	       keyEquivalent: @""];

   [menu setSubmenu: file 
	 forItem: [menu itemWithTitle:@"File"]];
   [menu setSubmenu: difficulty 
	 forItem: [menu itemWithTitle:@"Difficulty"]];

   RELEASE(file);
   RELEASE(difficulty);
   
   return menu;
}


-(void) open: (NSString*) fileName
{
  NSFileHandle *readHandle;
  NSData *rawData;
  NSString *data;
  NSMutableString *path;
  unichar temp;
  unsigned int charIndex = 0;
  
  path = [[NSMutableString alloc]init];
  [path appendString: [[NSFileManager defaultManager] currentDirectoryPath]];
  [path appendFormat: @"/gameFiles/%@", fileName];
  //"gameFiles" is for debug purposes, it should otherwise be @"/Resources/%@"
 
  readHandle = [NSFileHandle fileHandleForReadingAtPath:path];

  if (readHandle == nil)
  {
    [NSException raise:@"Invalid Path" 
		 format:@"The file you wish to open is not at %@", path];
  }

  rawData = [readHandle readDataToEndOfFile];
  
  data=[[NSString alloc]initWithData:rawData encoding:NSASCIIStringEncoding];

  NSLog(data);
  
  NSInteger i=0, j=0;
  
  for(; i < 9; i++ )
  {
    j = 0;
    for(; j < 9; j++ )
    {
      temp = [data characterAtIndex: charIndex ];
      //P's are puzzle defined
      if( temp == 'P' )
      {
	charIndex += 1;
        //if it was a P, then we place that number on the board and
        //disable the users ability to write or edit that box.
        temp = [data characterAtIndex: charIndex];
	[[board cellAtRow: i column:j] setStringValue: [NSString stringWithFormat: @"%c", temp]];
        [[board cellAtRow:i column:j] setEditable: NO];
      }

      else
      {
	charIndex += 1;
        //if it wasn’t a P, then it is a user editable box
        temp = [data characterAtIndex: charIndex];
        //if the next character is an X, then the square is blank
        if( temp == 'X' )
        {
	  [[board cellAtRow:i column:j] setStringValue: @""];
        }
        //otherwise, place the users number into the square
        else
        {
	  [[board cellAtRow:i column:j] setStringValue: [NSString stringWithFormat: @"%c", temp]];
        }
 	if (![[board cellAtRow:i column:j] isEditable])
	{
	  [[board cellAtRow:i column:j] setEditable: YES];
	}
      }
      charIndex += 1;
    }
  }
  [board selectAll:nil];
}

-(void) dealloc
{
  RELEASE(board);
  RELEASE(easy);
  RELEASE(window);
  [super dealloc];
}
@end
