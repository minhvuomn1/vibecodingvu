# :brain: Vibe Workflow Log – HelloVibe Project
## Prompt #1: Tạo LWC đổi màu khi click
**Thời gian thực hiện:** 29/10/2025  
**Người thực hiện:** <Vũ>

### :small_blue_diamond: Prompt đã dùng:
- "Tạo component LWC tên colorToggleButton. Khi click, nút toggle giữa hai màu đỏ/xanh, duy trì state nội bộ và hiển thị nhãn tùy biến. (Không cần Apex)."

### :small_blue_diamond: Kết quả sinh code:
- Tự động tạo folder `lwc/colorToggleButton`
- Sinh 4 file: `.html`, `.js`, `.css`, `.js-meta.xml`
- Logic:
  - `isActive` boolean điều khiển class CSS (`active`/`inactive`)
  - Gán `aria-pressed` theo state
  - Gửi sự kiện `toggle` (detail: `{ active: boolean }`) khi click
- Deploy thành công lên Org `<binkkboi737@agentforce.com>`

### :small_blue_diamond: Thời gian:
- Generate: ~10 giây
- Deploy: ~15 giây
- Test: hoạt động đúng trên Lightning App Page “TestColorToggle”

### :small_blue_diamond: Đánh giá code:
| Tiêu chí     | Đánh giá                     | Ghi chú                                              |
| ------------ | ---------------------------- | ---------------------------------------------------- |
| Cấu trúc LWC | :white_check_mark: Tốt       | Đúng chuẩn base template, tách CSS riêng             |
| Logic JS     | :white_check_mark: Tốt       | Toggle rõ ràng, phát sự kiện `toggle` cho parent     |
| UI/UX        | :warning: Có thể cải thiện   | Có thể thêm tooltip/title và focus ring rõ ràng      |
| Tên biến     | :white_check_mark: Chuẩn     | Tên dễ hiểu, theo convention LWC                     |
| A11y         | :white_check_mark: Ổn        | Dùng `aria-pressed`, có thể bổ sung keyboard handler |

### :small_blue_diamond: Kết luận:
> :white_check_mark: Prompt chạy ổn định, code sạch, deploy thành công.  
> Lưu lại prompt này làm **mẫu chuẩn** để huấn luyện team viết prompt LWC cơ bản.

### Phụ lục: Trích yếu code chính
- colorToggleButton.html
  - `<button class={buttonClass} onclick={handleClick} aria-pressed={isActive}>{computedLabel}</button>`
- colorToggleButton.js (ý định)
  - `handleClick() { this.isActive = !this.isActive; this.dispatchEvent(new CustomEvent('toggle', { detail: { active: this.isActive } })); }`
- colorToggleButton.css
  - `.inactive { background:#b71c1c; } .active { background:#1b5e20; }`
