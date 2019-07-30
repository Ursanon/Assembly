#Windows 10 x64
#NASM
#GCC

FILENAME=$1

mkdir build

nasm -fwin64 $FILENAME.asm
gcc -m64 $FILENAME.obj -o build/$FILENAME
./build/$FILENAME.exe