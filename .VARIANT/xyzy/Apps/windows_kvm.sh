export QEMU_PA_SAMPLES=128
export QEMU_AUDIO_DRV=alsa

nohup qemu-system-x86_64 \
  -boot order=c \
  -drive file="/home/Windows/win_disk",format=raw,aio=native,cache.direct=on \
  -m 8192 \
  -smp 8,sockets=1,cores=8,threads=1 \
  -cpu host,kvm=off,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time \
  -vga virtio -display gtk,gl=on \
  -machine type=q35,accel=kvm  \
  -enable-kvm \
  -device intel-iommu \
  -usbdevice tablet \
  -soundhw ac97 \
  -net nic -net user \
  | sudo tee /var/log/WinQEMU.log
