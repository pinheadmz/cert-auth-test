## Generate CA-signed cert for a domain with local authority

The bash script `run.sh` contains three openssl commands that all pull parameters
from configuration files in the `config/` directory. It will create a CA
certificate with Distinguished Name `"authority"` and a server SSL certificate
with Distinguished Name `"domain"` and Subject Alt Name containing the IP
address `127.0.0.1`. Obviously depending on your use case, these data should be
changed by altering the configuration files.

The first commit of this repository represents the initial setup and configuration.

The second commit represents the output of running the script, which corresponds
to the terminal dialog below. Note that the CA key is password-encrypted (for this
example the password is `password`) but the server SSL key is not. This makes
sense considering the server will need constant access to the key to establish
TLS handshake.

```
$ ./run.sh 
Generating a 4096 bit RSA private key
...................................................................++
................................................++
writing new private key to './output/ca.key'
Enter PEM pass phrase:
Verifying - Enter PEM pass phrase:
-----
Generating a 4096 bit RSA private key
.........++
..................++
writing new private key to './output/domain.key'
-----
Using configuration from config/sign.ca.conf
Enter pass phrase for ./output/ca.key:
Check that the request matches the signature
Signature ok
The Subject's Distinguished Name is as follows
commonName            :ASN.1 12:'domain'
Certificate is to be certified until Sep 22 15:01:24 2022 GMT (825 days)
Sign the certificate? [y/n]:y


1 out of 1 certificate requests certified, commit? [y/n]y
Write out database with 1 new entries
Data Base Updated
```

The output file `ca.crt` can be sent along with software and delivered securely
to users to install in their operating system or even be installed on-the-fly
(and only temporarily) by a
[nodejs package](https://nodejs.org/api/tls.html#tls_tls_createsecurecontext_options).

The output files `domain.crt` and `domain.key` will be required by a web server
serving data over SSL.


## Resources

This repository is based mostly on this helpful gist:

https://gist.github.com/Soarez/9688998

Additional resources include the openssl man page:

https://www.openssl.org/docs/man1.0.2/man1/ca.html

...and this amazing JavaScript x509 decoder:

https://lapo.it/asn1js/
