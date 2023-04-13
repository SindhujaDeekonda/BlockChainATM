// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/IERC20.sol";
contract TokenSwap{
    IERC20 public token1;
    address public owner1;
    IERC20 public token2;
    address public owner2;

    constructor(
        address _token1,
        address _owner1,
        address _token2,
        address _owner2
    )  {
        token1=IERC20(_token1);
        owner1=_owner1;
        token2=IERC20(_token2);
        owner2=_owner2;
    }
    function swap(uint amount1,uint amount2) public {
        require(msg.sender==owner1 || msg.sender==owner2,"Not authorized");
        require(
            token1.allowance(owner1,address(this)) >= amount1,
            "Token 1 allowance too low"
        );
        require(
            token2.allowance(owner2,address(this)) >= amount2,
            "Token 2 allowance too low"
        );

        //transfer tokens
        //token1 , owner1,amount1 ->owner2
        safeTransferFrom(token1,owner1,owner2,amount1);
        //token2 , owner2,amount2 ->owner1
        safeTransferFrom(token2,owner2,owner1,amount2);  
    }
    function safeTransferFrom(
        IERC20 token,
        address sender,
        address recipient,
        uint amount
    ) private{
        bool sent = token.transferFrom(sender,recipient,amount);
        require(sent,"Token Transfer Failed");
    }
}

// token1 = 0x721e75745F8DF10c0F06a08d6776840E23Ede79A
// owner1 = 0x6fCCe8D60d3C3A58178E69e0caDa110bEE9f6363
// token2 = 0x7c008C13Fd8E8e1E270F191feC68E1eD1E7a781D
// owner2 = 0xB6C046343dF17e4B0296c59440abc9Fcb511c2fA
// tokenswap =  0xB3e6df414D46d84bC22011f12Be84Cb5Ad6374b5
// amount1 = 10000000000000000000
// amount2 = 20000000000000000000