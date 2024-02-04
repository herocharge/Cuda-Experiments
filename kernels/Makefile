CC=g++
NVCC=nvcc
CC_FLAGS=-shared -lcudart
NVCC_FLAGS=-I include/ -Xcompiler -fPIC
BENCH_FLAGS=-I include
LFLAGS=-lcudart
LDLIBS=-lcudart


# Define BENCH_NAME while calling make bench ;; TODO: make a proper bench binary
bench: lib
	export LD_LIBRARY_PATH="bin/"
	$(CC) $(BENCH_FLAGS) -c benchmarks/$(BENCH_NAME) -o bin/bench.o
	$(CC) $(LFLAGS) -o bench bin/bench.o  bin/libpopkern.a $(LDLIBS)

lib: vector
	$(CC) $(CC_FLAGS) -o bin/libpopkern.o bin/vector.o
	ar rvs bin/libpopkern.a bin/libpopkern.o

vector:
	$(NVCC) $(NVCC_FLAGS) -c src/vector.cu -o bin/vector.o

clean:
	@rm bin/* bench