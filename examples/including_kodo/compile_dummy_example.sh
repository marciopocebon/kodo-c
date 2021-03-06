#!/bin/bash

# INCLUDEPATHS
KODOC_INCLUDE=../../src
DUMMY_INCLUDE=dummy_library/src

# STATIC LIB PATH
STATIC_LIBS=../../static_libs
# Remove old binaries
rm -f dummy.o libdummy.a program

echo
echo "######## Compiling dummy object file (dummy.o)..."

gcc -x c -c -Wall \
-I$KODOC_INCLUDE \
-o dummy.o \
dummy_library/dummy.c

echo "######## Creating dummy statib library..."

# create static library from object file
ar rcs libdummy.a dummy.o

# make sure we dont use dummy.o file
rm -f dummy.o

echo "######## Compiling main.c to program..."

g++ -x c -Wall \
-I$DUMMY_INCLUDE \
-L. \
-L$STATIC_LIBS \
-o program \
desktop/main.c \
-ldummy \
-lkodoc_static \
-lfifi \
-lcpuid

echo "######## Running program..."

./program

rm -f ./program

echo "######## Finished."
echo # more space :)
