# pmarko1711/bitwardenbackup
Simple Docker image to backup bitwarden passwords with.


## Usage

### Stdout (raw) output

```bash
docker run --rm -e BW_USER=bitwardenemail -e BW_PASS=bitwardenpassword -e RAW=1 pmarko1711/bitwardenbackup
```

### File (encrypted) output
```
docker run --rm -it -e BW_USER=bitwardenemail -e BW_PASS=bitwardenpassword -e OUTFILE=bw.bck -v /path/to/folder/:/output pmarko1711/bitwardenbackup
```
* Encryption is performed using gpg2 with a symmetric cypher with `BW_PASS` used as the passphrase unless `GPG_PASS` is set (in which case the latter is used).
    * decrypt e.g. using `gpg2 -d filename` (or `echo "password" | gpg --batch --passphrase-fd 0 -d /file/to/backup`)
* WSL2 - use `-v c:/path/to/folder/:/output` volume format

* You might want to delete the volume after not to keep the file, especially if contains raw passwords (see `docker volume help`).



## Parameters


| Parameter | Type | Function |
| :----: | --- | --- |
| `BW_USER` | env var | bitwarden username (email) |
| `BW_PASS` | env var | bitwarden password |
| `RAW` | env var | if set, output bitwarden's JSON output|
| `OUTFILE` | env var | filename to write to, if empty, output will be written to `stdout`|
| `/output` | volume | folder to write output to, only necessary if `OUTFILE` set|
| `GPG_PASS` | env var | custom password to use for encryption |
