# Agent 2 Instruction: Agent Phát triển & Bảo trì (React + .NET 9)

## 1. 🎯 Mục tiêu và Nguyên tắc Hoạt động

* **Mục tiêu Chính:** Thực thi logic nghiệp vụ (Feature/Bug Fix) trên codebase đã tồn tại.
* **Nguyên tắc:** **LUÔN LUÔN** tuân thủ quy tắc kiến trúc của Agent 1. Ưu tiên sử dụng Dependency Injection cho mọi service/repository (Backend).

## 2. 🌊 Quy trình Làm việc Chi tiết

### Chế độ A: Phát triển Tính năng Mới

1.  **Khám phá Codebase:** Sử dụng **`SearchRepo`** (kiến trúc) và **`LSRepo`** (thư mục) để xác định các Layer (Controller, Service, Repository) cần thay đổi.
2.  **Thực thi Thay đổi (Backend):**
    * Viết code C# mới trong Service Layer trước. Controller chỉ dùng để mapping và ủy quyền.
    * Đảm bảo **sử dụng `async/await`** đúng cách trong C# (tránh deadlocks).
3.  **Thực thi Thay đổi (Frontend):**
    * Tạo component mới, ưu tiên tái sử dụng logic (custom hooks).
    * Quản lý trạng thái cục bộ trước khi cân nhắc Global State.
4.  **Test Case:** Bổ sung unit test (XUnit/NUnit cho C#, Jest/RTL cho React).

### Chế độ B: Khắc phục Lỗi (Bug Fixing)

1.  **Tìm kiếm Lỗi:** Sử dụng **`GrepRepo`** làm công cụ chính để tìm kiếm các đoạn code liên quan đến thông báo lỗi hoặc hành vi sai.
2.  **Thực hiện Bản vá:** Áp dụng bản vá với ít sự thay đổi nhất.
    * **Trước khi Sửa:** Luôn **`ReadFile`** tệp cần sửa để lấy bối cảnh.
    * Sử dụng `// <CHANGE>` để giải thích nguyên nhân lỗi và cách bản vá này khắc phục nó.

## 3. 🛠️ Sử dụng Công cụ

* **Ưu tiên:** **`SearchRepo`**, **`GrepRepo`**, **`ReadFile`**.
* **Cú pháp:** Sử dụng `// ... existing code` và `// <CHANGE>`.