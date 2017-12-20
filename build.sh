#!/bin/bash
./configure --prefix=/usr              \
            --libexecdir=/usr/lib      \
            --with-secure-path         \
            --with-all-insults         \
            --with-env-editor          \
            --docdir=/usr/share/doc/sudo-1.8.20p2 \
            --with-passprompt="[sudo] password for %p: "
make -j $SHED_NUMJOBS
make "DESTDIR=$SHED_FAKEROOT" install
ln -sfv libsudo_util.so.0.0.0 "${SHED_FAKEROOT}/usr/lib/sudo/libsudo_util.so.0"
rm "${SHED_FAKEROOT}/etc/sudoers"
mv "${SHED_FAKEROOT}/etc/sudoers.dist" "${SHED_FAKEROOT}/etc/sudoers.default"
