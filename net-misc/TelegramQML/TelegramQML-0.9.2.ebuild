# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils ${GIT_ECLASS}

DESCRIPTION="Telegram API tools for QtQML and Qml"
HOMEPAGE="https://github.com/Aseman-Land/TelegramQML"
if [[ ${PV} == *9999* ]];then
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Aseman-Land/TelegramQML/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	RESTRICT="mirror"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPLv3"
SLOT="0"
IUSE=""

DEPEND="
	>=dev-libs/libqtelegram-ae-6.0
	dev-qt/qtxml:5
	dev-qt/qtimageformats:5
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's/\/$$LIB_PATH//g' ./telegramqml.pro
}

src_configure() {
	eqmake5 PREFIX="${EPREFIX}/usr" BUILD_MODE+=lib
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "Failed install"
}
