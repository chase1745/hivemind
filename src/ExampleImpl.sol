// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "src/HivemindHyperlane.sol";
// import "@hyperlane/IInterchainAccountRouter.sol";

contract ExampleImpl is HivemindHyperlane {
    uint256 public a = 0;

    constructor(address _localRouter) HivemindHyperlane(_localRouter) {}

    function exampleInc() public {
        uint256 slot;
        assembly {
            slot := a.slot
        }

        this.incrementUint256(slot, 999);
    }

    function exampleDec() public {
        uint256 slot;
        assembly {
            slot := a.slot
        }

        this.decrementUint256(slot, 999);
    }

    function exampleShareInc() public {
        uint256 slot;
        assembly {
            slot := a.slot
        }

        super.shareIncrementUint256(slot, 1);
    }

    function exampleShareDec() public {
        uint256 slot;
        assembly {
            slot := a.slot
        }

        super.shareDecrementUint256(slot, 1);
    }
}
