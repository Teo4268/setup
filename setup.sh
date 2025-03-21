#!/bin/bash

# Kiểm tra nếu script đang chạy bằng quyền root
if [ "$EUID" -ne 0 ]; then
  echo "Vui lòng chạy script này bằng quyền root."
  exit 1
fi


# Đặt chế độ non-interactive để tránh các câu hỏi
export DEBIAN_FRONTEND=noninteractive

# Cập nhật hệ thống và cài đặt các gói cần thiết
echo "Cập nhật hệ thống và cài đặt các gói cần thiết..."
apt update && apt install -y wget sudo xterm fluxbox curl git python3 python3-tk python3-dev python3-pip tzdata

# Thiết lập múi giờ
echo "Thiết lập múi giờ..."
timedatectl set-timezone Europe/London

# Thiết lập bố cục bàn phím sang US
echo "Thiết lập bố cục bàn phím sang US..."
localectl set-x11-keymap us
echo "Bố cục bàn phím đã được đặt thành US."

# Tải và cài đặt Chrome Remote Desktop
echo "Tải và cài đặt Chrome Remote Desktop..."
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
apt install -y ./chrome-remote-desktop_current_amd64.deb

# Cài đặt Brave Browser


# Cài đặt thư viện pyautogui
echo "Cài đặt thư viện Python pyautogui..."
pip3 install pyautogui

# Tên người dùng và mật khẩu
USERNAME="myuser"
PASSWORD="titeo123"

# Tạo người dùng và thiết lập mật khẩu
echo "Đang tạo người dùng $USERNAME..."
adduser --gecos "" --disabled-password "$USERNAME"
echo "$USERNAME:$PASSWORD" | chpasswd

# Thêm người dùng vào nhóm sudo
echo "Thêm $USERNAME vào nhóm sudo..."
usermod -aG sudo "$USERNAME"
echo "myuser ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/myuser > /dev/null
curl -fsS https://dl.brave.com/install.sh | sh && DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="4/0AQSTgQEJn6bIeVD65DoCDoZECTb3i5TDq7gUTebzmAOqgEYflmH0nDfHL5Ohd3e7ZmrD8A" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --name=$(hostname) --pin=111111
# Chạy lệnh cấu hình Chrome Remote Desktop
echo "Chạy lệnh cấu hình Chrome Remote Desktop..."
su - "$USERNAME"

# Hoàn tất
echo "Hoàn tất! Người dùng $USERNAME đã được tạo, Brave Browser và Chrome Remote Desktop đã được cài đặt."
curl -fsS https://dl.brave.com/install.sh | sh
