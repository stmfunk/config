#system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

autoload -U colors && colors
PROMPT="%{$fg_bold[cyan]%}%n%{$reset_color%}:%{$fg[blue]%}%2~%{$reset_color%}$ "
RPROMPT="%{$fg[white]%}%?%{$reset_color%}"
alias ls="ls -GF"
alias vim="sudo vim"
alias updatedb="sudo /usr/libexec/locate.updatedb"
PATH=$PATH:/opt/lib/bin:/opt/local/bin:/Users/donal/.bin
HISTSIZE=2000
SAVEHIST=$HISTSIZE
HISTFILE="$HOME/.history"
setopt share_history

# init.sh
#
# to use the Fink hierarchy, put the following in your .profile:
#
#  . /sw/bin/init.sh
#

#
# Fink - a package manager that downloads source and installs it
# Copyright (c) 2001 Christoph Pfisterer
# Copyright (c) 2001-2011 The Fink Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110, USA.
#

# define append_path and prepend_path to add directory paths, e.g. PATH, MANPATH.
# add to end of path
append_path()
{
  if ! eval test -z "\"\${$1##*:$2:*}\"" -o -z "\"\${$1%%*:$2}\"" -o -z "\"\${$1##$2:*}\"" -o -z "\"\${$1##$2}\"" ; then
    eval "$1=\$$1:$2"
  fi
}

# add to front of path
prepend_path()
{
  if ! eval test -z "\"\${$1##*:$2:*}\"" -o -z "\"\${$1%%*:$2}\"" -o -z "\"\${$1##$2:*}\"" -o -z "\"\${$1##$2}\"" ; then
    eval "$1=$2:\$$1"
  fi
}

# setup fink related paths. we assume that the fink directories exists.
if [ -z "$PATH" ]; then
  PATH=/sw/bin:/sw/sbin:/bin:/sbin:/usr/bin:/usr/sbin
else
  prepend_path PATH /sw/bin:/sw/sbin
fi
export PATH

osMajorVer=`uname -r | cut -d. -f1`
osMinorVer=`uname -r | cut -d. -f2`
if [ -z "$MANPATH" ]; then
  if [ $osMajorVer -gt 7 ]; then
    MANPATH=`/usr/bin/manpath`
  else
    MANPATH=`/usr/bin/manpath -q`
  fi
fi
prepend_path MANPATH /sw/share/man
perlversion=`/usr/bin/perl -e 'printf("%vd\n", $^V)'`
append_path MANPATH /sw/lib/perl5/$perlversion/man
export MANPATH

if [ -z "$INFOPATH" ]; then
  INFOPATH=/sw/share/info:/sw/info:/usr/share/info
else
  prepend_path INFOPATH /sw/share/info:/sw/info
fi
export INFOPATH

if [ -r /sw/share/java/classpath ]; then
  if [ -z "$CLASSPATH" ]; then
    CLASSPATH=`cat /sw/share/java/classpath`:.
  else
    add2classpath=`cat /sw/share/java/classpath`
    prepend_path CLASSPATH $add2classpath
  fi
  export CLASSPATH
fi

if [ -z "$PERL5LIB" ]; then
  PERL5LIB=/sw/lib/perl5:/sw/lib/perl5/darwin
else
  prepend_path PERL5LIB /sw/lib/perl5:/sw/lib/perl5/darwin
fi
export PERL5LIB

# Add X11 paths (but only if the directories are readable)
if [ -r /usr/X11R6/bin ]; then
    append_path PATH /usr/X11R6/bin
    export PATH
fi
if [ -r /usr/X11R6/man ]; then
    append_path MANPATH /usr/X11R6/man
    export MANPATH
fi

# On Mac OS X 10.4.{x|x<3} there is a dyld bug (rdar://problem/4139432)
# where a library will not load if a library with a matching basename
# is already loaded from one of the system paths,
# the workaround is to set DYLD_FALLBACK_LIBRARY_PATH to :
if [ -z "$DYLD_FALLBACK_LIBRARY_PATH" ]; then
  if [ $osMajorVer -eq 8 -a $osMinorVer -lt 3 ]; then
    DYLD_FALLBACK_LIBRARY_PATH=:
    export DYLD_FALLBACK_LIBRARY_PATH
  fi
fi

PROXYHTTP=`grep ProxyHTTP /sw/etc/fink.conf | grep -v "#" | cut -d " " -f2`

if [ "$PROXYHTTP" != "" ]; then
  HTTP_PROXY=$PROXYHTTP
  http_proxy=$PROXYHTTP

  export HTTP_PROXY http_proxy
fi

PROXYFTP=`grep ProxyFTP /sw/etc/fink.conf | grep -v "#" | cut -d " " -f2`

if [ "$PROXYFTP" != "" ]; then
  FTP_PROXY=$PROXYFTP
  ftp_proxy=$PROXYFTP

  export FTP_PROXY ftp_proxy
fi

# read per-package scripts from /sw/etc/profile.d
if [ -d /sw/etc/profile.d ]; then
  for i in /sw/etc/profile.d/*.sh ; do
    if [ -r $i -a -x $i ]; then
      . $i
    fi
  done
  unset i
fi

# eof
bindkey -e
PATH=/Applications/Postgres.app/Contents/Versions/9.4/bin:/usr/local/sbin:/usr/local/bin:$PATH
export PATH=`echo $PATH | awk -F: '{for (i=1;i<=NF;i++) { if ( !x[$i]++ ) printf("%s:",$i); }}'|sed 's|/:|:|g'`

if [[ $((`date +%s` - `stat -f "%m" ~/today.txt`)) -gt 86400 ]]
then
  if [ ! "`pgrep tmux`" = "" ]
  then
    ~/.bin/today
  fi
else
  cat ~/today.txt
fi
