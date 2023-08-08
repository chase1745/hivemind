// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "src/Hivemind.sol";

import "@openzeppelin/access/Ownable.sol";
import "@hyperlane/IInterchainAccountRouter.sol";

contract HivemindHyperlane is Ownable, Hivemind {
    mapping(address => bool) private incomingRouters;
    mapping(uint32 => address) private remoteHiveminds;
    address private localRouter;
    uint32[] private enabledOutgoingDomains;

    constructor(address _localRouter) {
        localRouter = _localRouter;
    }

    modifier onlyStateUpdaters() override {
        require(incomingRouters[msg.sender], "Unknown router cannot call");
        _;
    }

    /////////// State Functions

    function shareIncrementUint256(uint256 slot, uint256 amount) internal override {
        for (uint256 i = 0; i < enabledOutgoingDomains.length; i++) {
            uint32 domain = enabledOutgoingDomains[i];
            address remoteHivemind = remoteHiveminds[domain];

            IInterchainAccountRouter(localRouter).dispatch(
                domain, remoteHivemind, abi.encodeCall(this.incrementUint256, (slot, amount))
            );
        }
    }

    function shareDecrementUint256(uint256 slot, uint256 amount) internal override {
        for (uint256 i = 0; i < enabledOutgoingDomains.length; i++) {
            uint32 domain = enabledOutgoingDomains[i];
            address remoteHivemind = remoteHiveminds[domain];

            IInterchainAccountRouter(localRouter).dispatch(
                domain, remoteHivemind, abi.encodeCall(this.decrementUint256, (slot, amount))
            );
        }
    }

    function getInterchainAccount(uint32 destDomain) public view returns (address) {
        return IInterchainAccountRouter(localRouter).getRemoteInterchainAccount(destDomain, address(this));
    }

    /////////// Add/remote incoming/outgoing routers

    function addIncomingRouter(address newRouter) external onlyOwner {
        incomingRouters[newRouter] = true;
    }

    function removeIncomingRouter(address router) external onlyOwner {
        delete incomingRouters[router];
    }

    function addOutgoingRouter(uint32 domain, address remoteHivemind) external onlyOwner {
        remoteHiveminds[domain] = remoteHivemind;
        enabledOutgoingDomains.push(domain);
    }

    function removeOutgoingRouter(uint32 domain) external onlyOwner {
        delete remoteHiveminds[domain];
        for (uint256 i = 0; i < enabledOutgoingDomains.length; i++) {
            if (enabledOutgoingDomains[i] == domain) {
                enabledOutgoingDomains[i] = 0;
            }
        }
    }
}
