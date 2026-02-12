#!/bin/bash

set -e

CPMVP_VERSION=${1:-0.1}
CORE_UTILS_VERSION=${2:-9.9}

curl -LO https://ftp.gnu.org/gnu/coreutils/coreutils-$CORE_UTILS_VERSION.tar.xz
tar xvJf coreutils-$CORE_UTILS_VERSION.tar.xz
rm coreutils-$CORE_UTILS_VERSION.tar.xz
(
    cd coreutils-$CORE_UTILS_VERSION/
    curl -LO https://raw.githubusercontent.com/MMaster/cpmvp/master/cpmvp-$CPMVP_VERSION-$CORE_UTILS_VERSION.patch
    patch -p1 -i cpmvp-$CPMVP_VERSION-$CORE_UTILS_VERSION.patch
    autoreconf
    ./configure --enable-no-install-program='[,b2sum,base64,base32,basenc,basename,cat,chcon,chgrp,chmod,chown,chroot,cksum,comm,csplit,cut,date,dd,df,dir,dircolors,dirname,du,echo,env,expand,expr,factor,false,fmt,fold,ginstall,getlimits,groups,head,hostid,id,join,kill,link,ln,logname,ls,md5sum,mkdir,mkfifo,mknod,mktemp,nice,nl,nproc,nohup,numfmt,od,paste,pathchk,pinky,pr,printenv,printf,ptx,pwd,readlink,realpath,rm,rmdir,runcon,seq,sha1sum,sha224sum,sha256sum,sha384sum,sha512sum,shred,shuf,sleep,sort,split,stat,stdbuf,stty,sum,sync,tac,tail,tee,test,timeout,touch,tr,true,truncate,tsort,tty,uname,unexpand,uniq,unlink,uptime,users,vdir,wc,who,whoami,yes'
    make
    cp ./src/cp ../cpmvp-cp
    cp ./src/mv ../cpmvp-mv
)
rm -rf coreutils-$CORE_UTILS_VERSION
