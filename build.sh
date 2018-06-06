#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
# Configure
./configure --prefix=/usr              \
            --libexecdir=/usr/lib      \
            --with-secure-path         \
            --with-all-insults         \
            --with-env-editor          \
            --docdir="$SHED_PKG_DOCS_INSTALL_DIR" \
            --with-passprompt="[sudo] password for %p: " &&
# Build and Install
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install &&
ln -sfv libsudo_util.so.0.0.0 "${SHED_FAKE_ROOT}/usr/lib/sudo/libsudo_util.so.0" &&
sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g" "${SHED_FAKE_ROOT}/etc/sudoers.dist"
install -vDm400 "${SHED_FAKE_ROOT}/etc/sudoers.dist" "${SHED_FAKE_ROOT}${SHED_PKG_DEFAULTS_INSTALL_DIR}/etc/sudoers" &&
rm "${SHED_FAKE_ROOT}/etc/sudoers" &&
rm "${SHED_FAKE_ROOT}/etc/sudoers.dist" || exit 1
# Optionally Remove Documentation
if [ -z "${SHED_PKG_LOCAL_OPTIONS[docs]}" ]; then
    rm -rf "${SHED_FAKE_ROOT}${SHED_PKG_DOCS_INSTALL_DIR}"
fi
