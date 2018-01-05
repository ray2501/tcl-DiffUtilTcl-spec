%{!?directory:%define directory /usr}

%define buildroot %{_tmppath}/%{name}

Name:          tcl-DiffUtilTcl
Summary:       A Tcl extension for diff utility functions
Version:       0.4
Release:       0
License:       Tcl
Group:         Development/Libraries/Tcl
Source:        tcl-DiffUtilTcl-0.4.tar.gz
URL:           https://github.com/pspjuth/DiffUtilTcl
BuildRequires: autoconf
BuildRequires: make
BuildRequires: tcl-devel >= 8.5
Requires:      tcl >= 8.5
BuildRoot:     %{buildroot}

%description
A Tcl extension for comparing files and other diff tasks.

%prep
%setup -q -n %{name}-%{version}

%build
./configure \
	--prefix=%{directory} \
	--exec-prefix=%{directory} \
	--libdir=%{directory}/%{_lib}
make 

%install
make DESTDIR=%{buildroot} pkglibdir=%{tcl_archdir}/%{name}%{version} install

%clean
rm -rf %buildroot

%files
%defattr(-,root,root)
%{tcl_archdir}
%{directory}/share/man/mann

