# VENDOR_VERSION = .00.01

# ONIE arch, support X86、ARM、PPC now.
ONIE_ARCH ?= x86_64

# ASIC vendor, support bcm/bft/cavium/centec/mlnx/mvl/nephos/none/qemu now.
SWITCH_ASIC_VENDOR = bcm
VENDOR_REV ?= 0

# different hardware version needs different onie version, user version r0 now.
ifeq ($(VENDOR_REV),0)
  MACHINE_REV = 0
else
  $(warning Unknown VENDOR_REV '$(VENDOR_REV)' for MACHINE '$(MACHINE)')
  $(error Unknown VENDOR_REV)
endif

# Vendor ID -- IANA
# Reference http://www.iana.org/assignments/enterprise-numbers
# Micas IANA
VENDOR_ID = 60401

UEFI_ENABLE = yes
# PXE_EFI64_ENABLE = yes

I2CTOOLS_ENABLE = yes
#I2CTOOLS_ENABLE = no

# Set console, default use console dev 0, brad 115200
CONSOLE_SPEED = 115200
CONSOLE_PORT = 0x5060
# CONSOLE_DEV = 0

# Set Linux kernel version 
LINUX_VERSION           = 4.19
LINUX_MINOR_VERSION     = 143
LINUX_RELEASE           ?= $(LINUX_VERSION).$(LINUX_MINOR_VERSION)
LINUX_TARBALL           ?= linux-$(LINUX_RELEASE).tar.xz
# LINUX_TARBALL_URLS  ?= https://192.168.23.73/svn/onie/download/

# Set GCC version
GCC_VERSION = 8.3.0

#-------------------------------------------------------------------------------
#
# Local Variables:
# mode: makefile-gmake
# End:
