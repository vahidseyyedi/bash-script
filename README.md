### File Management Script

This Bash script provides functionalities for managing and monitoring files in a specified directory. It logs information about files, checks file sizes, tracks recent modifications, and creates backups of log files.

### Features
1. **Logging Line Counts**:
   - Logs the number of lines in each file within the given directory and its subdirectories.
2. **Finding Recently Modified Files**:
   - Identifies files modified within a specified number of days.
3. **Checking File Sizes**:
   - Finds files larger than a specified size (in bytes).
4. **Log Backup and Comparison**:
   - Creates backups of the log file and compares changes between backups.

### Usage
Run the script using the following syntax:
```bash
./script.sh <directory_path> [size_in_bytes] [days]
```

#### Parameters
1. `<directory_path>` (required): The path of the directory to process.
2. `[size_in_bytes]` (optional): Threshold size for identifying large files (default is 1000 bytes).
3. `[days]` (optional): Time period in days for finding recently modified files (default is 7 days).

### Examples
- Log all files in `/my/directory` and use default size and day thresholds:
  ```bash
  ./script.sh /my/directory
  ```
- Find files larger than 2000 bytes:
  ```bash
  ./script.sh /my/directory 2000
  ```
- Find files modified in the last 5 days:
  ```bash
  ./script.sh /my/directory 1000 5
  ```

### Output
The script generates a log file named `scriptlog` in the specified directory. This file contains details of the operations performed.

### Backup
- The script creates a backup of the log file with a timestamp (e.g., `scriptlog.bak_20250121123045`).

### Dependencies
- Bash
- Standard Linux commands: `wc`, `find`, `stat`, `diff`, `sed`

---

### اسکریپت مدیریت فایل

این اسکریپت Bash قابلیت‌هایی برای مدیریت و مانیتور کردن فایل‌ها در یک پوشه مشخص ارائه می‌دهد. این اسکریپت اطلاعات مربوط به فایل‌ها را لاگ می‌کند، اندازه فایل‌ها را بررسی می‌کند، تغییرات اخیر را دنبال می‌کند و از فایل‌های لاگ نسخه پشتیبان تهیه می‌کند.

### ویژگی‌ها
1. **لاگ تعداد خطوط فایل‌ها**:
   - تعداد خطوط هر فایل در پوشه و زیرپوشه‌های مشخص شده را لاگ می‌کند.
2. **یافتن فایل‌های اخیر تغییر یافته**:
   - فایل‌هایی که در یک بازه زمانی مشخص تغییر کرده‌اند را شناسایی می‌کند.
3. **بررسی اندازه فایل‌ها**:
   - فایل‌هایی که بزرگتر از اندازه مشخص (بر حسب بایت) هستند را پیدا می‌کند.
4. **پشتیبان‌گیری و مقایسه لاگ**:
   - نسخه پشتیبان از فایل لاگ تهیه کرده و تغییرات بین نسخه‌های پشتیبان را مقایسه می‌کند.

### نحوه استفاده
اسکریپت را با فرمت زیر اجرا کنید:
```bash
./script.sh <directory_path> [size_in_bytes] [days]
```

#### پارامترها
1. `<directory_path>` (اجباری): مسیر پوشه‌ای که می‌خواهید پردازش شود.
2. `[size_in_bytes]` (اختیاری): حد آستانه برای شناسایی فایل‌های بزرگ (پیش‌فرض 1000 بایت).
3. `[days]` (اختیاری): مدت زمان (بر حسب روز) برای یافتن فایل‌های تغییر یافته اخیر (پیش‌فرض 7 روز).

### مثال‌ها
- لاگ تمام فایل‌ها در مسیر `/my/directory` با استفاده از مقادیر پیش‌فرض:
  ```bash
  ./script.sh /my/directory
  ```
- یافتن فایل‌های بزرگتر از 2000 بایت:
  ```bash
  ./script.sh /my/directory 2000
  ```
- یافتن فایل‌هایی که در 5 روز گذشته تغییر کرده‌اند:
  ```bash
  ./script.sh /my/directory 1000 5
  ```

### خروجی
اسکریپت یک فایل لاگ به نام `scriptlog` در پوشه مشخص شده ایجاد می‌کند. این فایل شامل جزئیات عملیات انجام شده است.

### پشتیبان‌گیری
- اسکریپت یک نسخه پشتیبان از فایل لاگ با یک زمان‌بندی (مانند `scriptlog.bak_20250121123045`) ایجاد می‌کند.

### پیش‌نیازها
- Bash
- دستورات استاندارد لینوکس: `wc`, `find`, `stat`, `diff`, `sed`

