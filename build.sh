#!/bin/bash

echo "Making sure a bin directory exists..."
mkdir bin

echo "Making sure a bin directory is empty..."
rm bin/*

CURRENT_DIR="$( pwd )"

echo "Building the C library..."
gcc -arch i386 -c echo.c -o bin/echo.o

echo "Building the dylib..."
gcc -arch i386 \
 -dynamiclib \
 -o bin/libEchoTest.dylib \
 bin/echo.o \
 -install_name $CURRENT_DIR/bin/libEchoTest.dylib
    
echo "Listing the symbols in the dylib..."    
/Applications/Xcode.app/Contents/Developer/usr/bin/nm -g bin/libEchoTest.dylib
    
echo "Setting the path..."
export MONO_PATH=/Applications/MonoDevelop.app/Contents/MacOS/lib/monodevelop/AddIns/MonoDevelop.MonoMac/

echo "Building C# code..."
dmcs /noconfig "/out:bin/Test.exe" \
 "/r:/Library/Frameworks/Mono.framework/Versions/2.10.9/lib/mono/4.0/System.dll" \
 "/r:/Applications/MonoDevelop.app/Contents/MacOS/lib/monodevelop/AddIns/MonoDevelop.MonoMac/MonoMac.dll" \
 /nologo /warn:4 /debug:full /optimize- /codepage:utf8 /platform:x86 /define:DEBUG  /t:exe "Main.cs"

echo "Running..."
mono bin/Test.exe $CURRENT_DIR