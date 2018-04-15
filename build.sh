#!/bin/bash
./configure --prefix=/usr              \
            --libexecdir=/usr/lib      \
            --with-secure-path         \
            --with-all-insults         \
            --with-env-editor          \
            --docdir=/usr/share/doc/sudo-1.8.20p2 \
            --with-passprompt="[sudo] password for %p: "
make -j $SHED_NUM_JOBS
make "DESTDIR=$SHED_FAKE_ROOT" install
ln -sfv libsudo_util.so.0.0.0 "${SHED_FAKE_ROOT}/usr/lib/sudo/libsudo_util.so.0"
rm "${SHED_FAKE_ROOT}/etc/sudoers"
mv "${SHED_FAKE_ROOT}/etc/sudoers.dist" "${SHED_FAKE_ROOT}/etc/sudoers.default"
sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g" "${SHED_FAKE_ROOT}/etc/sudoers.default"
