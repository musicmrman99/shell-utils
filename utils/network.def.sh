alias printip="ifconfig | grep 'inet addr:192.168.1.' | awk -F':' '{print \$2}' | awk -F' ' '{print \$1}'"
