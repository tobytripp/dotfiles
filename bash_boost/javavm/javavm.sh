source ./java_paths

VERSION=$1

sudo rm $JAVA_INSTALL/Current
sudo ln -s $JAVA_INSTALL/Current $JAVA_13