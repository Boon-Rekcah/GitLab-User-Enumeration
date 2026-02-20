# GitLab-User-Enumeration

I am not the original author of this code; I have modified to have have Verbose enabled and Disable functionality along with nice colors.

You can access the original version here: https://www.exploit-db.com/exploits/49821

# Usage

## Make it executable
```bash
chmod +x gitlabuserenum.sh
```

## Run without Verbose Mode
```bash
./gitlabuserenum.sh --url http://Target-URL/ --userlist users.txt
```

## Run with Verbose Mode
```bash
./gitlabuserenum.sh --url http://Target-URL/ --userlist users.txt -v
```

