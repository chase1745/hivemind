// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "src/Hivemind.sol";

import "@openzeppelin/access/Ownable.sol";
import "@hyperlane/IInterchainAccountRouter.sol";

contract HivemindHyperlane is Ownable, Hivemind {
    mapping(address => bool) public incomingRouters;
    mapping(uint32 => address) private outgoingRouters;
    mapping(uint32 => address) private remoteHiveminds;
    uint32[] private enabledOutgoingDomains;

    constructor() {}

    modifier onlyStateUpdaters() override {
        require(incomingRouters[msg.sender], "Unknown router cannot call");
        _;
    }

    /////////// State Functions

    function shareIncrementUint256(uint256 slot, uint256 amount) public override {
        for (uint256 i = 0; i < enabledOutgoingDomains.length; i++) {
            uint32 domain = enabledOutgoingDomains[i];
            address routerAddress = outgoingRouters[domain];
            address remoteHivemind = remoteHiveminds[domain];

            IInterchainAccountRouter(routerAddress).dispatch(
                domain, remoteHivemind, abi.encodeCall(this.incrementUint256, (slot, amount))
            );
        }
    }

    /////////// Add/remote incoming/outgoing routers

    function addIncomingRouter(address newRouter) external onlyOwner {
        incomingRouters[newRouter] = true;
    }

    function removeIncomingRouter(address router) external onlyOwner {
        delete incomingRouters[router];
    }

    function addOutgoingRouter(uint32 domain, address router, address remoteHivemind) external onlyOwner {
        outgoingRouters[domain] = router;
        remoteHiveminds[domain] = remoteHivemind;
        enabledOutgoingDomains.push(domain);
    }

    function removeOutgoingRouter(uint32 domain) external onlyOwner {
        delete outgoingRouters[domain];
        delete remoteHiveminds[domain];
        for (uint256 i = 0; i < enabledOutgoingDomains.length; i++) {
            if (enabledOutgoingDomains[i] == domain) {
                enabledOutgoingDomains[i] = 0;
            }
        }
    }
}
