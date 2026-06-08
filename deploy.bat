@echo off
chcp 65001 >nul
echo ================================================================
echo   🚀 อัพเดท Stock Dashboard → GitHub Pages
echo ================================================================
echo.

:: ตรวจสอบว่ามี Python
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ ไม่พบ Python กรุณาติดตั้ง Python ก่อน
    pause
    exit /b 1
)

:: รัน build script
echo [1/3] กำลังสร้าง Dashboard จากข้อมูลล่าสุด...
cd /d "%~dp0"
python build_stock_dashboard.py
if errorlevel 1 (
    echo.
    echo ❌ เกิดข้อผิดพลาดในการสร้าง Dashboard
    pause
    exit /b 1
)
echo.
echo ✅ สร้าง Dashboard สำเร็จ
echo.

:: Git commit + push
echo [2/3] กำลัง commit ขึ้น GitHub...
git add stock_dashboard.html
git commit -m "อัพเดท dashboard %date% %time:~0,5%"
if errorlevel 1 (
    echo ℹ️  ไม่มีการเปลี่ยนแปลง หรือ git ยังไม่ได้ setup
    pause
    exit /b 0
)

echo [3/3] กำลัง push ขึ้น GitHub...
git push
if errorlevel 1 (
    echo ❌ Push ไม่สำเร็จ — ตรวจสอบการเชื่อมต่อ internet และ git credentials
    pause
    exit /b 1
)

echo.
echo ================================================================
echo   ✅ เสร็จสิ้น! Dashboard อัพเดทบน GitHub Pages แล้ว
echo   ⏳ รอประมาณ 1-2 นาที แล้วให้คนอื่น refresh หน้าเว็บ
echo ================================================================
echo.
pause
