// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Fish.sol";
import {ERC721Holder} from "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";

contract QAFishScript is Script, ERC721Holder {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        Fish token = new Fish();
        token.mint{value: token.price()}();
        token.mint{value: token.price()}();
        token.mint{value: token.price()}();

        console.log(token.tokenURI(3));

        vm.stopBroadcast();
    }
}
