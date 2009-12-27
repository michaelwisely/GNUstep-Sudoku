////////////////////////////////////////////////////////////////////////////////
/// @file main.m
/// @brief Contains the main funcion.
////////////////////////////////////////////////////////////////////////////////

#include "AppController.h"
#include <AppKit/AppKit.h>

int main(int argc, const char *argv[]) 
{
   NSAutoreleasePool *pool;
   AppController *delegate;
   
   pool = [[NSAutoreleasePool alloc] init];
   delegate = [[AppController alloc] init];

   [NSApplication sharedApplication];
   [NSApp setDelegate: delegate];

   RELEASE(pool);
   return NSApplicationMain (argc, argv);
}
