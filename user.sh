cd ~ && git clone "https://github.com/BVLC/caffe.git" && cd caffe


cp Makefile.config.example Makefile.config
vim Makefile.config

USE_CUDNN := 1              #取消该句注释     没有用cuDNN则不用取消
CPU_ONLY := 1               #取消该句注释     仅使用CPU
OPENCV_VERSION := 3         #取消该句注释     没有opencv3.x则不用取消
WITH_PYTHON_LAYER := 1      #取消注释 
修改以下选项为：
PYTHON_INCLUDE := /usr/include/python2.7 /usr/lib/python2.7/dist-packages/numpy/core/include  
INCLUDE_DIRS := $(PYTHON_INCLUDE) /usr/local/include /usr/include/hdf5/serial   
LIBRARY_DIRS := $(PYTHON_LIB) /usr/local/lib /usr/lib /usr/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/hdf5/serial



cd /usr/lib/x86_64-linux-gnu
sudo ln -s libhdf5_serial.so.10.1.0 libhdf5.so
sudo ln -s libhdf5_serial_hl.so.10.0.2 libhdf5_hl.so
sudo ldconfig

cd ~/caffe
sudo make all -j8
make test && make runtest && make pycaffe && make distribute

# cd ~/caffe/python
# python
# import python

echo 'export PYTHONPATH=/home/wanghh/caffe/python:$PYTHONPATH' >> ~/.bashrc
source ~/.bashrc


cd ~/caffe/data/mnist
wget "http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz"
wget "http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz"
wget "http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz"
wget "http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz"
./examples/mnist/create_mnist.sh
./examples/mnist/train_mnist.sh