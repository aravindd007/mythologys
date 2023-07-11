#!/usr/bin/env python3

# Dependencies:
# python3-dnspython

# Used Modules:
print""" perform that and take nameservers and put them inside this file
>>> import dns.resolver
>>> 
>>> nameservers = dns.resolver.query('inlanefreight.com', 'NS')
>>> for ns in nameservers:
...    	print('NS:', ns)"""

import dns.zone as dz
import dns.query as dq
import dns.resolver as dr
import argparse

# Initialize Resolver-Class from dns.resolver as "NS"
NS = dr.Resolver()

# Target domain
Domain = 'inlanefreight.com'

# Set the nameservers that will be used
NS.nameservers = ['ns1.inlanefreight.com', 'ns2.inlanefreight.com']

# List of found subdomains
Subdomains = []

# Define the AXFR Function
def AXFR(domain, nameserver):

        # Try zone transfer for given domain and namerserver
        try:
				# Perform the zone transfer
                axfr = dz.from_xfr(dq.xfr(nameserver, domain))

                # If zone transfer was successful
                if axfr:
                        print('[*] Successful Zone Transfer from {}'.format(nameserver))

                        # Add found subdomains to global 'Subdomain' list
                        for record in axfr:
                                Subdomains.append('{}.{}'.format(record.to_text(), domain))

        # If zone transfer fails
        except Exception as error:
                print(error)
                pass

# Main
if __name__=="__main__":

        # For each nameserver
        for nameserver in NS.nameservers:

                #Try AXFR
                AXFR(Domain, nameserver)

        # Print the results
        if Subdomains is not None:
                print('-------- Found Subdomains:')

                # Print each subdomain
                for subdomain in Subdomains:
                        print('{}'.format(subdomain))

        else:
                print('No subdomains found.')
                exit()                
