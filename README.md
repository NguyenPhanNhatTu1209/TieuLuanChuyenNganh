## Đề tài khóa luận tốt nghiệp
### Tên đề tài: Xây ựng ứng di động bán thực phẩm tươi sống
#### Nhóm thực hiện: Nhóm 4

#### Người thực hiện:
* Nguyễn Phan Nhật Tú - 18110232 :books:
* Võ Ngọc Nghĩa- 18110164 :books:

### Hướng dẫn cài đặt

#### Backend
●	Tạo file .env bằng cấp với folder .env
	- Thêm các thuộc tính: 
```
	ACCESS_TOKEN_SECRET= ( một mã bí mật để tạo token)
	JWT_KEY= ( một key để mã hóa và giải mã jwt)
	MONGO_URI= ( link database)
	PORT= 3005
	BUCKET = ( Tạo một bucket ở aws sẽ có các thuộc tính bucket)
	REGION = ( Lấy thuộc tính region trong bucket mới tạo ở trên)
	AWS_ACCESS_KEY = ( Lấy thuộc tính access key trong bucket mới tạo ở trên)
	AWS_SECRET_KEY = ( Lấy thuộc tính secret key trong bucket mới tạo ở trên)
	Email = (Email để gửi dùng email cho các tài khoản user)
	Password = (Password của email)
	ID_Client= ( Tạo tài khoản Paypal sandbox để lấy thuộc tính ID_Client)
	Secret= ( Lấy thuộc tính Secret khi tạo tài khoản paypal sandbox)
	API_GHTK= ( Đăng ký tài khoản Giao hàng tiết kiệm để lấy mã api của GHTK)
	Account_SID= ( Đăng ký tài khoản twillo để có được thuộc tính accoun Account_SID)
	Auth_Token= ( Lấy thuộc tính AuthToken sau khi tạo xong tài khoản twillo)
	Phone=( Sau khi tạo xong tài khoản đăng ký số điện thoại để gửi sms về cho điện thoại )
```
●	 Mở terminal chạy lệnh yarn để cài toàn bộ thư viện

●	Chạy lệnh yarn dev để chạy source

●	Nếu deploy lên sever thì chạy lệnh yarn pm2 để chạy pm2

#### Frontend
##### Flutter
●	Cài đặt ngôn ngữ Dart và Flutter (https://dart.dev/get-dart)

●	Mở VSCode, chọn File – Open folder chọn folder flutter_FreshFood

●	Vào file pubspec.yaml nhấn "Ctrl + F5" để cài toàn bộ thư viện

●	Chọn và mở giả lập di động lên hoặc gắn trực tiếp điện thoại cá nhân 

●	Tiến hành chạy ứng dụng bằng cách vào file main.dart bấm  “Ctrl + F5” hoặc Run/Run Without Debugging trên VSCode (Lưu ý chọn loại code Flutter/Dart)


#### Frontend
##### ReactJS 
Deploy: https://fresh-food-b8c94.web.app

●	Mở terminal chạy lệnh yarn để cài toàn bộ thư viện

●	Chạy lệnh yarn start để chạy app

●	Chạy lệnh yarn build để build app
