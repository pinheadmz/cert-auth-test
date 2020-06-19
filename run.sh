# Generate new key and self-signed CA certificate using config file
# for key size, digest algorithm, x509 extensions, etc.
# The only parameter set in this command is the expiration time (10 years)
openssl req -new -x509 -days 3650 -config config/req.ca.conf -out output/ca.crt

# Generate a Certificate Signing Request using config file
openssl req -new -out output/domain.csr -config config/req.domain.conf

# Finally sign the domain's CSR with the CA certificate using config file
openssl ca -config config/sign.ca.conf -extfile config/req.domain.conf \
-extensions my_extensions -out output/domain.crt -infiles output/domain.csr