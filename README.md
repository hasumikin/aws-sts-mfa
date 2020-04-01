## aws-sts-mfa

### Prerequisite

- aws-cli
- Ruby

### Installation

```
git clone https://github.com/hasumikin/aws-sts-mfa.git
cd aws-sts-mfa
./install.sh
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

