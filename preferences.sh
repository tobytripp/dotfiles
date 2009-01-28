#!/bin/sh

# OS/X Preference Settings

## Hibernate Mode
# 0 - Old style sleep mode, with RAM powered on while sleeping, safe sleep
#     disabled, and super-fast wake.
# 1 - Hibernation mode, with RAM contents written to disk, system totally shut
#     down while “sleeping,” and slower wake up, due to reading the contents
#     of RAM off the hard drive.
# 3 - The default mode on machines introduced since about fall 2005. RAM is
#     powered on while sleeping, but RAM contents are also written to disk before
#     sleeping. In the event of total power loss, the system enters hibernation
#     mode automatically.
# 5 - This is the same as mode 1, but it’s for those using secure virtual
#     memory (in System Preferences -> Security).
# 7 - This is the same as mode 3, but it’s for those using secure virtual
#     memory.
#
# Default: 3 (pmset -g | grep hibernatemode)
pmset -a hibernatemode 0
