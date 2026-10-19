# Quizz

Bấm **F8** (hoặc **F9**) khi đang chơi đố vui trên Slack: Quizz chụp màn hình, nhờ Claude giải câu đố mẹo và **copy đáp án vào clipboard**. Bạn chỉ cần bấm `Ctrl+V` để dán.

| Phím | Chế độ | Thời gian |
|---|---|---|
| F8 | Nhanh | ~1.5 giây |
| F9 | Suy luận sâu, cho câu khó | ~3 giây, tối đa 30 giây |

- **Chọn câu hỏi:** ưu tiên câu trong khung Thread đang mở. Nếu không mở thread nào thì lấy câu mới nhất ở cuối kênh.
- **Loại câu hỏi:** giải được câu đố mẹo (chơi chữ, nói lái, đuổi hình bắt chữ) và trả lời đúng sự thật với câu hỏi kiến thức (ví dụ về ngày 20/10).
- **Kho đáp án:** có sẵn hơn 400 câu (câu đố mẹo và kiến thức 20/10), nạp mỗi lần mở app.

## Yêu cầu

- Windows 10 hoặc 11.
- Tài khoản Claude **Pro, Max, Team hoặc Enterprise** (gói Free không dùng được Claude Code).
  - Quizz dùng tài khoản của chính bạn, không cần API key.
  - Mỗi lần bấm phím trừ vào hạn mức của gói.
  - Nếu gói không dùng được Opus, Quizz tự chuyển sang Sonnet.

## Cài đặt

1. Tải repo về: bấm **Code → Download ZIP** rồi giải nén, hoặc dùng `git clone`. Để thư mục ở chỗ cố định, ví dụ `Documents\quizz`. Sau khi cài thì không xoá hay di chuyển thư mục này.
2. Chuột phải vào thư mục → **Open in Terminal**, rồi chạy:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\install.ps1
   ```
3. Script cài sẽ tự làm 3 việc:
   - Cài Claude Code nếu máy chưa có.
   - Mở trình duyệt để bạn đăng nhập tài khoản Claude của bạn.
   - Tạo shortcut **Quizz** ở Desktop và Start Menu.

## Sử dụng

1. Mở **Quizz** từ Desktop, chờ khoảng 10 giây đến khi hiện "Sẵn sàng".
2. Vào Slack, bấm **F8** khi thấy câu đố. Đáp án hiện trong cửa sổ Quizz và đã nằm sẵn trong clipboard.
3. Muốn thoát thì đóng cửa sổ Quizz hoặc bấm `Ctrl+C`.

**Máy có nhiều màn hình:** mặc định Quizz đọc màn hình chính. Nếu Slack ở màn hình khác, chuột phải shortcut Quizz → **Properties**, rồi thêm ` -Screen 2` vào cuối ô **Target**.

**Thêm câu đố của bạn:** mở `data\cau-do-cua-toi.txt`, mỗi dòng ghi theo dạng `câu hỏi => đáp án`, rồi mở lại Quizz.

## Riêng tư

- **Ảnh gửi đi:** mỗi lần bấm phím, ảnh chụp màn hình được gửi lên Claude qua tài khoản của bạn. Nên đóng những gì nhạy cảm trước khi bấm.
- **Không lưu lại gì trên máy:** ảnh chụp bị xoá ngay sau khi gửi. Khi thoát, Quizz tắt các tiến trình chạy nền và dọn sạch file tạm.
- **Claude không điều khiển được máy:** Claude chạy với mọi tool bị tắt, nên chữ trên màn hình (kể cả do người khác gõ) không thể khiến nó chạy lệnh trên máy bạn.

## Gỡ cài đặt

1. Xoá shortcut Quizz ở Desktop và Start Menu.
2. Xoá thư mục Quizz.
3. Claude Code là chương trình riêng: muốn gỡ thì xem [hướng dẫn](https://code.claude.com/docs/en/setup).
