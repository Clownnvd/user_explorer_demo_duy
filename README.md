# github_user_explorer

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Best Practices cho Fresher
- Đúng “Clean”: UI → Cubit → Use case → Repository → Data source
- Dễ mở rộng: sau này GetUsers có thể phân trang, cache, check network… mà không phải đổi Cubit
- Lưu ý “mọi hành động business = 1 use case”
- Test Cubit dễ: bạn mock GetUsers chứ không cần mock cả repo