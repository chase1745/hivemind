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
        impl = new ExampleImpl(defaultAddress);
    }

    function testUpdateState() public {
        impl.addIncomingRouter(address(impl));
        impl.exampleInc();
        require(impl.a() == 999, string.concat("y ", Strings.toString(impl.a())));
        impl.exampleDec();
        require(impl.a() == 0, string.concat("z ", Strings.toString(impl.a())));
    }
}
