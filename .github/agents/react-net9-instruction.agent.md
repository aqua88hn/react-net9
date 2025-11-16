# Agent 1 Instruction: Agent Khởi tạo Dự án (React + .NET 9 Web API)

## 1. 🎯 Mục tiêu và Cấu trúc Dự án

* **Mục tiêu Chính:** Khởi tạo cấu trúc dự án Full-stack từ SRS, tuân thủ kiến trúc React và .NET 9 (Clean/Layered Architecture).
* **Kiến trúc Backend:** Bắt buộc sử dụng kiến trúc **Layered** hoặc **Clean Architecture**.
* **Kiến trúc Frontend:** Bắt buộc sử dụng kiến trúc **Component-based** và **Feature-driven** (tách biệt theo Module/Tính năng).

## 2. 📜 Cấu Trúc Source Code Tiêu Chuẩn

* **Quy ước Đặt tên:** Áp dụng **PascalCase** cho các Class, Method, và Public Properties (C#); **camelCase** cho biến, tham số (C#, React/TS).
* **Tệp:** Sử dụng **kebab-case** cho tên tệp (ví dụ: `user-list.tsx`).
* **Data Fetching:** Sử dụng **Axios** hoặc Fetch API với custom hooks (React).

Agent 1 phải thiết lập cấu trúc thư mục chính xác như sau:

### 2.1 Cấu trúc Backend (.NET 9 Web API - Clean Architecture)


/src
|-- /ProjectName.Api          # (Startup, Controllers, Middleware)
|-- /ProjectName.Application  # (Business Logic, Services, DTOs/CQRS)
|   |-- /Features
|   |-- /Interfaces
|-- /ProjectName.Domain       # (Entities, Enums, Value Objects)
|-- /ProjectName.Infrastructure # (Persistence: EF Core DbContext, Repositories)
* **Quy tắc:** Bắt buộc sử dụng **Dependency Injection (DI)** mặc định của .NET và **Entity Framework Core (EF Core)** cho ORM.

### 2.2 Cấu trúc Frontend (React)


/src
|-- /components      # Components dùng chung (Button, Spinner, Layout)
|-- /contexts        # Global state management
|-- /hooks           # Custom Hooks (useAuth, useApi)
|-- /pages           # Components cấp Route (Dashboard, Login)
|-- /features        # Module theo tính năng (Feature-driven)
|   |-- /Users       # Ví dụ: Feature User Manager
|   |   |-- /components # (UserList, UserForm)
|   |   |-- Users.api.js
|   |   |-- Users.store.js (State/Data Access)
|-- /styles          # Global styles, Theme setup
* **Quy tắc:** Sử dụng các thư mục `features` để tách biệt code theo yêu cầu của SRS.


## 3. 🌊 Quy trình Khởi tạo

1.  **Phân tích SRS:** Xác định các mô-đun chính (Auth, Data, UI).
2.  **Tạo Cấu trúc:** Tạo các thư mục cần thiết cho Frontend (Components, Pages, Services) và Backend (Controllers, Services, Models, Data).
3.  **Thiết lập ORM:** Khởi tạo `DbContext` và các `Migration` ban đầu cho EF Core.
4.  **Cài đặt DI/Auth:** Cấu hình Authentication (Identity) và đăng ký tất cả các Service/Repository cần thiết trong `Program.cs`.
