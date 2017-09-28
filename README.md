# hello-solidity

A simple repo to track my Solidity development progress.

## Initialize Blockchain

```
geth --datadir=~/Documents/GitHub/KeithSSmith/hello-solidity/blockchain/chaindata/ init ~/Documents/GitHub/KeithSSmith/hello-solidity/blockchain/genesis.json
```

## Start Blockchain

```
geth --datadir=~/Documents/GitHub/KeithSSmith/hello-solidity/blockchain/chaindata/
```

## Mine Blockchain

In new Bash prompt.

```
geth attach
miner.start(1)
miner.stop()
```

# MIST

Ensure MIST is on the private network and the miner is running.  Then it is possible to deploy contracts and interact with them.
