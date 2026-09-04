Write-Host '========================================' -ForegroundColor Green
Write-Host '  بناء تطبيق فقيه - APK حقيقي'  -ForegroundColor Green  
Write-Host '========================================' -ForegroundColor Green

# Step 1: Extract Flutter
if (-not (Test-Path 'D:\flutter\bin\flutter.bat')) {
    Write-Host 'خطوة 1: فك ضغط Flutter SDK...' -ForegroundColor Cyan
    Expand-Archive -Path 'D:\flutter_sdk.zip' -DestinationPath 'D:\' -Force
    Write-Host 'تم بنجاح!' -ForegroundColor Green
} else {
    Write-Host 'خطوة 1: Flutter موجود بالفعل' -ForegroundColor Yellow
}

# Step 2: Add to PATH
C:/Users/pc/.gemini/antigravity/bin;C:\Users\pc\AppData\Roaming\Antigravity\bin;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files\dotnet\;C:\Program Files\NVIDIA Corporation\NVIDIA App\NvDLISR;C:\Program Files\nodejs\;C:\Program Files\Git\cmd;C:\Users\pc\AppData\Local\Microsoft\WindowsApps;C:\Users\pc\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\pc\AppData\Local\PowerToys\DSCModules\;C:\Users\pc\AppData\Roaming\npm; = 'D:\flutter\bin;' + C:/Users/pc/.gemini/antigravity/bin;C:\Users\pc\AppData\Roaming\Antigravity\bin;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files\dotnet\;C:\Program Files\NVIDIA Corporation\NVIDIA App\NvDLISR;C:\Program Files\nodejs\;C:\Program Files\Git\cmd;C:\Users\pc\AppData\Local\Microsoft\WindowsApps;C:\Users\pc\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\pc\AppData\Local\PowerToys\DSCModules\;C:\Users\pc\AppData\Roaming\npm;
 = 'C:\Program Files\Microsoft\jdk-17.0.20.101-hotspot'

# Step 3: Verify
Write-Host 'خطوة 2: التحقق من Flutter...' -ForegroundColor Cyan
flutter --version

# Step 4: Go to project
Set-Location 'd:\فقيه'

# Step 5: Accept licenses
Write-Host 'خطوة 3: قبول التراخيص...' -ForegroundColor Cyan
'y' | flutter doctor --android-licenses 2>&1 | Out-Null

# Step 6: Get dependencies
Write-Host 'خطوة 4: تحميل المكتبات...' -ForegroundColor Cyan
flutter pub get

# Step 7: Build
Write-Host 'خطوة 5: بناء APK...' -ForegroundColor Cyan
flutter build apk --release --no-tree-shake-icons

# Step 8: Copy result
Write-Host 'خطوة 6: نسخ الناتج...' -ForegroundColor Cyan
 = 'build\app\outputs\flutter-apk\app-release.apk'
if (Test-Path ) {
    Copy-Item  'd:\فقيه\Fakieh_Real.apk' -Force
    Write-Host '========================================' -ForegroundColor Green
    Write-Host '  تم! APK موجود في: d:\فقيه\Fakieh_Real.apk' -ForegroundColor Green
    Write-Host '  ابعته على موبايلك وثبته!' -ForegroundColor Green
    Write-Host '========================================' -ForegroundColor Green
} else {
    Write-Host 'حدث خطأ في البناء. تحقق من الأخطاء بالأعلى.' -ForegroundColor Red
}
