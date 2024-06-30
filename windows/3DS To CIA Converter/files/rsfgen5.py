import struct
import binascii
import array 
import sys
import os.path

if str(sys.argv[2]) == "true":
	with open(os.path.dirname(__file__) + "\..\exefs\icon.bin", "r+b") as f:
		f.seek(8216)
		f.write("\x7F\xFF\xFF\xFF")
		f.close
	with open(os.path.dirname(__file__) + "\..\exheader.bin", "r+b") as f:
		f.seek(13)
		f.write("\x01")
		f.close
else:
	pass
if str(sys.argv[2]) == "false":
	with open(os.path.dirname(__file__) + "\..\exheader.bin", "r+b") as f:
		f.seek(13)
		f.write("\x01")
		f.close
else:
	pass
gamename = str(sys.argv[1])
with open(gamename, "rb") as f:
	f.seek(397) # Card type (Card1, Card2)
	ctype = f.read(1)
	ctype = str(int(binascii.hexlify(ctype),16))
	ctype= "Card"+ctype
	f.seek(4361) # UniqueId
	uid = f.read(4)
	uid = binascii.hexlify(uid)[::-1]
	c = list(uid)
	c[::2], c[1::2] = c[1::2], c[::2]
	uid = "".join(c)
	f.seek(4368) # CompanyCode
	read = f.read(2)
	ccode = "".join(struct.unpack('<cc', read))
	f.seek(4432) # ProductCode
	read = f.read(10)
	pcode = "".join(struct.unpack('<cccccccccc', read))
	print ccode
	print pcode
	print uid
	f.close
	with open(os.path.dirname(__file__) + "\..\exheader.bin", "r") as f:
		f.seek(0) # Title
		read = f.read(8)
		title = "".join(struct.unpack('<cccccccc', read))
		title = title.rstrip(' \0')
		f.seek(28) # Stacksize
		stack = f.read(4)
		stack = (binascii.hexlify(stack))[::-1]
		c = list(stack)
		c[::2], c[1::2] = c[1::2], c[::2]
		stack = "".join(c)
		f.close
		rsfname = "RSF.rsf"
		with open(os.path.dirname(__file__) + "\..\\" + rsfname, "r+") as f:
			f.seek(41) # Title
			s = str(title)
			f.write(s)
			f.seek(100) # CompanyCode
			s=str(ccode)
			f.write(s)
			f.seek(152) # ProductCode
			s=str(pcode)
			f.write(s)
			f.seek(308) # UniqueId
			s=str(uid)
			f.write(s)
			f.seek(435) # Card type
			s=str(ctype)
			f.write(s)
			f.close