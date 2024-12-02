import Config

config :advent_of_code, AdventOfCode.Input,
  allow_network?: true,
  session_cookie:
    "53616c7465645f5fcfe503d8c9104080e3cfbd864c07c9ad08de8c43a49ae564f68f498ceaf8e8706562352c886ffdaf5e3b85307f94400f800875e82047668b"

# If you don't like environment variables, put your cookie in
# a `config/secrets.exs` file like this:
#
# import Config
# config :advent_of_code, AdventOfCode.Input,
#   session_cookie: "..."

try do
  import_config "secrets.exs"
rescue
  _ -> :ok
end
