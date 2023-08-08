// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "@hyperlane/IInterchainAccountRouter.sol";
import "@openzeppelin/utils/Strings.sol";

import {ExampleImpl} from "../src/ExampleImpl.sol";

contract ExampleImplTest is Test {
    ExampleImpl impl;
    address defaultAddress = 0xc0ffee254729296a45a3885639AC7E10F9d54979;

    function setUp() public {
        impl = new ExampleImpl();
    }

    function testUpdateState() public {
        impl.addIncomingRouter(defaultAddress);
        vm.broadcast(defaultAddress);
        impl.exampleUpdate();
        require(impl.a() == 999, string.concat("y ", Strings.toString(impl.a())));
    }
}
