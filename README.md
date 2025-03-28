# 📚 Tài liệu CLI cho **Book Reading Tracker**

Tài liệu này giải thích cách sử dụng **CLI** của dự án **Book Reading Tracker**, giúp bạn quản lý sách, tác giả và danh mục sách.

---

## 💻 Cài đặt

Để sử dụng ứng dụng CLI này, bạn cần cài đặt các gem với phiên bản chính xác mà dự án yêu cầu. Làm theo các bước dưới đây để cài đặt:

### 1. **Cài đặt các gem cần thiết**

Tạo tệp `Gemfile` trong thư mục gốc của dự án và thêm vào các dòng sau:

```ruby
# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gem 'activerecord', '7.1.0'
gem 'activesupport', '7.1.0'
gem 'awesome_print', '1.8'
gem 'benchmark', '0.4.0'
gem 'dotenv', '2.8'
gem 'fileutils', '0.7.2'
gem 'irb', '1.15'
gem 'logger', '1.6'
gem 'ostruct', '0.1.0'
gem 'pastel', '0.8'
gem 'pg', '1.5'
gem 'pry', '0.14.1'
gem 'rake', '13.0'
gem 'rspec', '3.12'
gem 'thor', '1.3'
gem 'tty-prompt', '0.23'
gem 'tty-table', '0.12.0'

```

---

## 1. **Quản lý Sách**

### Thêm Sách
```bash
book_reading_tracker_gem add_book "Tên Sách" --author "Tên Tác Giả" --pages 300 [--description "..."] [--isbn "..."] [--published_year 2023]
```

**Mô tả:**
- Thêm một cuốn sách mới vào danh sách.
- **Bắt buộc:** `--author`, `--pages`
- **Tùy chọn:** `--description`, `--isbn`, `--published_year`

**Ví dụ:**
```bash
book_reading_tracker_gem add_book "Lập trình Ruby" --author "David Hansson" --pages 300 --description "Học Ruby" --isbn "978-1234567890" --published_year 2023
```

---

### Xóa Sách
```bash
book_reading_tracker_gem remove_book ID
```

**Mô tả:**
- Xóa sách bằng ID duy nhất.

**Ví dụ:**
```bash
book_reading_tracker_gem remove_book 1
```

---

### Cập nhật Tiến độ Đọc
```bash
book_reading_tracker_gem progress_book ID --page PAGE
```

**Mô tả:**
- Cập nhật tiến độ đọc bằng cách chỉ định trang cuối đã đọc.

**Ví dụ:**
```bash
book_reading_tracker_gem progress_book 2 --page 150
```

---

### Hiển thị Danh sách Sách
```bash
book_reading_tracker_gem list_books
```

**Mô tả:**
- Hiển thị danh sách tất cả các sách.

---

### Xem Tiến độ Đọc
```bash
book_reading_tracker_gem show_progress ID
```

**Mô tả:**
- Hiển thị tiến độ đọc của một cuốn sách cụ thể.

**Ví dụ:**
```bash
book_reading_tracker_gem show_progress 2
```

---

## 2. **Quản lý Tác giả**

### Thêm Tác giả
```bash
book_reading_tracker_gem add_author "Tên Tác Giả" [--biography "Tiểu sử"]
```

**Mô tả:**
- Thêm một tác giả mới vào hệ thống.
- **Tùy chọn:** `--biography`

**Ví dụ:**
```bash
book_reading_tracker_gem add_author "J.K. Rowling" --biography "Tác giả của Harry Potter"
```

---

### Hiển thị Danh sách Tác giả
```bash
book_reading_tracker_gem list_authors
```

**Mô tả:**
- Hiển thị danh sách tất cả các tác giả.

---

## 3. **Quản lý Danh mục**

### Thêm Danh mục
```bash
book_reading_tracker_gem add_category "Tên Danh Mục"
```

**Mô tả:**
- Thêm một danh mục mới vào hệ thống.

**Ví dụ:**
```bash
book_reading_tracker_gem add_category "Tiểu thuyết"
```

---

### Hiển thị Danh sách Danh mục
```bash
book_reading_tracker_gem list_categories
```

**Mô tả:**
- Hiển thị danh sách tất cả các danh mục.

---

## 4. **Thống kê**

### Xem Thống kê Sách
```bash
book_reading_tracker_gem stats
```

**Mô tả:**
- Hiển thị thống kê tổng quan như tổng số sách, số trang đã đọc và tỷ lệ hoàn thành.

---


## Kết luận
CLI này cung cấp cách thức có cấu trúc để quản lý hoạt động đọc sách của bạn, theo dõi tiến độ và tổ chức tác giả cũng như danh mục một cách hiệu quả.
