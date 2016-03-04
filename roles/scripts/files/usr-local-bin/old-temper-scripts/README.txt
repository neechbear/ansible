http://verahill.blogspot.co.uk/2013/12/532-temper-temperature-monitoring-usb.html
https://github.com/padelt/temper-python

sudo apt-get install python-usb python-setuptools snmpd git
sudo easy_install snmp-passpersist
mkdir ~/tmp
cd ~/tmp
git clone git://github.com/padelt/temper-python.git
cd temper-python/
sudo python setup.py install

