# Makefile

SRCS	= repair.cpp cfg2txt.cpp encoder.cpp decoder.cpp bits.cpp
REPAIR	= repair despair
CFG	= txt2cfg cfg2txt cfg2enc txt2enc enc2txt

OBJS	= $(SRCS:%.cpp=%.o)
CC	= gcc
CXX = g++
CFLAGS	= -O3 -DNDEBUG
CXXFLAGS = -O2 -std=c++11 -g3 -pthread
LIB	= -lm

all: $(REPAIR)

cfg: $(CFG)

repair: main.cpp repair.o encoder.o bits.o
	$(CXX) $(CXXFLAGS) -DREPAIR -o $@ main.cpp repair.o encoder.o bits.o $(LIB)

despair: main.cpp decoder.o bits.o
	$(CXX) $(CXXFLAGS) -DDESPAIR -o $@ main.cpp decoder.o bits.o $(LIB)

txt2enc: main.cpp repair.o encoder.o bits.o
	$(CXX) $(CXXFLAGS) -DTXT2ENC -o $@ main.cpp repair.o encoder.o bits.o $(LIB)

enc2txt: main.cpp decoder.o bits.o
	$(CXX) $(CXXFLAGS) -DENC2TXT -o $@ main.cpp decoder.o bits.o $(LIB)

txt2cfg: main.cpp repair.o
	$(CXX) $(CXXFLAGS) -DTXT2CFG -o $@ main.cpp repair.o $(LIB)

cfg2txt: cfg2txt.o
	$(CXX) $(CXXFLAGS) -o $@ cfg2txt.o $(LIB)

cfg2enc: main.cpp encoder.o bits.o
	$(CXX) $(CXXFLAGS) -DCFG2ENC -o $@ main.cpp encoder.o bits.o $(LIB)

clean:
	-rm -f $(REPAIR) $(CFG) $(OBJS)  *~

.cpp.o:
	$(CXX) $(CXXFLAGS) -c $<

repair.o: repair.hpp basics.hpp
cfg2txt.o: basics.hpp
encoder.o: encoder.hpp basics.hpp
decoder.o: decoder.hpp basics.hpp
bits.o: bits.hpp basics.hpp

