# hashSplit
HashSplit receives an input, convert to base64 and split this base64 in multiples blocks to
generate qrcodes.

The main reason to create this is to have an easy way to split long base64 files and save as
png qrcode files.

### Dependencies

 * bash
 * qrencode
 * base64

### How to use:

This script has two commands:

  * build
  _Receives two arguments input and output to generate the qrcode files._

  Sample:

  ```
  hashsplit build myfile split
  ```
  _This command will generate qrcode images from base64 of myfile as `split-01...N.png`._

  An aditional qrcode image will be generated, this qrcode is called dm(distinguish mark)
  it could be useful if you need to know the order to remount the original hash. So it's a
  clue with 8 characters to recreate the base64 in the right order.

  * clean
  _Receives one argument as input._

  Sample:

  ```
  hashsplit clean split
  ```

  will clean all the qrcodes and the dm file created.

### Environments

You can change the `$blk`(block) variable to increase or decrease the quantite of characters will
be used to split in qrcodes. Keep in mind the max size of a qrcode is 2549 bytes and if you decide
to create a huge qrcode it could be very painful to be scaned or printed.
So I recommend use 500 or less.


  Enjoy!
  By: Isca
  :wink:


