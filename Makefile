#
#	gr-scan - A GNU Radio signal scanner
#	Copyright (C) 2012  Nicholas Tomlinson
#	
#	This program is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	(at your option) any later version.
#	
#	This program is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#	
#	You should have received a copy of the GNU General Public License
#	along with this program.  If not, see <http://www.gnu.org/licenses/>. 
#

VERSION=2022092201
CXXFLAGS=-DVERSION="\"gr-scan $(VERSION)\"" -I/usr/local/include  -Wall -g -std=c++11 -Wno-unused-function
LDFLAGS=$(CXXFLAGS) -lstdc++ -llog4cpp -lboost_system -lgnuradio-blocks -lgnuradio-pmt -lgnuradio-fft -lgnuradio-filter -lgnuradio-osmosdr -lgnuradio-runtime -lpython3.8 -L/usr/local/lib/x86_64-linux-gnu

gr-scan: main.o scanner_sink.o topblock.o
	g++ -o gr-scan main.o scanner_sink.o topblock.o $(LDFLAGS)

main.o: main.cpp *.hpp
	g++ $(CXXFLAGS) -c -o main.o main.cpp

scanner_sink.o: scanner_sink.cpp *.hpp
	g++ $(CXXFLAGS) -c -o scanner_sink.o scanner_sink.cpp

topblock.o: topblock.cpp *.hpp
	g++ $(CXXFLAGS) -c -o topblock.o topblock.cpp

clean:
	rm -f gr-scan main.o gr-scan.tar.gz

dist:
	mkdir gr-scan-$(VERSION)
	cp *.cpp *.hpp Makefile COPYING gr-scan-$(VERSION)
	tar -cf - gr-scan-$(VERSION) | gzip -9 -c - > gr-scan-$(VERSION).tar.gz
	rm -r gr-scan-$(VERSION)
