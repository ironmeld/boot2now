# This Makefile builds helloworld by bootstrapping
# a C like compiler (M2-Mesoplanet) using the stage0-posix
# project source code and then compiling helloworld.c

helloworld: helloworld.src builder-hex0/builder-hex0-self-built.bin
	builder-hex0/build.sh builder-hex0/builder-hex0-self-built.bin helloworld.src helloworld
	chmod u+x ./helloworld
	./helloworld

helloworld.src: helloworld.c after.kaem stage0-posix.src
	# include the helloworld.c source
	echo -n "src " > helloworld.src
	wc -c ./helloworld.c >> helloworld.src
	cat ./helloworld.c >> helloworld.src
	# after.kaem builds and runs helloworld
	echo -n "src " >> helloworld.src
	wc -c ./after.kaem >> helloworld.src
	cat ./after.kaem >> helloworld.src
	# this builds M2-Mesoplanet compiler and runs after.kaem
	cat stage0-posix.src >> helloworld.src

stage0-posix.src: gather-source.sh
	./gather-source.sh > stage0-posix.src

builder-hex0/builder-hex0-self-built.bin:
	make -C builder-hex0 builder-hex0-self-built.bin

clean:
	make -C builder-hex0 clean
	rm -f *.log *.img *.src helloworld
