// Taken from deployed contract on ETH -
// https://etherscan.io/address/0xe0f6eDeb3de10447C1D1CfB787e14e8F2F3a21Fb#code
pragma solidity >=0.6.11;

struct Call {
    address to;
    bytes data;
}

interface IInterchainAccountRouter {
    // function dispatch(uint32 _destinationDomain, Call[] calldata calls)
    //     external
    //     returns (bytes32);

    function dispatch(uint32 _destinationDomain, address target, bytes calldata data) external returns (bytes32);

    function getRemoteInterchainAccount(uint32 _originDomain, address _sender) external view returns (address);
}
