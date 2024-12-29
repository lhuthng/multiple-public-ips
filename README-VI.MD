### Yêu cầu
Phần mềm cần thiết: 
- VMWare Workstation Pro
- Ubuntu (ít nhất Ubuntu 20): Để nhanh nhất thì có thể dùng bản Ubuntu 20.04.4 Focal Fossa cài sẵn ở [đây](https://www.osboxes.org/ubuntu/) (chọn bản cho VMWare)
### Tạo máy ảo
Mình chỉ hướng dẫn cài bản cài sẵn cho lẹ như sau
1. Bật VMWare Workstation
2. Chọn File
3. Chọn New Virtual Machine
4. Đánh vào dấu Custom (Advanced) để dùng bản cài sẵn
5. Bấm *next* cho **Virtual machine hardware compability**
6. Đánh dấu vào *I will install the operating system later*
7. **Guest operating system** là *linux* và **Version** là *Ubuntu*
8. Đặt tên máy ảo và vị trí lưu máy ảo
9. **Processors** tạm thời cứ để *2* và *1*
10. **Memory** tạm thời cứ để mặc định *4GB RAM* nhưng mà để thấp hơn cũng được miễn từ *2*
11. **Network connection** chọn *Use bridged networking*
12. **SCSI Controller** để mặc định *LSI Logic*
13. **Disk** thì chọn *Use a physical disk (for advanced users)*
14. **Existing disk file** thì chọn đường dẫn tới tập tin *Ubuntu 20.04.4 (64 bit)* sau khi giải nén file *64bit.zip*
15. Khi *next* cứ chọn *Keep Existing Format*
16. *Finish*
### Chỉnh máy ảo
0.
    1. Chọn máy ảo mới tạo rồi chọn *Power on this virtual machine*
    2. Nếu máy hỏi **Do you want to try to connect to this virtual device everytime you power on the virtual machine?** thì cứ chọn *Yes*
    3. Tài khoản mặc định là osboxes:osboxes.org (id là osboxes, password là osboxes.org)
    4. Password nếu bị hỏi là osboxes.org và nhập Y nếu bị hỏi yes/no
1. Vừa vào nó có bảng Online Accounts thì tắt nhanh nó bằng cách chuột phải vô hình tròn màu trắng trong một vòng tròn màu cam và chọn *Quit*
2. Bật **Terminal** bằng cách chuột phải vô màn hình rồi bấm *Open in Terminal*
3. Cài Git để tải lệnh từ trên này xuống với lệnh sau
```bash
sudo apt update
sudo apt install git -y
```
4. Tải các câu lệnh xuống với lệnh sau
```bash
git clone https://github.com/lhuthng/multiple-public-ips.git
```
5. Một thư mục **multiple-public-ips** xuất hiện trên màn hình
6. Trở ra với VMWare Workstation, Chọn Edit -> Virtual Network Editor...
7. Chọn **Change settings** để chỉnh sửa cách adapter mạng (và cho phép thực thi nếu bị hỏi)
8. Đổi **VMnet0** với **Bridge to: ** tới mang wifi của bạn, *Ethernet* không hoặc động
9. Tạo ra thêm nhiều adapter mạng bởi nút **Add Network..**, mình sẽ dùng từ 10 đến 15 cho 6 adapter mạng. Nhớ để tất cả adapter mạng mới là *Host-only*
10. Để đó và quay lại với máy ảo
11. Bật thư mục lên và chuột phải chọn **Open in Terminal**
12. Cấp quyền thực thi cho tất cả các lệnh bằng lệnh sau
```bash
sudo chmod u+x *.sh
```
13. Cài các phần mềm cần thiết bằng lệnh sau
```bash
./_install_dependencies.sh
```
14. Cài WARP bằng lệnh sau (Ghi Y và enter nếu được hỏi Yes/No)
```bash
./_install_warp.sh
```
15. Kết nối 3 adapter mạng vào máy ảo bằng cách sau
    1.  Chuột phải vào máy ảo và chọn **Settings**
    2.  Chọn **Add..** và **Network Adapter** 3 lần để có thêm 3 máy ảo 2 3 và 4
    3.  Chỉnh từng **Network Adapter #** với **Network connection** là **Custom** tới **VMnet##** với **##** ứng với 10, 11, và 12
16. Chỉnh 3 adapter mạng của máy chính vào 3 adapter mạng của máy ảo bằng cách sau
    1.  Trong máy ảo ghi lệnh sau để hiện các adapter mạng
    ```bash
    ifconfig
    ```
    2.  Kiểm tra xem có các adapter tên **ens38**, **ens39**, và **ens40** không
        1.  Nếu có thì bỏ qua
        2.  Nếu không có thì phải thay đổi *_connect.sh* cho đúng tên
    3.  Bật **Control Panel** -> **Network and Internet** -> **Network Connections**
    4.  Chuột phải vảo từng **VMware Network Adapter VMnet##** với **##** là số từ 10 đến 12 (Làm từng cái thôi)
    5.  Chon **Properties** 
    6.  Bấm đúp vào **Internet Protocol Version 4 (TCP/IPv4)**
    7.  Đánh dấu vào **Use the following IP Address:** và **Use the following DNS server addresses:**
    8.  Quay lại với bảng ở **Bước 7** kiểm tra tên của adapter mạng với đúng số để lấy 3 số đầu, ví dụ **VMware Network Adapter VMnet10** với **VMnet10** 
    9.  Nhìn vào phần **Subnet IP:** để điền 3 số đầu vào phần **IP address:** và để số cuối là **1**, ví dụ Subnet IP: 192.168.73.0 thì IP address sẽ điền là 192.168.73.1
    10. **Subnet mask:** sẽ tự động được điền sau khi điền **IP address**
    11. Để điền vào **Default gateway:** tìm trong bảng **ifconfig** trong máy ảo trên có IP nào trùng 3 số đầu không thì điền toàn bộ số đó vào, ví dụ có **ens40** có **192.168.73.128** thì điền **192.168.73.128** vào **Default gateway:**
    12. Làm tương tự cho 2 adapter còn lại
17. Xoá GUI để tiết kiệm dung lượng bằng lệnh sau
```bash
./_remove_GUI.sh
```
18. Chuyển mã connect ra ngoài bằng lệnh sau
```bash
mv ./_connect.sh ~/
```
19. Tắt máy ảo bằng lệnh sau
```bash
sudo shutdown now
```
## Giảm CPU và RAM của máy ảo
1. Chuột phải vào máy ảo chọn **Settings**
2. Chỉnh Memory xuồng **468MB** (Hoặc cao hơn nếu có vấn đề về deadlock)
3. Chỉnh Processors xuống **1** **1**
4. Bật thử xem có lên được chỗ đăng nhập không
## Tạo thêm máy ảo từ máy ảo gốc
1. Chuột phải vào máy ảo chọn **Manage** -> **Clone...**
2. *next* *next* *next*, chọn tên và vị trí rồi *close*
## Chỉnh adapter mạng cho máy 2
1. Chuột phải vào máy ảo 2 và chọn **Settings**
2. Đổi 3 **Network Adapter** sang 3 **VMnet** từ 13 đến 15
3. Chạy máy ảo phụ và thực hiện lại bước 16 ở trên để chỉnh lại adapter cho phù hợp
## Đổi mã đăng ký cloudflare cho máy ảo 2
Vì sau khi copy, 2 máy ảo dùng chung 1 tài khoản cloudflare nên cần phải làm mới tài khoản cho máy 2
1. Khởi động máy ảo 2
2. Đăng nhập
3. Vào thư mục hồi nãy tải xuống bằng lệnh
```bash
cd Desktop/multiple-public-ips
./_renew.sh
cd ~
```
## Kết nối tới WARP
Chỉ cần thực thi lệnh sau để kết nối tới WARP
```bash
./_connect.sh
```