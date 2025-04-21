import re
print("nhap noi dung: ")

ndung = input()
print("noi dung: " + ndung)
regex1=re.compile(r'anh(.*?)rat');
kq=regex1.findall(ndung)
kq1=regex1.search(ndung)
print(kq1.group(1))
print(kq)
