# Ubuntu16.04+CUDA8.0+GPU配置Caffe环境(python2.7.x + opencv2.4.x)

----------

## 一. 软件依赖

### **Necessary Dependencies：**
 - CUDA：GPU模式必备，推荐7+以上驱动版本，6.x也可以。
 - BLAS：ATLAS, MKL, OpenBLAS
 - Boost：版本>=1.55
 - protobuf, glog, gflags, hdf5

### **Optional Dependencies：**
 - OpenCV>=2.4 including 3.0
 - IO libraries：lmdb, leveldb(prerequisite snappy)
 - cuDNN for GPU acceleration(version 6)

## 二. 软件安装

### **1. 安装基础软件**
`sudo apt-get update`
`sudo apt-get upgrade`
`sudo apt-get install build-essential pkg-config`

----------


`sudo apt-get install vim git cmake g++`

### **2. 安装CUDA** （到NVIDIA官网下载deb包或者runfile文件）

a). 下载deb包安装：
`wget "https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb"`
`sudo dpkg -i cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64.deb`
`sudo apt-get update`
`sudo apt-get install cuda`
b). 下载runfile文件安装
`wget "https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run"`
`sudo chmod a+x cuda_8.0.61_375.26_linux-run`
`sudo sh cuda_8.0.61_375.26_linux.run` and follow the command-line prompts

----------

`sudo vim /etc/profile` 末尾添加 `export PATH=/usr/local/cuda/bin:$PATH`
`sudo vim /etc/ld.so.conf.d/cuda.conf`  末尾添加 `/usr/local/cuda/lib64`
`sudo ldconfig`

### **3. 测试CUDA** 
`cd /usr/local/cuda/samples`
`sudo make all -j8`
`cd bin/x86_64/linux/release`
`./deviceQuery`

### **4. 安装cuDNN** （到NVIDIA官网注册下载cuDNN(version=6)的tar文件）
`tar -zxvf cudnn-6.5-linux-x64-v2.tgz`
`cd cudnn-6.5-linux-x64-v2`
`sudo cp lib64/* /usr/local/cuda/lib64/`
`sudo cp include/cudnn.h /usr/local/cuda/include/`
`sudo ldconfig`

### **5. 安装BLAS** （安装ATLAS或者OpenBLAS或者MKL）
a). `sudo apt-get install libatlas-base-dev`
b). `sudo apt-get install libopenblas-dev`

### **6. 安装General Dependencies** 
`sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler`
`sudo apt-get install --no-install-recommends libboost-all-dev`
`sudo apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev`

### **7. 安装Python接口依赖** 
`sudo apt-get install python-pip`
`sudo apt-get install -y python-dev`
`sudo apt-get install -y python-numpy python-scipy python-matplotlib`

---------

`git clone "https://github.com/BVLC/caffe.git"`
`cd caffe/python`
`sudo su`
`for req in $(cat requirements.txt); do pip install $req; done`
`pip install ipython=5.0`

----------

安装opencv2.4.x（或者编译安装opencv3.x）
`sudo apt-get install libopencv-dev`
`sudo apt-get install python-opencv`

### **8. 编译安装Caffe和Python接口**
`cd ../`
`cp Makefile.config.example Makefile.config`
`vim Makefile.config`
USE_CUDNN := 1              #取消该句注释     没有用cuDNN则不用取消
CPU_ONLY := 1               #取消该句注释     仅使用CPU
OPENCV_VERSION := 3         #取消该句注释     没有opencv3.x则不用取消
WITH_PYTHON_LAYER := 1      #取消注释 
修改以下选项为：
PYTHON_INCLUDE := /usr/include/python2.7 /usr/lib/python2.7/dist-packages/numpy/core/include  
INCLUDE_DIRS := $(PYTHON_INCLUDE) /usr/local/include /usr/include/hdf5/serial   
LIBRARY_DIRS := $(PYTHON_LIB) /usr/local/lib /usr/lib /usr/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/hdf5/serial

`cd /usr/lib/x86_64-linux-gnu`
`sudo ln -s libhdf5_serial.so.10.1.0 libhdf5.so`
`sudo ln -s libhdf5_serial_hl.so.10.0.2 libhdf5_hl.so`
`sudo ldconfig`

`cd ~/caffe`
`sudo make all -j8`
`make test && make runtest && make pycaffe && make distribute`

----------

`cd ~/caffe/python`
`python`
`import python`


`vim ~/.bashrc` 末尾添加  `export PYTHONPATH=/home/wanghh/caffe/python:$PYTHONPATH`
`source ~/.bashrc`  这样其他地方也可以直接导入caffe


## 三. 软件测试（下载并训练CNN with MNIST）
`cd ~/caffe/data/mnist`
`wget "http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz"`
`wget "http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz"`
`wget "http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz"`
`wget "http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz"`
`./examples/mnist/create_mnist.sh`
`./examples/mnist/train_mnist.sh`
    
