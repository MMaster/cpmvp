#!/bin/bash

set -e

CPMVP_VERSION=${1:-0.1}
CORE_UTILS_VERSION=${2:-9.9}

curl -LO https://ftp.gnu.org/gnu/coreutils/coreutils-$CORE_UTILS_VERSION.tar.xz
tar xvJf coreutils-$CORE_UTILS_VERSION.tar.xz
rm coreutils-$CORE_UTILS_VERSION.tar.xz
(
    cd coreutils-$CORE_UTILS_VERSION/
    curl -LO https://raw.githubusercontent.com/jarun/advcpmv/master/advcpmv-$ADVCPMV_VERSION-$CORE_UTILS_VERSION.patch
    patch -p1 -i cpmvp-$CPMVP_VERSION-$CORE_UTILS_VERSION.patch
    autoreconf
    ./configure --enable-no-install-program='[,b2sum,base64,base32,basenc,basename,cat,chcon,chgrp,chmod,chown,cksum,comm,csplit,cut,date,dd,dir,dircolors,dirname,du,echo,env,expand,expr,factor,false,fmt,fold,ginstall,groups,head,id,join,kill,link,ln,logname,ls,md5sum,mkdir,mkfifo,mknod,mktemp,nl,nproc,nohup,numfmt,od,paste,pathchk,pr,printenv,printf,ptx,pwd,readlink,realpath,rm,rmdir,runcon,seq,sha1sum,sha224sum,sha256sum,sha384sum,sha512sum,shred,shuf,sleep,sort,split,stat,sum,sync,tac,tail,tee,test,touch,tr,true,truncate,tsort,tty,uname,unexpand,uniq,unlink,uptime,vdir,wc,whoami,yes'
    make
    cp ./src/cp ../cpmvp-cp
    cp ./src/mv ../cpmvp-mv
)
rm -rf coreutils-$CORE_UTILS_VERSION
