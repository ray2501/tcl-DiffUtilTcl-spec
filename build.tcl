#!/usr/bin/tclsh

set arch "x86_64"
set base "tcl-DiffUtilTcl-0.4.2"

if {[file exists $base]} {
    file delete -force $base
}

set var [list git clone https://github.com/pspjuth/DiffUtilTcl.git $base]
exec >@stdout 2>@stderr {*}$var

cd $base

set var2 [list git checkout bc69eb7646bd42e5f5812ed18bd1b4f578cda5bc]
exec >@stdout 2>@stderr {*}$var2

set var2 [list git reset --hard]
exec >@stdout 2>@stderr {*}$var2

cd ..

if {[file exists $base]} {
    file delete -force $base/.git
}

set var2 [list tar czvf ${base}.tar.gz $base]
exec >@stdout 2>@stderr {*}$var2

if {[file exists build]} {
    file delete -force build
}

file mkdir build/BUILD build/RPMS build/SOURCES build/SPECS build/SRPMS
file copy -force $base.tar.gz build/SOURCES

set buildit [list rpmbuild --target $arch --define "_topdir [pwd]/build" -bb tcl-DiffUtilTcl.spec]
exec >@stdout 2>@stderr {*}$buildit

# Remove our source code
file delete -force $base
file delete -force $base.tar.gz

