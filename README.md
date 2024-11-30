
NOTE: use dummy-creds

```toml
  # ~/.aws/config
  [localdyndb]
  cli_pager =
  region = eu-west-1
  aws_access_key_id = fake
  aws_secret_access_key = fake
```

  $ export AWS_PROFILE=localdyndb

  $ make # download and start

  # Then in another shell:

  $ make list
