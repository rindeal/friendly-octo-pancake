# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-scanner/qmail-scanner-1.12.ebuild,v 1.1 2002/06/10 21:11:19 g2boojum Exp $

DESCRIPTION="E-Mail virus scanner for qmail."
HOMEPAGE="http://qmail-scanner.sourceforge.net"
DEPEND=">=sys-devel/perl-5.6.1-r1
        >=dev-perl/Time-HiRes-01.20
        >=net-mail/tnef-1.1.1
        >=net-mail/f-prot-3.12a
        >=net-mail/maildrop-1.3.9
        >=dev-perl/DB_File-1.803
        >=net-mail/qmail-1.03-r8"

#RDEPEND=""

SRC_URI="http://dl.sourceforge.net/qmail-scanner/${P}.tgz"

S=${WORKDIR}/${P}

src_compile () {
    # Do nothing
    echo
}

src_install () {
    yes | PATH=${PATH}:/opt/f-prot ./configure \
        --domain localhost \
           || die "./configure failed!"

    # Create Directory Structure
    diropts -m 755 -o qmailq -g qmail
    dodir /var/spool/qmailscan
    dodir /var/spool/qmailscan/quarantine
    dodir /var/spool/qmailscan/quarantine/tmp
    dodir /var/spool/qmailscan/quarantine/new
    dodir /var/spool/qmailscan/quarantine/cur
    dodir /var/spool/qmailscan/working
    dodir /var/spool/qmailscan/working/tmp
    dodir /var/spool/qmailscan/working/new
    dodir /var/spool/qmailscan/working/cur
    dodir /var/spool/qmailscan/archive
    dodir /var/spool/qmailscan/archive/tmp
    dodir /var/spool/qmailscan/archive/new
    dodir /var/spool/qmailscan/archive/cur

    # Install standard quarantine attachments file
    insinto /var/spool/qmailscan
    insopts -m 644 -o qmailq -g qmail
    doins quarantine-attachments.txt

    # Install qmail-scanner script
    insinto /var/qmail/bin
    insopts -m 4755 -o qmailq -g qmail
    doins qmail-scanner-queue.pl

    # Install documentation
    dodoc README CHANGES COPYING
    dohtml README.html
}

pkg_postinst () {
    # Setup perlscanner + Version Info
    /var/qmail/bin/qmail-scanner-queue.pl -z
    /var/qmail/bin/qmail-scanner-queue.pl -g

    echo
    echo "NOTICE:"
    echo "Set QMAILQUEUE=/var/qmail/bin/qmail-scanner-queue.pl"
    echo "in your /etc/tcp.smtp file to activate qmail-scanner."
    echo
}
