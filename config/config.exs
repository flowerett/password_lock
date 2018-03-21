use Mix.Config

config :password_lock, author: "flowerett"
config :password_lock, version: "0.1.1"

import_config "#{Mix.env()}.exs"
