[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/BJH8GGf3)
# FIT4012 - Lab 4: DES / TripleDES Starter Repository

Repo này là **starter repo** cho Lab 4 của FIT4012.  

## 1. Cấu trúc repo

```text
.
├── .github/
│   ├── scripts/
│   │   └── check_submission.sh
│   └── workflows/
│       └── ci.yml
├── logs/
│   ├── .gitkeep
│   └── README.md
├── scripts/
│   └── run_sample.sh
├── tests/
│   ├── test_des_sample.sh
│   ├── test_encrypt_decrypt_roundtrip.sh
│   ├── test_multiblock_padding.sh
│   ├── test_tamper_negative.sh
│   └── test_wrong_key_negative.sh
├── .gitignore
├── CMakeLists.txt
├── Makefile
├── README.md
├── des.cpp
└── report-1page.md
```

## 2. Cách chạy chương trình (How to run)

### Cách 1: Dùng Makefile

```bash
make
./des
```

### Cách 2: Biên dịch trực tiếp

```bash
g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des
./des
```

### Cách 3: Dùng CMake

```bash
cmake -S . -B build
cmake --build build
./build/des
```

## 3. Input / Đầu vào

Chương trình nhận đầu vào từ **stdin (bàn phím)** theo các mode sau:

### Mode 1: DES Encrypt
```
Nhập mode: 1
Nhập plaintext (64-bit binary): 0001001000110100010101100111100010011010101111001101111011110001
Nhập key (64-bit binary):        0001001100110100010101110111100110011011101111001101111111110001
```

### Mode 2: DES Decrypt
```
Nhập mode: 2
Nhập ciphertext (64-bit binary): [ciphertext từ encrypt]
Nhập key (64-bit binary):         0001001100110100010101110111100110011011101111001101111111110001
```

**Định dạng dữ liệu:**
- Plaintext/Ciphertext: Chuỗi **64 bit** (hoặc bội số 64 nếu multi-block)
- Key: Chuỗi **64 bit** nhị phân
- Nếu plaintext dài hơn 64 bit: chia thành các block 64 bit, block cuối cùng được **zero padding**
- Chương trình hỗ trợ **1 block hoặc nhiều blocks**

## 4. Output / Đầu ra

### DES Encrypt Output
```
Key Schedule:
Key 1:  [48-bit round key]
Key 2:  [48-bit round key]
...
Key 16: [48-bit round key]

Plaintext:  0001001000110100010101100111100010011010101111001101111011110001
Ciphertext: [64-bit encrypted output]
```

### DES Decrypt Output
```
Ciphertext: [64-bit input]
Decrypted:  [64-bit plaintext output]
Match:      YES (nếu decrypt chính xác)
```

**Chi tiết:**
- In ra 16 round keys (tuỳ chọn)
- In ra plaintext đầu vào
- In ra **ciphertext cuối cùng** dưới dạng chuỗi 64-bit nhị phân
- Hỗ trợ **decryption** với verifying round-trip
- Hỗ trợ **multi-block** với kết quả cuối cùng

## 5. Padding đang dùng

### Zero Padding Scheme

Khi plaintext dài hơn 64 bit:
1. Chia plaintext thành các block 64-bit
2. Block cuối nếu thiếu bit: thêm zeros bên phải cho đủ 64 bit
   ```
   Ví dụ: plaintext = 128 bit
   Block 1: [64 bit]  → encrypt
   Block 2: [64 bit]  → encrypt
   ```

3. Nếu plaintext = 80 bit:
   ```
   Block 1: [64 bit]         → encrypt
   Block 2: [16 bit + 48 bit zeros] → encrypt
   ```

### Hạn chế của Zero Padding

| Hạn chế | Mô tả |
|---------|-------|
| **Ambiguity** | Nếu plaintext kết thúc bằng zeros, không biết đâu là data, đâu là padding |
| **Weak Detection** | Không thể phát hiện padding bị chỉnh sửa hoặc loại bỏ |
| **Not Standard** | PKCS#7, PKCS#5 an toàn hơn trong thực tế |
| **Learning Only** | Chỉ phù hợp cho bài học nhập môn, không dùng trong sản xuất |

### Lý do dùng Zero Padding ở đây

- Đơn giản dễ hiểu cho sinh viên
- Tập trung vào logic DES, không phức tạp về padding
- Trong thực tế, các mode như CBC, CTR tự xử lý padding

## 6. Tests bắt buộc

Repo này đã tạo sẵn **5 tên file test mẫu** để sinh viên điền nội dung:

- `tests/test_des_sample.sh`
- `tests/test_encrypt_decrypt_roundtrip.sh`
- `tests/test_multiblock_padding.sh`
- `tests/test_tamper_negative.sh`
- `tests/test_wrong_key_negative.sh`

Sinh viên phải tự hoàn thiện test và bổ sung minh chứng chạy.

## 7. Logs / Minh chứng

Thư mục `logs/` dùng để nộp minh chứng, ví dụ:
- ảnh chụp màn hình khi chạy chương trình
- output của test
- log thử đúng / sai key / tamper
- log cho mã hóa nhiều block

## 8. Ethics & Safe use

- Chỉ chạy và kiểm thử trên dữ liệu học tập hoặc dữ liệu giả lập.
- Không dùng repo này để tấn công hay can thiệp hệ thống thật.
- Không trình bày đây là công cụ bảo mật sẵn sàng cho môi trường sản xuất.
- Nếu tham khảo mã, tài liệu, công cụ hoặc AI, phải ghi nguồn rõ ràng.
- Khi cộng tác nhóm, cần trung thực học thuật và mô tả đúng phần việc của mình.
- Việc kiểm thử chỉ phục vụ học DES / TripleDES ở mức nhập môn.

## 9. Checklist nộp bài

Trước khi nộp, cần có:
- `des.cpp` - hoàn chỉnh
- `README.md` - hoàn chỉnh với tất cả sections
- `report-1page.md` - hoàn chỉnh
- `tests/` - ít nhất 5 test files
- Negative tests cho tamper và wrong key
- `logs/` - ít nhất 1 file minh chứng thật
- Không còn placeholders trong code/docs

## 10. Lưu ý về CI

GitHub Actions sẽ kiểm tra:
- Các file bắt buộc có tồn tại
- README có tất cả sections (Input/Output/Padding/Ethics)
- Report có tất cả sections (Objective/Method/Result/Conclusion)
- Negative tests cho tamper và wrong key
- Có file minh chứng trong logs/
- Source code có nhập từ stdin
- Không còn placeholders

CI sẽ PASS khi tất cả yêu cầu được đáp ứng.
