// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "src/HivemindHyperlane.sol";
// import "@hyperlane/IInterchainAccountRouter.sol";

contract ExampleImpl is HivemindHyperlane {
    uint256 public a = 0;

    function exampleUpdate() public {
        uint256 slot;
        assembly {
            slot := a.slot
        }

        this.incrementUint256(slot, 999);
    }
}
