## aws-sts-mfa

### Prerequisite

- aws-cli
- Ruby

### Installation

```
git clone https://github.com/hasumikin/aws-sts-mfa.git
cd aws-sts-mfa
make install
```

### Uninstallation

```
cd aws-sts-mfa
make uninstall
```

### Configuration

Edit `config.yml`

### Usage

```
aws-sts-mfa [pofile_name] [MFA token] && . ~/.awsrc
```

For example,

```
aws-sts-mfa default 123456 && . ~/.awsrc
```

