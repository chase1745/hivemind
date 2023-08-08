// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

abstract contract Hivemind {
    modifier onlyStateUpdaters() virtual {
        _;
    }

    function shareIncrementUint256(uint256 slot, uint256 amount) public virtual;

    // TODO -- will this work? probably not but maybe
    // function updateState(uint256 slot, bytes memory newState) external {
    //     //onlyStateUpdaters {
    //     uint256 newStateDecoded = abi.decode(newState, (uint256));
    //     assembly ("memory-safe") {
    //         sstore(slot, newStateDecoded)
    //     }
    // }

    function incrementUint256(uint256 slot, uint256 amount) external {
        //onlyStateUpdaters {
        assembly ("memory-safe") {
            let newValue := add(sload(slot), amount)
            sstore(slot, newValue)
        }
    }
}
