start menu not working - rebuild index will works
https://www.itpro.co.uk/operating-systems/34614/how-to-fix-the-windows-10-start-menu-if-its-frozen


#download all file from mobile

curl ftp://192.168.29.35:41825/DCIM/OpenCamera/  | awk '{print $9}' > mobilefiles.txt

 for i in `cat mobilefiles.txt`; do 
 echo "================================"
 echo "downloading $i"; 
 curl ftp://192.168.29.35:41825/DCIM/OpenCamera/$i -o $i; 
 echo "================================" 
 done
