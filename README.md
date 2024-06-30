Convert Roms
==========

Repository to gather a working version of the utilities to convert 3ds roms into different formats (cia, cci, 3ds) in unix (only tested in linux :P) and windows

You should probably refer to the original projects

* [cia-unix](https://github.com/shijimasoft/cia-unix)
* [Batch CIA 3DS Decryptor](https://gbatemp.net/threads/batch-cia-3ds-decryptor-a-simple-batch-file-to-decrypt-cia-3ds.512385)
* [3DS-stuff](https://github.com/matiffeder/3DS-stuff)
* [3dsconv](https://github.com/ihaveamac/3dsconv)
* [3DS To CIA Converter](https://www.reddit.com/r/Roms/comments/9mb3vo/easy_guide_on_how_to_download_cias3ds_roms)

## 3DS To CIA Converter

### HOW TO TURN THEM INTO 3DS FILES

Make sure you do this before you try to decrypt them

1. Open the folder "3DS To CIA Converter" (it's named backwards but it doesn't matter)
1. Move whichever CIA you're trying to use into it, with the rest of the files in it
1. Open the Batch File "3DS-To-CIA-Converter.bat"
1. Press 3, Enter, 6, Enter, then put in what the .CIA file's name is (including the .CIA)
1. Wait
1. Done with this part, you'll find a .3DS file in the folder. I'm not sure if it's just for me for some reason, but 2 files appear, one that ends in "-tmp" and one that ends in "-alt". I'm not sure what the difference is and I haven't tried both, but if I were you, I'd be safe and just use the -alt file cause those were working for me, haven't tried the -tmp ones.

But, that's not all you have to do to play it on Citra.

### HOW TO DECRYPT .3DS FILES

1. Do what you did last time again
1. Again, open up the folder and drop the converted .3DS file into it.
1. Run the batch file called "Batch CIA 3DS Decryptor.bat"
1. Wait for it to finish. This will take a while, so give it some time. Your PC might freeze but it'll work eventually
1. Another file will appear in the folder, which will be the same file but it ends in "decrypted". This will work with Citra

### HOW TO LOAD THEM INTO CITRA (You do not need to do it this way, but it is very convenient)

1. Make sure your Citra is updated. (RIP Citra)
1. Keep your decrypted game in the folder that decrypts the games
1. Open Citra, obviously.
1. Double click on "Add New Game Directory"
1. Go to the decrypt folder. Click it and press "Select Folder" in the bottom right.

Your decrypted games will now instantly appear on the Citra homescreen right from the folder so you don't have to move them anywhere else after doing it

## 3dsconv

1. Download Python3 and pip (I used ubuntu's apt-get; YMMV), then install pyaes with pip install pyaes
1. Get your .3ds backups, boot9.firm and 3dsconv.py all into the same folder
1. Into that folder, run python3 3dsconv.py --boot9=boot9.bin \*.3ds
1. ???
1. Profit!

