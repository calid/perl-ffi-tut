all:
	rm -f /tmp/libfoo.so && \
	gcc -g3 -O0 -shared -fPIC foo.c -o /tmp/libfoo.so
