export QEMU_PA_SAMPLES=128
export QEMU_AUDIO_DRV=alsa

qemu-system-x86_64 \
  -boot order=d \
  -drive if=pflash,format=raw,file=/media/Storage/Virtual/ovmf_vars_x64.bin \
  -drive if=pflash,format=raw,readonly,file=/media/Storage/Virtual/ovmf_code_x64.bin \
  -drive file="/media/Storage/Virtual/win_10.qcow2",aio=native,cache.direct=on \
  -cdrom "/media/Storage/Virtual/Win10_1703_SingleLang_EnglishInternational_x64.iso" \
  -m 8192 \
  -smp 4,sockets=1,cores=4,threads=1 \
  -cpu host,kvm=off,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time \
  -vga virtio -display gtk,gl=on \
  -machine type=q35,accel=kvm  \
  -enable-kvm \
  -device intel-iommu -usbdevice tablet \
  -device vfio-pci,host=01:00.0 \
  -soundhw hda \
  -net nic -net user \
  | sudo tee /var/log/WinQEMU.log
