#
# Makefile for Cygwin - unrar
#
# Note: you have to 'make clean' before you can build
#	the sfx module
#

# Cygwin using GCC
#CXX=g++
#CXXFLAGS=-O2
DESTDIR=/usr

##########################

COMPILE=$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(DEFINES)
LINK=$(CXX)

WHAT=UNRAR

UNRAR_OBJ=filestr.o recvol.o rs.o scantree.o
LIB_OBJ=filestr.o scantree.o dll.o

OBJECTS=rar.o strlist.o strfn.o pathfn.o savepos.o smallfn.o global.o file.o filefn.o filcreat.o \
	archive.o arcread.o unicode.o system.o isnt.o crypt.o crc.o rawread.o encname.o \
	resource.o match.o timefn.o rdwrfn.o consio.o options.o ulinks.o errhnd.o rarvm.o \
	rijndael.o getbits.o sha1.o extinfo.o extract.o volume.o list.o find.o unpack.o cmddata.o

.cpp.o:
	$(COMPILE) -D$(WHAT) -c $<

all:	unrar

install:	install-unrar

uninstall:	uninstall-unrar

clean:
	@rm -f *.o *.bak *~

unrar:	$(OBJECTS) $(UNRAR_OBJ)
	@rm -f unrar.exe
	$(LINK) -o unrar.exe $(LDFLAGS) $(OBJECTS) $(UNRAR_OBJ) $(LIBS)	

sfx:	WHAT=SFX_MODULE
sfx:	$(OBJECTS)
	@rm -f default.sfx
	$(LINK) -o default.sfx $(LDFLAGS) $(OBJECTS)

lib:	WHAT=RARDLL
lib:	$(OBJECTS) $(LIB_OBJ)
	@rm -f cygunrar.dll
	$(LINK) -shared -Wl,--out-implib,libunrar.dll.a -o cygunrar.dll $(LDFLAGS) $(OBJECTS) $(LIB_OBJ)

install-unrar:
	install -D unrar.exe $(DESTDIR)/bin/unrar.exe

uninstall-unrar:
	rm -f $(DESTDIR)/bin/unrar.exe

install-lib:
	install -D cygunrar.dll $(DESTDIR)/bin/cygunrar.dll
	install -D libunrar.dll.a $(DESTDIR)/lib/libunrar.dll.a
	install -D dll.hpp $(DESTDIR)/include/unrar/dll.hpp

uninstall-lib:
	rm -f $(DESTDIR)/bin/cygunrar.dll
	rm -f $(DESTDIR)/lib/libunrar.dll.a
