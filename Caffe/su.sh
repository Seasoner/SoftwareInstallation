sudo apt-get update

sudo apt-get upgrade

cd ~ && mkdir tempDir && cd tempDir

sudo apt-get install -y vim git cmake g++ build-essential pkg-config


wget "https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb"
sudo dpkg -i cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64.deb
sudo apt-get update
sudo apt-get install -y cuda

sudo echo 'export PATH=/usr/local/cuda/bin:$PATH' >> /etc/profile
sudo echo '/usr/local/cuda/lib64' >> /etc/ld.so.conf.d/cuda.conf
sudo ldconfig


# cd /usr/local/cuda/samples
# sudo make all -j8
# cd bin/x86_64/linux/release
# ./deviceQuery


# tar -zxvf cudnn-6.5-linux-x64-v2.tgz
# cd cudnn-6.5-linux-x64-v2
# sudo cp lib64/* /usr/local/cuda/lib64/
# sudo cp include/cudnn.h /usr/local/cuda/include/
# sudo ldconfig


sudo apt-get install libatlas-base-dev


sudo apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get install --no-install-recommends libboost-all-dev
sudo apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev


sudo apt-get install -y python-pip python-dev python-numpy python-scipy python-matplotlib

git clone "https://github.com/BVLC/caffe.git"
cd caffe/python
for req in $(cat requirements.txt); do pip install $req; done
sudo pip install ipython=5.0

sudo apt-get install libopencv-dev python-opencv


cd ~/tempDir
sudo rm cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64.deb
sudo rm -rf caffe
cd .. 
sudo rm -rf tempDir