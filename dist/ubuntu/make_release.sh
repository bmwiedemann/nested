#!/bin/bash

#sudo apt-get install devscripts build-essential fakeroot dh-make wget

export DEBFULLNAME="Carlos Miguel Jenkins Pérez"
export DEBEMAIL="carlos@jenkins.co.cr"

# Create Python sdist
echo "Entering to the distribution root..."
cd ../../
python setup.py sdist
echo "Entering to dist..."
cd dist/

# Copy source package
SDIST=`find . -maxdepth 1 -type f -name *.tar.gz`
DEBSDIST=`echo $SDIST | sed s/.tar.gz/.orig.tar.gz/ | sed s/-/_/`
cp $SDIST ubuntu/$DEBSDIST

# Build Debian source package
echo "Entering ubuntu..."
cd ubuntu/
tar -zxvf $DEBSDIST
DEBSDISTUN=`find . -maxdepth 1 -type d -name nested-*`
cp -R ../debian/debian/ $DEBSDISTUN/
rm $DEBSDISTUN/debian/changelog
cp debian/changelog $DEBSDISTUN/debian/changelog

# Build Debian package
echo "Entering $DEBSDISTUN..."
cd $DEBSDISTUN/
echo "Ready to build package. Press [Enter] to confirm structure and continue or Ctrl+C to cancel."
read
#debuild -S -us -uc
debuild -S

# Upload to PPA
echo "To upload to the PPA:"
echo "dput ppa:carlos.jenkins/nested <source.changes>"
