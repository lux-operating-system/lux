all:
	@echo "\x1B[0;1;35m [  MAKE ]\x1B[0m lxfs"
	@make -C lxfs
	@echo "\x1B[0;1;35m [  MAKE ]\x1B[0m boot-x86_64"
	@make -C boot-x86_64
	@echo "\x1B[0;1;35m [  MAKE ]\x1B[0m kernel"
	@make -C kernel
	@echo "\x1B[0;1;35m [  MAKE ]\x1B[0m lucerna"
	@make -C lucerna
	@echo "\x1B[0;1;35m [  MAKE ]\x1B[0m install lucerna"
	@make install -C lucerna
	@echo "\x1B[0;1;35m [  MAKE ]\x1B[0m lumen"
	@make -C lumen
	@echo "\x1B[0;1;35m [  MAKE ]\x1B[0m servers"
	@make -C servers
	@echo "\x1B[0;1;35m [  MAKE ]\x1B[0m install servers"
	@make install -C servers
	@echo "\x1B[0;1;35m [  LXFS ]\x1B[0m create"
	@./lxfs/lxfs create lux.hdd 10
	@echo "\x1B[0;1;35m [  LXFS ]\x1B[0m format"
	@./lxfs/lxfs format lux.hdd 9
	@echo "\x1B[0;1;35m [  LXFS ]\x1B[0m mbr"
	@./lxfs/lxfs mbr lux.hdd boot-x86_64/mbr.bin
	@echo "\x1B[0;1;35m [  LXFS ]\x1B[0m boot"
	@./lxfs/lxfs boot lux.hdd 0
	@echo "\x1B[0;1;35m [  LXFS ]\x1B[0m bootsec"
	@./lxfs/lxfs bootsec lux.hdd 0 boot-x86_64/bootsec.bin
	@echo "\x1B[0;1;35m [  LXFS ]\x1B[0m bootblk"
	@./lxfs/lxfs bootblk lux.hdd 0 boot-x86_64/lxboot.bin
	@echo "\x1B[0;1;35m [  LXFS ]\x1B[0m cp lxboot.conf"
	@./lxfs/lxfs cp lux.hdd 0 lxboot.conf lxboot.conf
	@echo "\x1B[0;1;35m [  LXFS ]\x1B[0m cp lux"
	@./lxfs/lxfs cp lux.hdd 0 kernel/lux lux
	@cp lumen/lumen ramdisk/
	@cp -r servers/out/* ramdisk/
	@echo "\x1B[0;1;35m [  TAR  ]\x1B[0m c ramdisk.tar"
	@cd ramdisk; tar --format ustar -c * > ../ramdisk.tar; cd ..
	@echo "\x1B[0;1;35m [  LXFS ]\x1B[0m cp ramdisk.tar"
	@./lxfs/lxfs cp lux.hdd 0 ramdisk.tar ramdisk.tar

clean:
	@echo "\x1B[0;1;35m [  MAKE ]\x1B[0m clean lxfs"
	@make -C lxfs clean
	@echo "\x1B[0;1;35m [  MAKE ]\x1B[0m clean boot-x86_64"
	@make -C boot-x86_64 clean
	@echo "\x1B[0;1;35m [  MAKE ]\x1B[0m clean kernel"
	@make -C kernel clean
	@echo "\x1B[0;1;35m [  MAKE ]\x1B[0m clean lucerna"
	@make -C lucerna clean
	@echo "\x1B[0;1;35m [  MAKE ]\x1B[0m clean lumen"
	@make -C lumen clean
	@echo "\x1B[0;1;35m [  MAKE ]\x1B[0m clean servers"
	@make -C servers clean

toolchain:
	@cd toolchain-x86_64; ./build-toolchain.sh

qemu:
	@qemu-system-x86_64 -monitor stdio -m 512 -drive file=lux.hdd,format=raw -smp 2 -cpu IvyBridge
