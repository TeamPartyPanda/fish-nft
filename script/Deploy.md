## Deploy

1. Deploy Fish
source .env
forge script script/Fish.s.sol:FishScript --rpc-url $GOERLI_RPC_URL --etherscan-api-key $ETHERSCAN_KEY --broadcast --verify -vvvv
forge script script/Fish.s.sol:FishScript --rpc-url $OPTIMISM_RPC_URL --etherscan-api-key $OPTIMISTIC_ETHERSCAN_KEY --broadcast --verify -vvvv

