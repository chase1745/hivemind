// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "src/Hivemind.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract HivemindHyperlane is Ownable, Hivemind {
    mapping(address => bool) private incomingRouters;
    mapping(uint32 => address) private outgoingRouters;

    constructor() {}

    modifier onlyStateUpdaters() override {
        require(incomingRouters[msg.sender], "Unknown router cannot call");
        _;
    }

    function shareState() internal override {}

    /////////// Add/remote incoming/outgoing routers

    function addIncomingRouter(address newRouter) external onlyOwner {
        incomingRouters[newRouter] = true;
    }

    function removeOutgoingRouter(address router) external onlyOwner {
        delete incomingRouters[router];
    }

    function addOutgoingRouter(uint32 domain, address router) external onlyOwner {
        outgoingRouters[newRouter] = true;
    }

    function removeOutgoingRouter(uint32 domain) external onlyOwner {
        delete outgoingRouters[domain];
    }
}
