GNU Privacy Guard I/O Utilities
===============================

Provides a simple, yet reasonably secure, set of shell utilities to edit, read
and delete files encrypted with the GnuPG utility.

Please note that while the security of these utilities are not bullet-proof it
should provide good enough security for most use cases.

## How it works

While editing, files are always decrypted to a temporary file system in memory.
This will prevent anyone from recovering temporarily decrypted data from your
hard drive (by not using the hard drive at all).

While reading, the decrypted data is output with `less` in "secure" mode. This
will prevent the output from being saved in the shell history when you're done
reading.

Deletion of files are done with the `shred` command to minimize the risk of data
recovery from the hard drive.

## Installation

First you need to install all dependencies:

```sh
sudo apt-get install gnupg make
```

Clone the Git repository and use the `make` utility to install:

```sh
git clone [URL] gnupgio
cd gnupgio
sudo make install
```

Before you start using the utilities you will need to generate your own GPG key.
Run the below command and follow the instructions:

```sh
gpg --gen-key
```

## Usage

To securely create or edit an encrypted file:

```sh
gpg-edit [FILE]
# Follow the instructions after closing your editor to add GPG recipients
```

To securely read an encrypted file:

```sh
gpg-read [FILE]
# Press 'q' after you are done reading the file
```

To securely delete an encrypted file:

```sh
gpg-delete [FILE]
```

## Why shell scripts?

Because there wasn't time for anything else. Shell scripts are also very simple.

## Disclaimer

ANY USE OF THIS SOFTWARE IS AT YOUR OWN RISK. PLEASE BE AWARE THAT ANY
INFORMATION PROCESSED BY THIS SOFTWARE MAY GET LOST FOR EVER.
