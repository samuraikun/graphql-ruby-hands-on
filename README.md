# devcontainer for Ruby 3.3 and Rails 7.1 and graphql-ruby

[devcontainer](https://code.visualstudio.com/docs/remote/containers) for Ruby3.3, Ruby on Rails 7.1

- language server: [solargraph](https://github.com/castwide/solargraph)
- debugging: [debug](https://github.com/ruby/debug)
- formatter: [rubocop](https://github.com/rubocop/rubocop)
- type checking: [rbs](https://github.com/ruby/rbs), [rbs_rails](https://github.com/pocke/rbs_rails), [steep](https://github.com/soutaro/steep)

## VSCode DevContainer

### Install remote container

※ https://code.visualstudio.com/docs/remote/containers#_installation

### devcontainer の起動

1. Open VSCode, then run `Reopen in Container`

## Operation

### Run Rails server

Run below command in terminal on the DevContainer

```bash
$ bin/rails db:seed
$ bin/rails s
```

### GraphQL Playground

Access to `http://0.0.0.0:3000/graphiql`

### Type Checking

```bash
$ bundle exec rbs collection install

# rbs_rails
$ bin/rake rbs_rails:all

# Steep check
$ bundle exec steep check
```

### Solargraph

```bash
# Generate documentation for bundled gems
$ bundle exec solargraph bundle

# Download Ruby core documentation
$ bundle exec solargraph download-core
```

## Debugging

Run `Run Debug` (Shortcut key: F5)

[VSCode Debugging](https://code.visualstudio.com/docs/editor/debugging)

<img width="900" alt="debugging" src="https://user-images.githubusercontent.com/1701108/189269013-1c9c8e8e-f6df-4cc1-b695-4fc9130d85a2.png">

## VSCode extensions

- [rebornix.Ruby](https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby)
- [castwide.solargraph](https://marketplace.visualstudio.com/items?itemName=castwide.solargraph)
- [KoichiSasada.vscode-rdbg](https://marketplace.visualstudio.com/items?itemName=KoichiSasada.vscode-rdbg)
- [soutaro.steep-vscode](https://github.com/soutaro/steep-vscode)
- [soutaro.rbs-syntax](https://marketplace.visualstudio.com/items?itemName=soutaro.rbs-syntax)
- [redhat.vscode-yaml](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml)
- [VisualStudioExptTeam.vscodeintellicode](https://marketplace.visualstudio.com/items?itemName=VisualStudioExptTeam.vscodeintellicode)
- [esbenp.prettier-vscode](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
- [EditorConfig.EditorConfig](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)
- [GitHub.copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)
- [GitHub.copilot-chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat)

## Architecture

Work on Docker Compose

- app: [ruby:3.1-bullseye](https://hub.docker.com/_/ruby)
- postgres: [postgres:14](https://hub.docker.com/_/postgres)

## References

- [Visual Studio Code Doc - Developing inside a Container](https://code.visualstudio.com/docs/remote/containers)
- [VS Code Solargraph Extension](https://github.com/castwide/vscode-solargraph)
- [VSCode rdbg Ruby Debugger](https://marketplace.visualstudio.com/items?itemName=KoichiSasada.vscode-rdbg)
