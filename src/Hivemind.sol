// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

abstract contract Hivemind {
    modifier onlyStateUpdaters() virtual {
        _;
    }

    function shareIncrementUint256(uint256 slot, uint256 amount) internal virtual;

    function shareDecrementUint256(uint256 slot, uint256 amount) internal virtual;

    function incrementUint256(uint256 slot, uint256 amount) external onlyStateUpdaters {
        assembly ("memory-safe") {
            let newValue := add(sload(slot), amount)
            sstore(slot, newValue)
        }
    }

    function decrementUint256(uint256 slot, uint256 amount) external onlyStateUpdaters {
        assembly ("memory-safe") {
            let newValue := sub(sload(slot), amount)
            sstore(slot, newValue)
        }
    }

}
