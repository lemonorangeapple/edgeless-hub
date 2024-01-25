@echo off
set stage=Beta

::���rclone�Ƿ�����������
rclone ls pineapple:/hdisk/edgeless/Socket/Hub >nul
if "%errorlevel%" neq "0" (
    echo Please install rclone then add pineapple
    pause
    exit
)

::��ȡ�汾��
call readJson ..\package.json version
set "version=%getValue_%"
title ����Edgeless Hub %version%

::����ѡ��
echo 1.�˰汾ֻ����С���£�Ĭ�ϣ�
echo 2.��Ҫ����������
echo 3.��Ҫȫ������
set /p choice=������Ż�ֱ�ӻس���

if "%choice%"=="2" (
    call writeJson Workshop\update.json dependencies_requirement %version:~0,-2%
)
if "%choice%"=="3" (
    call writeJson Workshop\update.json dependencies_requirement %version:~0,-2%
    call writeJson Workshop\update.json wide_gaps.-1 %version:~0,-2%
)

::����
title ����Edgeless Hub %version%-���루1/6��
cd ..
cmd /c "yarn electron:build"

::����win-unpackĿ¼
cd dist\win-unpacked
::del /f /s /q swiftshader
::rd swiftshader
del /f /q d3dcompiler_47.dll
del /f /q LICENSE.electron.txt
del /f /q LICENSES.chromium.html
del /f /q vk_swiftshader.dll
del /f /q vk_swiftshader_icd.json
del /f /q vulkan-1.dll
del /f /q locales\am.pak
del /f /q locales\ar.pak
del /f /q locales\bg.pak
del /f /q locales\bn.pak
del /f /q locales\ca.pak
del /f /q locales\cs.pak
del /f /q locales\da.pak
del /f /q locales\de.pak
del /f /q locales\el.pak
del /f /q locales\es-419.pak
del /f /q locales\es.pak
del /f /q locales\et.pak
del /f /q locales\fa.pak
del /f /q locales\fi.pak
del /f /q locales\fil.pak
del /f /q locales\fr.pak
del /f /q locales\gu.pak
del /f /q locales\he.pak
del /f /q locales\hi.pak
del /f /q locales\hr.pak
del /f /q locales\hu.pak
del /f /q locales\id.pak
del /f /q locales\it.pak
del /f /q locales\ja.pak
del /f /q locales\kn.pak
del /f /q locales\ko.pak
del /f /q locales\lt.pak
del /f /q locales\lv.pak
del /f /q locales\ml.pak
del /f /q locales\mr.pak
del /f /q locales\ms.pak
del /f /q locales\nb.pak
del /f /q locales\nl.pak
del /f /q locales\pl.pak
del /f /q locales\pt-BR.pak
del /f /q locales\pt-PT.pak
del /f /q locales\ro.pak
del /f /q locales\ru.pak
del /f /q locales\sk.pak
del /f /q locales\sl.pak
del /f /q locales\sr.pak
del /f /q locales\sv.pak
del /f /q locales\sw.pak
del /f /q locales\ta.pak
del /f /q locales\te.pak
del /f /q locales\th.pak
del /f /q locales\tr.pak
del /f /q locales\uk.pak
del /f /q locales\vi.pak
del /f /q locales\zh-TW.pak
del /f /q locales\en-GB.pak

::����core�ļ���
title ����Edgeless Hub %version%-����core�ļ��У�2/6��
cd ..
cd ..
xcopy /s /r /y core dist\win-unpacked\core\

::��������
cd dist
del /f /q *.exe
del /f /q *.blockmap

::������win-unpack
del /f /s /q "Edgeless Hub"
rd /s /q "Edgeless Hub"
ren win-unpacked "Edgeless Hub"

::��������ѹ����
title ����Edgeless Hub %version%-������������3/6��
"C:\Program Files\7-Zip\7z.exe" a -t7z -mx9 "Edgeless Hub_%stage%_%version:~0,-2%.7z" "Edgeless Hub"

cd "Edgeless Hub"
title ����Edgeless Hub %version%-����update����4/6��
"C:\Program Files\7-Zip\7z.exe" a -t7z -mx9 "update.7z" "core" "resources"
title ����Edgeless Hub %version%-����miniupdate����5/6��
"C:\Program Files\7-Zip\7z.exe" a -t7z -mx9 "miniupdate.7z" "resources\app.asar"
cd ..
cd ..
del /f /q release\Workshop\*.7z
md release\Workshop
move /y "dist\Edgeless Hub\update.7z" "release\Workshop\update.7z"
move /y "dist\Edgeless Hub\miniupdate.7z" "release\Workshop\miniupdate.7z"
move /y "dist\Edgeless Hub_%stage%_%version:~0,-2%.7z" "release\Workshop\Edgeless Hub_%stage%_%version:~0,-2%.7z"

::�ϴ���������update.json
title ����Edgeless Hub %version%-�ϴ��ļ���6/6��
cd release\Workshop
rclone copy -P "Edgeless Hub_%stage%_%version:~0,-2%.7z" pineapple:/hdisk/edgeless/Socket/Hub
rclone copy -P "update.json" pineapple:/hdisk/edgeless/Socket/Hub/Update
rclone copy -P "update.7z" pineapple:/hdisk/edgeless/Socket/Hub/Update
rclone copy -P "miniupdate.7z" pineapple:/hdisk/edgeless/Socket/Hub/Update
exit