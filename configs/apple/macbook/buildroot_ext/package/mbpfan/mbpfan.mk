################################################################################
#
# mbpfan
#
################################################################################

MBPFAN_VERSION = 2.2.1
MBPFAN_SITE = $(call github,linux-on-mac,mbpfan,v$(MBPFAN_VERSION))
MBPFAN_LICENSE = GPL-3.0+
MBPFAN_LICENSE_FILES = COPYING

define MBPFAN_BUILD_CMDS
	$(TARGET_MAKE_ENV) CFLAGS="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)" \
		$(MAKE) CC="$(TARGET_CC)" -C $(@D)
endef

define MBPFAN_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/bin/mbpfan $(TARGET_DIR)/usr/sbin/mbpfan
endef

define MBPFAN_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(@D)/mbpfan.service \
		$(TARGET_DIR)/usr/lib/systemd/system/mbpfan.service

	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants

	ln -sf /usr/lib/systemd/system/mbpfan.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/mbpfan.service
endef

$(eval $(generic-package))
