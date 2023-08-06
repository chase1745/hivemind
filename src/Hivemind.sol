// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

abstract contract Hivemind {
    modifier onlyStateUpdaters() virtual {_;}

    function shareState() public virtual;

    // TODO -- will this work? probably not but maybe
    function updateState(uint slot, bytes memory newState) external onlyStateUpdaters {
        assembly ("memory-safe") {
          sstore(slot, newState)
        }
    }
}