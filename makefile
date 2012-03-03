在linux下面，我们不得不自己写makefile，makefile的确博大精深，但是实际上对于日常的使用来说，无非就是
1：编译可执行程序。2：编译lib库 3：编译so库
本博针对上面三种目的各自写出了makefile模版，希望对大家有所帮助。
一.编译可执行程序
当前目录下制定文件编译成可执行文件（连接外部库的话只需要更改INC和LIB即可）

CXX = g++
TARGET = bitmaploctest
C_FLAGS += -g -Wall
LIB_FLAGS = -pthread
all: $(TARGET)
bitmaploctest: bitmaploctest.o bitmaploc.o file_lock.o
    $(CXX) -o $@ $^ $(LIB_FLAGS) $(LIB) $(C_FLAGS)
.cpp.o:
    $(CXX) -c -o $*.o $(INC) $(C_FLAGS) $*.cpp
.cc.o:
    $(CXX) -c -o $*.o $(INC) $(C_FLAGS) $*.cc
clean:
    -rm -f *.o $(TARGET)

二.编译成lib库
当前目录下指定文件编译成lib库(一般lib库在编译的时候不会将使用的外部库编译进来，而是等编译成可执行程序时或者.so时)

INC_DIR= ./
SRC_DIR= ./
OBJ_DIR= ./
LIB_DIR= ./
H_DIR= ./
OBJ_EXT= .o
CXXSRC_EXT= .cpp
CSRC_EXT= .c
LIB_EXT= .a
H_EXT= .h
OBJECTS = $(OBJ_DIR)bitmaploc$(OBJ_EXT) \
          $(OBJ_DIR)file_lock$(OBJ_EXT)
LIB_TARGET = $(LIB_DIR)libbitmaploc$(LIB_EXT)
$(OBJ_DIR)%$(OBJ_EXT): $(SRC_DIR)%$(CXXSRC_EXT)
    @echo
    @echo “Compiling $< ==> $@…”
    $(CXX) $(INC) $(C_FLAGS) -c $< -o $@
    $(OBJ_DIR)%$(OBJ_EXT): $(SRC_DIR)%$(CSRC_EXT)
    @echo
    @echo “Compiling $< ==> $@…”
    $(CC) -I./ $(INC) $(C_FLAGS) -c $< -o $@
    all:$(LIB_TARGET)
    $(LIB_TARGET): $(OBJECTS)
    all: $(OBJECTS)
    @echo
    $(AR) rc $(LIB_TARGET) $(OBJECTS)
    @echo “ok”
clean:
    rm -f $(LIB_TARGET) $(OBJECTS)

三.编译成so库
当前目录下指定文件编译成so库（必须将所有引用的外部库都编译进来）

CC = gcc
CXX = g++
CFLAGS  = -Wall -pipe -DDEBUG -D_NEW_LIC -g -D_GNU_SOURCE -shared -D_REENTRANT
LIB     = -lconfig -ldl -lrt -L../../lib -lttc -g
INCLUDE = -I../spp_inc
OO    = service.o tinystr.o tinyxml.o tinyxmlerror.o tinyxmlparser.o uin_conf.o stat.o
TARGETS = ../../lib/libRanch.so
all: $(TARGETS)
    stat:tool_stat.cpp
    $(CXX) $(INCLUDE) tool_stat.cpp -o tool_stat stat.o tinystr.o tinyxml.o tinyxmlerror.o tinyxmlparser.o -g
    cp tool_stat ../../bin
    $(TARGETS): $(OO)
    $(CXX) $(CFLAGS) $(INCLUDE) $(OO) -o $@ $(LIBDIR) $(LIB)
.c.o:
    $(CC)  $(CFLAGS) -c $(INCLUDE) $<
    echo $@
.cpp.o:
    $(CXX) $(CFLAGS) -c $(INCLUDE) $<
    echo $@
    %:%.c
    $(CC) $(CFLAGS) -o $@ $< $(OO) $(LDFLAGS)
    echo $@
clean:
    rm -f *.o
    rm -f $(TARGETS)
    rm -f tool_stat

OK，我常用的makefile也就这三种格式，希望对大家有用。

版权所有，转载请注明出处。http://www.vimer.cn
