#!/bin/bash

# Đảm bảo đã load module MSR
if ! lsmod | grep -q msr; then
    echo "[INFO] Loading msr module..."
    sudo modprobe msr
fi

# Đọc MSR_RAPL_POWER_UNIT để lấy energy unit
unit_hex=$(sudo rdmsr -p 0 0x606)
energy_unit_raw=$(( (0x$unit_hex >> 8) & 0x1F ))
energy_unit=$(echo "scale=10; 1 / (2 ^ $energy_unit_raw)" | bc -l)

# Đọc năng lượng ban đầu
e1=$(sudo rdmsr -p 0 0x611)
sleep 1
# Đọc năng lượng sau 1 giây
e2=$(sudo rdmsr -p 0 0x611)

# Tính chênh lệch năng lượng
delta=$(( 0x$e2 - 0x$e1 ))

# Tính công suất tiêu thụ (Watts)
power=$(echo "$delta * $energy_unit" | bc -l)

echo "CPU Package Power: $power Watts"
