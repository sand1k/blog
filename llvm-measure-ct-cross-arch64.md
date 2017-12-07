# Testing clang’s compilation time cross-compiling CTMark for aarch64

## Testing using CMake builds

Check out llvm:
```
cd /Devel/repos
git clone https://github.com/llvm-mirror/llvm.git llvm
```

Check out Clang:
```
cd llvm/tools
git clone https://github.com/llvm-mirror/clang.git clang
cd ../..
```

Build LLVM and Clang:
```
mkdir llvm-build (in-tree build is not supported)
cd llvm-build
cmake -G "Unix Makefiles" ../llvm
make -j
cd ..
```

Check out llvm test suite:
```
git clone https://github.com/llvm-mirror/test-suite.git llvm-test-suite
```

Download linaro aarch64 cross compiler and sysroot and untar them:
```
cd /Devel/src
wget https://releases.linaro.org/components/toolchain/binaries/latest-5/aarch64-linux-gnu/gcc-linaro-5.5.0-2017.10-x86_64_aarch64-linux-gnu.tar.xz
wget https://releases.linaro.org/components/toolchain/binaries/latest-5/aarch64-linux-gnu/sysroot-glibc-linaro-2.21-2017.10-aarch64-linux-gnu.tar.xz
tar -xf gcc-linaro-5.5.0-2017.10-x86_64_aarch64-linux-gnu.tar.xz
tar -xf sysroot-glibc-linaro-2.21-2017.10-aarch64-linux-gnu.tar.xz
```

Create ~/clang_aarch64_linux.cmake cmake toolchain file with the follwing contents:
```
set(CMAKE_SYSTEM_NAME Linux )
set(triple aarch64-linux-gnu )
set(CMAKE_C_COMPILER /Devel/repos/llvm_build/bin/clang )
set(CMAKE_C_COMPILER_TARGET ${triple} )
set(CMAKE_CXX_COMPILER /Devel/repos/llvm_build/bin/clang++ )
set(CMAKE_CXX_COMPILER_TARGET ${triple} )
set(CMAKE_SYSROOT /Devel/src/sysroot-glibc-linaro-2.21-2017.10-aarch64-linux-gnu )
set(CMAKE_C_COMPILER_EXTERNAL_TOOLCHAIN /Devel/src/gcc-linaro-5.5.0-2017.10-x86_64_aarch64-linux-gnu )
set(CMAKE_CXX_COMPILER_EXTERNAL_TOOLCHAIN /Devel/src/gcc-linaro-5.5.0-2017.10-x86_64_aarch64-linux-gnu )
```

Build test suite with global instruction selection disabled for aarch64 and generate report:
```
mkdir llvm-test-suite-build
cd llvm-test-suite-build
cmake -DCMAKE_C_COMPILER=/Devel/repos/llvm_build/bin/clang -DTEST_SUITE_SUBDIRS=CTMark -DTEST_SUITE_RUN_BENCHMARKS=Off -DCMAKE_C_FLAGS="-O0" ../llvm-test-suite -DCMAKE_TOOLCHAIN_FILE=~/clang_aarch64_linux.cmake
make -j
../llvm-build/bin/llvm-lit -o result.json .
```

Build test suite with global instruction selection enabled for aarch64 and generate report:
```
mkdir llvm-test-suite-build-2
cd llvm-test-suite-build-2
cmake -DCMAKE_C_COMPILER=/Devel/repos/llvm_build/bin/clang -DTEST_SUITE_SUBDIRS=CTMark -DTEST_SUITE_RUN_BENCHMARKS=Off -DCMAKE_C_FLAGS="-O0 -mllvm -global-isel -mllvm -global-isel-abort=2" ../llvm-test-suite -DCMAKE_TOOLCHAIN_FILE=~/clang_aarch64_linux.cmake
make -j
../llvm-build/bin/llvm-lit -o result.json .
```

Compare reports:
```
../llvm-test-suite/utils/compare.py ../llvm-test-suite-build/result.json ../llvm-test-suite-build-2/result.json -m compile_time
```

Sample Output:
```
Tests: 10
Metric: compile_time

Program                                         result  result0 diff 
                                                                    
sqlite3/sqlite3                               378.20  422.15   11.6%
lencod/lencod                                 424.39  439.50    3.6%
ClamAV/clamscan                               340.13  350.75    3.1%
mafft/pairlocalalign                          212.44  215.05    1.2%
consumer-typeset/consumer-typeset             275.72  277.08    0.5%
7zip/7zip-benchmark                           711.34  713.64    0.3%
kimwitu++/kc                                  279.26  278.41   -0.3%
Bullet/bullet                                 544.99  543.35   -0.3%
tramp3d-v4/tramp3d-v4                         529.12  527.83   -0.2%
SPASS/SPASS                                   320.74  320.95    0.1%
           result     result0       diff
count  10.000000   10.000000   10.000000
mean   401.632400  408.871600  0.019569 
std    153.021536  152.496962  0.036705 
min    212.436000  215.052000 -0.003022 
25%    289.626000  289.046000 -0.001666 
50%    359.166000  386.450000  0.004078 
75%    502.940000  505.749000  0.026505 
max    711.336000  713.640000  0.116191
```

## Testing using LNT

Install virtualenv and create new environment:
```
sudo easy_install virtualenv
virtualenv ~/mysandbox
```

Check out LNT and install it to the virtual environment:
```
git clone https://github.com/llvm-mirror/lnt.git lnt
~/mysandbox/bin/python lnt/setup.py develop
```

Run tests:
```
~/mysandbox/bin/lnt runtest test-suite --sandbox /Devel/tmp/llvm-test-out --no-timestamp --cc /Devel/repos/llvm_build/bin/clang --use-lit=/Devel/repos/llvm/utils/lit/lit.py --test-suite /Devel/repos/llvm-test-suite --cmake-define TEST_SUITE_RUN_BENCHMARKS=0 --cmake-define TEST_SUITE_SUBDIRS=CTMark --cflags='-O0 -mllvm -global-isel -mllvm -global-isel-abort=2' --cmake-define=CMAKE_TOOLCHAIN_FILE:FILEPATH=$HOME/clang_aarch64_linux.cmake --use-cmake=/usr/bin/cmake
```
