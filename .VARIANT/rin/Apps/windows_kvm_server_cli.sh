export QEMU_PA_SAMPLES=128
export QEMU_AUDIO_DRV=alsa

tput reset;

qemu-system-x86_64 \
  -boot order=d \
  -device virtio-scsi-pci,id=scsi \
  -drive file="/media/Storage/Virtual/win_server_cli.img",format=raw,aio=native,cache.direct=on \
  -m 8192 \
  -smp 4,sockets=1,cores=2,threads=2 \
  -cpu host,kvm=off,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time \
  -vga virtio -display gtk,gl=on \
  -machine type=q35,accel=kvm  \
  -enable-kvm \
  -usbdevice tablet \
  -soundhw ac97 \
  -net nic -net user \
  | sudo tee /var/log/WinQEMU.log
