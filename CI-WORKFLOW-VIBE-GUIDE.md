# CI Workflow với Vibe

Hướng dẫn sử dụng quy trình tích hợp liên tục (CI) cho dự án Vibe.

## Giới thiệu

Pipeline CI/CD cho dự án Vibe được thực hiện bằng GitHub Actions. Khi có thay đổi trong mã nguồn, pipeline sẽ tự động chạy để kiểm tra và test code.

## Cấu Hình Trigger

Pipeline sẽ tự động chạy khi:
- Push code lên nhánh `main` hoặc `develop`
- Tạo Pull Request nhắm đến nhánh `main`

## Chi Tiết Pipeline

Pipeline được định nghĩa trong file `.github/workflows/cicd-pipeline.yml` với job tên `validate` chạy trên môi trường Ubuntu.

### Các bước thực hiện:
1. Checkout code từ repository
2. Cài đặt Salesforce CLI
3. Kiểm tra cấu trúc dự án
4. Chuyển đổi source sang mdapi format

## Cách Sử Dụng

1. Push code lên nhánh `main` hoặc `develop` để chạy pipeline đầy đủ
2. Tạo Pull Request tới nhánh `main` để chỉ chạy test
3. Kiểm tra kết quả tại tab **Actions** trong GitHub

## Tài Nguyên Tham Khảo

- [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
