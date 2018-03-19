## Profile

#### Prerequisite

[awscli](https://docs.aws.amazon.com/cli/latest/userguide/installing.html)

AWS credential need to be placed in $HOME/.aws/credentials

```bash
$ cat $HOME/.aws/credentials
[user1]
aws_access_key_id = SOMERANDOMTEXT
aws_secret_access_key = some+random+text

[test]
aws_access_key_id = SOMERANDOMTEXT
aws_secret_access_key = some+random+text
```

(Optional) Some additional configuration can be placed in $HOME/.aws/config, note the profile keyword in square bracket
```bash
$ cat $HOME/.aws/config
[profile user1]
output = json
region = ap-southeast-2

[profile test]
output = json
region = ap-southeast-2
```

details can be found in [named profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-multiple-profiles.html)

#### Installation

With curl
```bash
$ curl -O https://raw.githubusercontent.com/tonysickpony/profile/master/profile
```

or with wget
```bash
$ wget https://raw.githubusercontent.com/tonysickpony/profile/master/profile
```

Make the script executable and move it into a directory in $PATH
```bash
# Recommanded
$ chmod +x profile
$ sudo mv profile /usr/local/bin/profile
```

Test the command by running with 0 arguments
```bash
$ profile
profile -- a program to list aws profile and print aws environment variables of given profile.

Usage: 
    profile <command> <profile-name>

Commands:
    list|ls
        List the available profiles found in $HOME/.aws/credentials file.
    switch <profile-name>
        Print all the environment variables of given profile name.

Example:
    List proflies:
        profile ls
    Print environment variables of profile 'test':
        profile switch test
    Enable profile 'test':
        eval $(profile switch test)
    Alternative way of running previous example:
        profile switch test | source
```
