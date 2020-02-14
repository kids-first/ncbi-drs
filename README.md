# ncbi-drs

An implementation of GA4GH's Data Repository Service (DRS).

# If running on Ubuntu 18.04 LTS (recommended):
```bash
sudo apt-get install python3 python3-pip shellcheck jq protobuf-compiler
```

# If running on Amazon Linux 2:
```bash
sudo yum -y install python3-devel git gcc-c++
pip3 install -r requirements.txt -r test-requirements.txt
```

# Python prerequisites
```bash
pip3 install -r requirements.txt -r test-requirements.txt
~/.local/bin/pre-commit install
```

# Pre-commit flight check
```bash
pre-commit run --all-files
```

# To package outside Jenkins:
```bash
./package.sh
```

# To run tests, container will listen on external port 80
```bash
./test.sh
```

# To run container, listening on port 80
```bash
docker run --publish 80:80 --detach drs
```
