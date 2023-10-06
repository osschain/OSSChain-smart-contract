/*
Project Name: OSSchain
Token Name: OSS Token
Blockchain: Polygon
Max Supply: 200,000,000 OSS
Sector: Technology & Software
Core Services: 
    - myGO: Custom Software Development
    - SERVER1: Web Hosting
    - Wik.Ge: Website Builder
    - mySEO.dev: SEO Analysis
    - Linkers.dev: URL Shortener
    - AI Automation and many more.

Objective:
To create a unified and seamless digital ecosystem that integrates various technology services, facilitated by the OSS Token.

Osschain is a multi-faceted technology enterprise encompassing specialized ventures. The ecosystem is powered by the OSS Token, enabling streamlined transactions and added utility across platforms.
*/


// SPDX-License-Identifier: No License
pragma solidity 0.8.19;

import "./ERC20.sol";
import "./ERC20Burnable.sol";
import "./Ownable.sol";
import "./Mintable.sol";
import "./Initializable.sol";
import "./IUniswapV2Factory.sol";
import "./IUniswapV2Pair.sol";
import "./IUniswapV2Router01.sol";
import "./IUniswapV2Router02.sol";

contract OSSChain is ERC20, ERC20Burnable, Ownable, Mintable, Initializable {
    
    IUniswapV2Router02 public routerV2;
    address public pairV2;
    mapping (address => bool) public AMMPairs;
 
    event RouterV2Updated(address indexed routerV2);
    event AMMPairsUpdated(address indexed AMMPair, bool isPair);
 
    constructor()
        ERC20(unicode"OSSChain", unicode"OSS") 
        Mintable(2000000000)
    {
        address supplyRecipient = 0x100685D90B915DdFBB02e0F310BE5c524ce5D1BC;
        
        _mint(supplyRecipient, 1000000000 * (10 ** decimals()) / 10);
        _transferOwnership(0x100685D90B915DdFBB02e0F310BE5c524ce5D1BC);
    }
    
    function initialize(address _router) initializer external {
        _updateRouterV2(_router);
    }

    receive() external payable {}

    function decimals() public pure override returns (uint8) {
        return 18;
    }
    
    function _updateRouterV2(address router) private {
        routerV2 = IUniswapV2Router02(router);
        pairV2 = IUniswapV2Factory(routerV2.factory()).createPair(address(this), routerV2.WETH());
        
        _setAMMPair(pairV2, true);

        emit RouterV2Updated(router);
    }

    function setAMMPair(address pair, bool isPair) external onlyOwner {
        require(pair != pairV2, "DefaultRouter: Cannot remove initial pair from list");

        _setAMMPair(pair, isPair);
    }

    function _setAMMPair(address pair, bool isPair) private {
        AMMPairs[pair] = isPair;

        if (isPair) { 
        }

        emit AMMPairsUpdated(pair, isPair);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    function _afterTokenTransfer(address from, address to, uint256 amount)
        internal
        override
    {
        if (from == address(0)) {
        }

        super._afterTokenTransfer(from, to, amount);
    }
}
