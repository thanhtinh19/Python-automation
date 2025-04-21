import io
import os
from shutil import copyfile
#get duong dan hien tai
print(os.getcwd())

f = open('test_file.txt', 'w')
f.close()

#os.rename('test_file.txt', 'file_test.txt')

#os.remove('file_test.txt')

copyfile('test_file.txt', 'test_file1.txt')


def WriteLineNoUtf8(filename, nd_line, n):
    f = open(filename, "a")
    for i in range(n):
        f.write(nd_line + ' ' + str(i) + '\n')
    f.close()
def WriteLineWithUtf8(filename, nd_line, n):
    f = io.open(filename, mode="a", encoding="utf-8")
    for i in range(n):
        f.write(nd_line + ' ' + str(i+1) + '\n')
    f.close()
def ReadFileNoUtf8(filename):
    f = open(filename, mode="r")
    #f.read()
    lines = f.readlines()
    #print(lines)
    for line in lines:
        print(line)
def ReadFileWithUtf8(filename):
    f = io.open(filename, mode="r", encoding="utf-8")
    lines = f.readlines()
    #print(lines)
    for line in lines:
        print(line)
print("Ghi file khong utf8:" )
WriteLineNoUtf8('test_file.txt', "Day la noi dung", 10)
ReadFileNoUtf8('test_file.txt')
print("Ghi file co utf8:" )
WriteLineWithUtf8('test_file1.txt', "Đây là nội dung thứ ", 10)
ReadFileWithUtf8('test_file1.txt')


