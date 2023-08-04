# Hivemind

Hackathon project for [Superhack 2023](https://ethglobal.com/events/superhack) by ETHGlobal.

Hivemind is a Solidity smart contract that enables a shared-state for contracts between
OP, Base, and Zora, powered by cross-chain messaging with Hyperlane or LayerZero.

Uses [foundry-template](https://github.com/transmissions11/foundry-template) as a project template.

## Setup

You will need a copy of Foundry installed before proceeding. See the
[installation guide](https://github.com/foundry-rs/foundry#installation) for details.

```sh
git clone https://github.com/transmissions11/foundry-template.git
cd foundry-template
forge install
```

### Run Tests

```sh
forge test
```

### Update Gas Snapshots

```sh
forge snapshot
```
