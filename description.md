# :books: Book Reading Tracker Database
> **Mô hình dữ liệu được thiết kế theo kiến trúc MVC, sử dụng Ruby + ActiveRecord + Supabase (PostgreSQL)**
---
## :blue_book: **1. Table: `Books`**
- **Chức năng:** Lưu trữ thông tin sách.
- **Các cột quan trọng:**
  - `BookID` (PK, increment): Khóa chính.
  - `Title`: Tên sách (NOT NULL).
  - `Description`: Mô tả sách.
  - `ISBN` (unique): Mã ISBN duy nhất.
  - `PublishedYear`: Năm xuất bản.
  - `CreatedAt` & `UpdatedAt`: Thời điểm tạo/cập nhật.
---
## :bust_in_silhouette: **2. Table: `Authors`**
- **Chức năng:** Lưu trữ thông tin tác giả.
- **Các cột quan trọng:**
  - `AuthorID` (PK, increment): Khóa chính.
  - `AuthorName`: Tên tác giả (NOT NULL, UNIQUE).
  - `Biography`: Tiểu sử tác giả (tuỳ chọn).
  - `CreatedAt` & `UpdatedAt`: Thời điểm tạo/cập nhật.
---
## :writing_hand: **3. Table: `BookAuthors`**
- **Chức năng:** Bảng trung gian liên kết nhiều-nhiều giữa **Books** và **Authors**.
- **Các cột quan trọng:**
  - `BookID` (PK): Khóa chính, liên kết đến **Books**.
  - `AuthorID` (PK): Khóa chính, liên kết đến **Authors**.
- **Quan hệ:**
  - Một sách có thể có nhiều tác giả.
  - Một tác giả có thể viết nhiều sách.
---
## :label: **4. Table: `Categories`**
- **Chức năng:** Lưu trữ thể loại sách.
- **Các cột quan trọng:**
  - `CategoryID` (PK, increment): Khóa chính.
  - `CategoryName` (unique, not null): Tên thể loại sách.
---
## :link: **5. Table: `BookCategories`**
- **Chức năng:** Bảng trung gian tạo quan hệ nhiều-nhiều giữa **Books** và **Categories**.
- **Các cột quan trọng:**
  - `BookID` (PK): Khóa chính, liên kết đến **Books**.
  - `CategoryID` (PK): Khóa chính, liên kết đến **Categories**.
- **Quan hệ:**
  - Một sách có thể thuộc nhiều thể loại.
  - Một thể loại có thể chứa nhiều sách.
---
## :bar_chart: **6. Table: `ReadingProgress`**
- **Chức năng:** Theo dõi tiến độ đọc sách.
- **Các cột quan trọng:**
  - `ProgressID` (PK, increment): Khóa chính.
  - `BookID`: Khóa ngoại đến **Books**.
  - `Status`: Trạng thái đọc (`unread`, `reading`, `read`).
  - `PagesRead`: Số trang đã đọc (default: 0).
  - `TotalPages`: Tổng số trang (default: 0).
  - `StartedAt`: Ngày bắt đầu đọc.
  - `FinishedAt`: Ngày kết thúc đọc.
---
## :mag: **Mối Quan Hệ Giữa Các Bảng**
- **1-N (One-to-Many):**
  - `Books` → `ReadingProgress`: Một sách có thể có nhiều tiến độ đọc (nhiều người dùng).
- **N-N (Many-to-Many):**
  - `Books` :left_right_arrow: `Categories`: qua bảng `BookCategories`.
  - `Books` :left_right_arrow: `Authors`: qua bảng `BookAuthors`.
---
## :hammer_and_wrench: **Tóm tắt chức năng hệ thống**
- **Quản lý sách:** Thêm, sửa, xóa sách và thông tin liên quan.
- **Phân loại:** Gắn sách với nhiều thể loại.
- **Quản lý tác giả:** Quản lý tiểu sử, thông tin và sách của từng tác giả.
- **Theo dõi tiến độ đọc:** Lưu trạng thái và quá trình đọc sách.
- *(Optional)* **Gợi ý nhắc nhở:** Có thể tích hợp Slack Bot để nhắc đọc nếu ngắt quãng quá lâu.
---
## 🗃️ Mô hình Cơ sở Dữ liệu

Truy cập bản thiết kế mô hình CSDL trực tiếp tại dbdiagram.io:

🔗 [Xem mô hình tại dbdiagram.io](https://dbdiagram.io/d/67552302e9daa85aca01bb9d)
