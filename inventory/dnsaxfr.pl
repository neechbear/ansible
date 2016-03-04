#!/usr/bin/env python2.7

#
#
# TODO - Write a dynamic inventory that pulls a DNS zone transfer from
#        our SOA master nameserver, and then uses that as the basis of
#        everything.
#
#

import dns.query
import dns.zone

z = dns.zone.from_xfr(dns.query.xfr('93.186.33.98', 'tfb.net'))
names = z.nodes.keys()
names.sort()
for n in names:
    print z[n].to_text(n)

