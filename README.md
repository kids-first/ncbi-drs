# ncbi-drs

An implementation of GA4GH's Data Repository Service (DRS).

# If running on Ubuntu 18.04 LTS (recommended):
```
sudo apt-get install python3 python3-pip shellcheck jq protobuf-compiler
```

# If running on Amazon Linux:
```
sudo yum -y install python3-devel
#and you may need to remove "python3.6" from .pre-commit-config.yaml
```

# Python prerequisites
```
pip3 install -r requirements.txt -r test-requirements.txt
~/.local/bin/pre-commit install
```

# Pre-commit flight check
```
pre-commit run --all-files
```

# To package outside Jenkins:
```
./package.sh
```

# To run tests, container will listen on external port 80
```bash
$ ./test.sh
```

# To run container, listening on port 80
```bash
docker run --publish 80:80 --detach drs
```
