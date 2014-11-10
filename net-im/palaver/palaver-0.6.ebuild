# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_DEPEND="2"

inherit distutils eutils python
DESCRIPTION="Multi-user chat component for jabber implemented in python"
HOMEPAGE="https://github.com/fritteli/palaver"
SRC_URI="https://github.com/fritteli/palaver/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="net-im/jabber-base"
RDEPEND=">=dev-python/twisted-core-2.4.0
	>=dev-python/twisted-words-0.5
	${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_compile() {
	# nothing to be done here?
	distutils_src_compile
}

src_install() {
	distutils_src_install

	insinto /etc/jabber
	newins "${FILESDIR}/"palaver.conf ${PN}.conf
	fperms 600 /etc/jabber/${PN}.conf
	fowners jabber:jabber /etc/jabber/${PN}.conf
#	dosed \
#		"s:<spool>[^\<]*</spool>:<spool>/var/spool/jabber</spool>:" \
#		/etc/jabber/${PN}.xml

	newinitd "${FILESDIR}/${PN}-initd" ${PN}
	newconfd "${FILESDIR}/${PN}-confd" ${PN}
}

pkg_postinst() {
	einfo "A sample config file has been installed into /etc/jabber/${PN}.conf."
	einfo "Please adjust the settings as needed."
}