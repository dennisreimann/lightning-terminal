
#!/bin/bash

mkdir -p ./src/types/generated

if [[ "$GOBIN" == "" ]]; then
  if [[ "$GOPATH" == "" ]]; then
    echo "Required env var GOPATH is not set; aborting with error; see the following documentation which can be invoked via the 'go help gopath' command."
    go help gopath
    exit -1
  fi

  echo "Optional env var GOBIN is not set; using default derived from GOPATH as: \"$GOPATH/bin\""
  export GOBIN="$GOPATH/bin"
fi

PROTOC=`command -v protoc`
if [[ "$PROTOC" == "" ]]; then
  echo "Required "protoc" to be installed. Please visit https://github.com/protocolbuffers/protobuf/releases (3.5.0 suggested)."
  exit -1
fi

# Install protoc-gen-go from the vendored protobuf package to $GOBIN
#(cd ../../vendor/github.com/golang/protobuf && make install)

echo "Compiling protobuf definitions"
protoc \
  --plugin=protoc-gen-ts=./node_modules/.bin/protoc-gen-ts \
  -I ../proto \
  --js_out=import_style=commonjs,binary:./src/types/generated \
  --ts_out=service=grpc-web:./src/types/generated \
  ../proto/google/api/annotations.proto \
  ../proto/google/api/http.proto \
  ../proto/lnd.proto \
  ../proto/loop.proto