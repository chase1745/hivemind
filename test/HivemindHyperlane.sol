// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {Test} from "forge-std/Test.sol";

import {HivemindHyperlane} from "../src/HivemindHyperlane.sol";

contract HivemindHyperlaneTest is Test {
    HivemindHyperlane hivemind;

    function setUp() public {
        hivemind = new HivemindHyperlane();
    }

    function testAddIncomingRouterOnlyOwner() public {
        vm.startBroadcast();
        vm.expectRevert(abi.encodePacked("Ownable: caller is not the owner"));
        hivemind.addIncomingRouter(0xc0ffee254729296a45a3885639AC7E10F9d54979);
    }

    function testRemoveIncomingRouterOnlyOwner() public {
        vm.startBroadcast();
        vm.expectRevert(abi.encodePacked("Ownable: caller is not the owner"));
        hivemind.removeOutgoingRouter(0xc0ffee254729296a45a3885639AC7E10F9d54979);
    }

    function testUpdateStateKnownIncomingRouterSucceeds() public {
        hivemind.addIncomingRouter(0xc0ffee254729296a45a3885639AC7E10F9d54979);
        vm.startBroadcast(0xc0ffee254729296a45a3885639AC7E10F9d54979);
        hivemind.updateState("");
    }

    function testUpdateStateUnknownIncomingRouterReverts() public {
        hivemind.removeOutgoingRouter(0xc0ffee254729296a45a3885639AC7E10F9d54979);
        vm.startBroadcast(0xc0ffee254729296a45a3885639AC7E10F9d54979);
        vm.expectRevert(abi.encodePacked("Unknown router cannot call"));
        hivemind.updateState("");
    }
}
