
NOTE: use dummy-creds

```toml
  # ~/.aws/credentials 
  [localdyndb]
  cli_pager =
  region = .
  aws_access_key_id = .     # use REQUIRED TYPE of dummy val
  aws_secret_access_key = . # use REQUIRED TYPE of dummy val
```


$ export AWS_PROFILE=localdyndb

$ make # download and start
