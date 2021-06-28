LOCAL = ./ZeroWars.sdd
ZKMAPSPATH = /mnt/c/Program\ Files\ \(x86\)/Steam/steamapps/common/Zero-K/maps

install: clean
	cp -a ${LOCAL} ${ZKMAPSPATH}

clean:
	rm -rf ${ZKMAPSPATH}/${LOCAL}

zip:
	7z a -ms=off ZeroWars.dev.sd7 ${LOCAL}/*