# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure the secrets in this file are kept private
# if you're sharing your code publicly.

development:
  secret_key_base: 504fd19f3c7e91bab6324fd3935e82d12a1a21a8f9fdb51ab9a4456cab9e72c1900f07cbd223db2436f8c3a9a4980af7b689616316275f79d27e1c58c808201f
  aws_access_key_id: AKIAIE5Q5UHWN3BKPZIA
  aws_secret_access_key: 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
  s3_bucket_name: portfolio.bucket.test

test:
  secret_key_base: 846cfa4d99f4dedff8e5f5156422027a2bb1401e45f19ea2a391846d76abc95e02accb50ffeed79164f0bbc41d55e2c5a073633e704ecd556f5c3afbb0f7fd88

# Do not keep production secrets in the repository,
# instead read values from the environment.
production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
  s3_bucket_name:      <%= ENV["S3_BUCKET_NAME"] || "to_define" %>
  aws_access_key_id:   <%= ENV["AWS_ACCESS_KEY_ID"] || "to_define" %>
  aws_secret_access_key:       <%= ENV["AWS_SECRET_ACCESS_KEY"] || "to_define" %>
