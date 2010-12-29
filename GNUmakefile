GNUSTEP_MAKEFILES ?= /usr/share/GNUstep/Makefiles

include $(GNUSTEP_MAKEFILES)/common.make

APP_NAME = Sudoku
Sudoku_HEADERS = AppController.h puzzleBoard.h
Sudoku_OBJC_FILES = main.m AppController.m puzzleBoard.m
Sudoku_RESOURCE_FILES = sudokuInfo.plist ./gameFiles/*

include $(GNUSTEP_MAKEFILES)/application.make