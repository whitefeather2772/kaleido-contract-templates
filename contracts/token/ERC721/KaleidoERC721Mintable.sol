pragma solidity ^0.6.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract DraconianERC721Mintable is ERC721, AccessControl {
    bytes32 public constant MINTER_ROLE = ("MINTER_ROLE");

    constructor(string memory name, string memory symbol) ERC721(name, symbol) public {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _setupRole(MINTER_ROLE, _msgSender());
    }

    function mint(address to, uint256 tokenId) public {
        require(hasRole(MINTER_ROLE, _msgSender()), "DraconianERC721Mintable: must have minter role to mint");
        _mint(to, tokenId);
    }

    function mintWithTokenURI(address to, uint256 tokenId, string memory tokenURI) public {
        mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
    }
}
