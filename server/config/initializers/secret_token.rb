# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Sm::Application.config.secret_key_base = 'bc8a5529d72b680ba36671618a88cc0eabad860a3bfbb1714efd8c37d9b1f969d3dbfef5b1f6e2affa4ac04982900893b3f8c3c819e5ba775aedc99b45602ec3'
