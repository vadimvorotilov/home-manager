$env.config.show_banner = false

$env.PATH = ($env.PATH | prepend [$"($env.HOME)/.local/bin" $"($env.HOME)/bin"] | uniq)
