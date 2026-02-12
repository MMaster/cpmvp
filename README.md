![advcpmv](https://web.archive.org/web/20131217004029im_/http://beatex.org/web/advcopy/advcpmv-screen-20130313.png)

## cpmvp

cpmvp (CP & MV with Progress bars) is a mod for the GNU cp and GNU mv tools from coreutils which adds progress bars and info on what's going on during copy and move.

It is major refactor of Advanced Copy code which was written by Florian Zwicke and released under the GPLv3 and later maintained by Arun Prakash Jana (https://github.com/jarun).

cpmvp is currently written for coreutils version 9.9, which was not compatible with advcpmv because of refactoring of copy functionality in coreutils. The refactor of coreutils copy functionality was also inspiration for the rewrite of the advcpmv to hopefully make it easier to adapt to future coreutils versions.

## Original Advanced Copy

Original [Advanced Copy](http://beatex.org/web/advancedcopy.html) website appears to be dead. You can still find it via the [Internet Archive](https://web.archive.org/web/20131115171331/http://beatex.org/web/advancedcopy.html).

advcpmv-0.5-8.21.patch was the last patch released by the original author (on February 14, 2013) which was for coreutils 8.21.

Later patches were released on [advcpmv](https://github.com/jarun/advcpmv) github by jarun. At the time of writting this the last included patch is for coreutils version 9.7.

## What was refactored

- Code was extracted to separate source files to ease adaptation for future coreutils versions.
- Most of the code was rewritten and improved.
- No changes to coreutils function arguments are needed anymore, the functionality is added mostly just by inserting few function calls to coreutils code.
- Signal handlers were added to properly clean up terminal on CTRL+C.
- Terminal cleanup was improved to not clear important messages accidentally.
- Initial file enumeration was improved and calls to 'du' utility were replaced with internal size calculation.
- Output was slightly reworded / shortened.
- Removed build of unnecessary coreutils binaries from install process.

## Build instructions

Requires the following dependencies:

- patch
- autotools
- gcc

Run the following command to download, patch, compile coreutils and generate the files: `./cpmvp/cpmvp-cp` and `./cpmvp/cpmvp-mv`.

Bash:

```
curl https://raw.githubusercontent.com/MMaster/cpmvp/master/install.sh --create-dirs -o ./cpmvp/install.sh && (cd cpmvp && sh install.sh)
```

Fish:

```
curl https://raw.githubusercontent.com/MMaster/cpmvp/master/install.sh --create-dirs -o ./cpmvp/install.sh; and begin; cd cpmvp; and sh install.sh; end
```

To install an older version than the latest one, you can specify the version by passing it as an argument to the install script (at the end of the command, before the closing parenthesis). For example, if you want to install `cpmvp-0.1-9.9.patch` you would modify the command above like so.

```
... sh install.sh 0.1 9.9 ...
```

NOTE: Currently only version for coreutils 9.9 is provided. If you want version for older coreutils please use [advcpmv](https://github.com/jarun/advcpmv) for now.

## Usage

### Notes

Using this can introduce significant delay before files are moved or copied if you use it on directories with many files, because it first has to enumerate all files to figure out how many of them there are and how large they are.

### Change your cp and mv behaviour

You can install the binaries and use eg `cpmvp-cp -g` and `cpmvp-mv -g` instead of cp and mv:

```
sudo mv ./cpmvp/cpmvp-cp /usr/local/bin/
sudo mv ./cpmvp/cpmvp-mv /usr/local/bin/
```

Progress bar does not work with reflink (introduced v9.0 onwards). So reflink is disabled if using progress bar, left unchanged otherwise.

### Alias

You can install the binaries and create aliases for bash (or whatever you use)

```
sudo mv ./cpmvp/cpmvp-cp /usr/local/bin/
sudo mv ./cpmvp/cpmvp-mv /usr/local/bin/
```

Bash:

```
echo -e 'alias cp=\x27/usr/local/bin/cpmvp-cp -g\x27' >> ~/.bashrc
echo -e 'alias mv=\x27/usr/local/bin/cpmvp-mv -g\x27' >> ~/.bashrc
```

Fish:

```
echo alias cp '/usr/local/bin/cpmvp-cp -g' >> ~/.config/fish/config.fish
echo alias mv '/usr/local/bin/cpmvp-mv -g' >> ~/.config/fish/config.fish
```

```
## Upstream merge

The original author sent the patch to the team, that maintains the GNU CoreUtils. They won't merge this patch, because mv and cp are feature complete.
```

