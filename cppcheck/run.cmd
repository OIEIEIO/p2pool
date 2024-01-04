@echo off
"..\cppcheck-main\bin\cppcheck.exe" --project=..\build\p2pool.vcxproj --project-configuration="Release|x64" -DSIZE_MAX=UINT64_MAX -DRAPIDJSON_ENDIAN=RAPIDJSON_LITTLEENDIAN --platform=win64 --std=c++17 --enable=all --inconclusive --inline-suppr --template="{file}:{line}:{id}{inconclusive: INCONCLUSIVE} {message}" --suppressions-list=suppressions.txt --output-file=errors_full.txt --max-ctu-depth=3 --check-level=exhaustive --checkers-report=checkers_report.txt
findstr /V /C:"external\src" errors_full.txt > errors_filtered0.txt
findstr /V /C:":checkersReport" errors_filtered0.txt > errors_filtered.txt
for /f %%i in ("errors_filtered.txt") do set size=%%~zi
if %size% gtr 0 (
	type errors_filtered.txt
	exit 1
)
