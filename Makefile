# Makefile.

SHELL = '/bin/sh'

CXX = g++

CXXFLAGS = -g -O2

LIBEV = third_party/libev-3.8

BOOST = third_party/boost-1.37.0

# Add . to CXXFLAGS.
CXXFLAGS += -I.

# Add libev to CXXFLAGS.
CXXFLAGS += -I$(LIBEV)

# Add Boost to CXXFLAGS.
CXXFLAGS += -I$(BOOST)

# Add dependency tracking to CXXFLAGS.
CXXFLAGS += -MMD -MP

LIB_OBJ = process.o record-process.o
LIB = libprocess.a

default: all

-include $(patsubst %.o, %.d, $(LIB_OBJ))

$(LIB_OBJ): %.o: %.cpp 
	$(CXX) -c $(CXXFLAGS) -o $@ $<

$(LIB): $(LIB_OBJ)
	$(AR) rcs $@ $^

third_party:
	$(MAKE) -C $(LIBEV)

all: third_party $(LIB)

clean:
	$(MAKE) -C $(LIBEV) clean
	rm -rf $(patsubst %.o, %.d, $(LIB_OBJ)) $(LIB_OBJ) $(LIB)

.PHONY: default third_party all clean