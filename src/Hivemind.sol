// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

abstract contract Hivemind {
    modifier onlyStateUpdaters() virtual {_;}

    function shareState() internal virtual;

    function updateState(string memory newState) external onlyStateUpdaters {
        assembly ("memory-safe") {}
    }
}