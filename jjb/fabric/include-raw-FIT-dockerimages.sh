#!/bin/bash -exu
set -o pipefail

cd gopath/src/github.com/hyperledger/fabric
FABRIC_COMMIT=$(git log -1 --pretty=format:"%h")
echo "FABRIC_COMMIT ===========> $FABRIC_COMMIT" >> commit.log
mv commit.log ${WORKSPACE}/gopath/src/github.com/hyperledger/
make peer-docker && make orderer-docker && docker images | grep hyperledger

# Clone fabric-ca git repository
################################

rm -rf ${WORKSPACE}/gopath/src/github.com/hyperledger/fabric-ca

WD="${WORKSPACE}/gopath/src/github.com/hyperledger/fabric-ca"
CA_REPO_NAME=fabric-ca
git clone https://github.com/hyperledger/$CA_REPO_NAME.git $WD
cd $WD
CA_COMMIT=$(git log -1 --pretty=format:"%h")
make docker && docker images | grep hyperledger

echo "CA COMMIT ========$CA_COMMIT" >> ${WORKSPACE}/gopath/src/github.com/hyperledger/commit.log
