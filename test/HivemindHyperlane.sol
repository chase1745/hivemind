// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {Test} from "forge-std/Test.sol";
import "@hyperlane/IInterchainAccountRouter.sol";

import {HivemindHyperlane} from "../src/HivemindHyperlane.sol";

contract HivemindHyperlaneTest is Test {
    HivemindHyperlane hivemind;
    address defaultAddress = 0xc0ffee254729296a45a3885639AC7E10F9d54979;

    function setUp() public {
        hivemind = new HivemindHyperlane();
    }

    //////// OnlyOwner tests

    function testAddIncomingRouterOnlyOwner() public {
        vm.startBroadcast();
        vm.expectRevert(abi.encodePacked("Ownable: caller is not the owner"));
        hivemind.addIncomingRouter(defaultAddress);
    }

    function testRemoveIncomingRouterOnlyOwner() public {
        vm.startBroadcast();
        vm.expectRevert(abi.encodePacked("Ownable: caller is not the owner"));
        hivemind.removeIncomingRouter(defaultAddress);
    }

    function testAddOutgoingRouterOnlyOwner() public {
        vm.startBroadcast();
        vm.expectRevert(abi.encodePacked("Ownable: caller is not the owner"));
        hivemind.addOutgoingRouter(0, defaultAddress, defaultAddress);
    }

    function testRemoveOutgoingRouterOnlyOwner() public {
        vm.startBroadcast();
        vm.expectRevert(abi.encodePacked("Ownable: caller is not the owner"));
        hivemind.removeOutgoingRouter(0);
    }

    //////// incrementUint256 tests

    function testIncrementUint256KnownIncomingRouterSucceeds() public {
        hivemind.addIncomingRouter(defaultAddress);
        vm.startBroadcast(defaultAddress);
        hivemind.incrementUint256(0, 1);
    }

    // function testIncrementUint256UnknownIncomingRouterReverts() public {
    //     hivemind.removeIncomingRouter(defaultAddress);
    //     vm.startBroadcast(defaultAddress);
    //     vm.expectRevert(abi.encodePacked("Unknown router cannot call"));
    //     hivemind.incrementUint256(0, abi.encode(""));
    // }

    //////// shareState tests

    // TODO: fix and finish this test
    // function testShareStateCallsExpectedRouter() public {
    //     hivemind.addOutgoingRouter(0, defaultAddress, defaultAddress);

    //     // vm.mockCall(
    //     //     defaultAddress,
    //     //     abi.encodeWithSelector(
    //     //         IInterchainAccountRouter.dispatch.selector, 0, defaultAddress, abi.encode(hivemind.incrementUint256, (""))
    //     //     ),
    //     //     abi.encode()
    //     // );
    //     // vm.expectCall(
    //     //     defaultAddress,
    //     //     abi.encodeCall(
    //     //         IInterchainAccountRouter.dispatch, (0, defaultAddress, abi.encode(hivemind.incrementUint256, ("")))
    //     //     )
    //     // );
    //     // abi.encodeWithSelector(
    //     //     IInterchainAccountRouter.dispatch.selector,
    //     //     0,
    //     //     defaultAddress,
    //     //     abi.encode(hivemind.incrementUint256, (""))
    //     // )

    //     hivemind.shareState();
    // }
}
