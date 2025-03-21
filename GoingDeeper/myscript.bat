@echo off
for %%F in (GD_03_04 GD_05_06 GD_07_08 GD_09_10 GD_11_12 GD_13_14 GD_15_16 GD_17_18) do (
    robocopy "GD_01_02" "%%F" /E
)
echo 복사 완료!
pause
