// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC4883Composer} from "./ERC4883Composer.sol";
import {IERC4883} from "./IERC4883.sol";
import {ERC4883} from "./ERC4883.sol";
import {Colours} from "./Colours.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {IERC165} from "@openzeppelin/contracts/interfaces/IERC165.sol";
import {IERC721Metadata} from "@openzeppelin/contracts/interfaces/IERC721Metadata.sol";
import {ERC721Holder} from "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";

contract Fish is ERC4883Composer, Colours, ERC721Holder {
    /// ERRORS

    /// EVENTS

    constructor() ERC4883Composer("Fish", "FSH", 0.00042 ether, 99, 4883) {}

    function colourId(uint256 tokenId) public view returns (uint8) {
        if (!_exists(tokenId)) {
            revert NonexistentToken();
        }

        return _generateColourId(tokenId);
    }

    function _generateDescription(uint256 tokenId) internal view virtual override returns (string memory) {
        return string.concat("Fish.  Fish #", Strings.toString(tokenId), ".  ERC4883 composable NFT.  Fish emoji designed by OpenMoji (the open-source emoji and icon project). License: CC BY-SA 4.0");
    }

    function _generateAttributes(uint256 tokenId) internal view virtual override returns (string memory) {
        string memory attributes = string.concat(
            '{"trait_type": "Colour", "value": "',
            _generateColour(tokenId),
            '"}',
            _generateAccessoryAttributes(tokenId),
            _generateBackgroundAttributes(tokenId)
        );

        return string.concat('"attributes": [', attributes, "]");
    }

    function _generateSVG(uint256 tokenId) internal view virtual override returns (string memory) {
        string memory svg = string.concat(
            '<svg id="fish" width="500" height="500" viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg">',
            _generateBackground(tokenId),
            _generateSVGBody(tokenId),
            _generateAccessories(tokenId),
            "</svg>"
        );

        return svg;
    }

    function _generateSVGBody(uint256 tokenId) internal view virtual override returns (string memory) {
        string memory colourValue = _generateColour(tokenId);

        return string.concat(
            '<g id="fish-',
            Strings.toString(tokenId),
            '">' "<desc>Fish emoji designed by OpenMoji. License: CC BY-SA 4.0</desc>"
    '<path fill="',
            colourValue,
            '" stroke="none" d="M48.611 166.667c0 31.271 10.333 60.132 27.778 83.347l-0.042 0.021C58.931 273.243 48.611 302.083 48.611 333.333c39.903 -6.667 71.507 -31.917 80.653 -64.188l0.049 -0.042C146.215 305.924 210.938 333.333 288.194 333.333C378.326 333.333 451.389 296.021 451.389 250S378.326 166.667 288.194 166.667c-77.271 0 -142 27.424 -158.896 64.25l0.063 0.028C120.465 198.917 89.458 173.736 50.132 166.667" stroke-width="6.944444444444445"/>'
    '<path fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="13.88888888888889" d="M48.611 166.667c0 31.271 10.333 60.132 27.778 83.347l-0.042 0.021C58.931 273.243 48.611 302.083 48.611 333.333c39.903 -6.667 71.507 -31.917 80.653 -64.188l0.049 -0.042C146.215 305.924 210.938 333.333 288.194 333.333C378.326 333.333 451.389 296.021 451.389 250S378.326 166.667 288.194 166.667c-77.271 0 -142 27.424 -158.896 64.25l0.063 0.028C120.465 198.917 89.458 173.736 50.132 166.667"/>'
    '<path cx="53" cy="34" r="2" fill="#000000" stroke="none" d="M381.944 236.111A13.889 13.889 0 0 1 368.056 250A13.889 13.889 0 0 1 354.167 236.111A13.889 13.889 0 0 1 381.944 236.111z" stroke-width="6.944444444444445"/>'
                    "</g>"
        );
    }

    function _generateColourId(uint256 tokenId) internal view returns (uint8) {
        uint256 id = uint256(keccak256(abi.encodePacked("Colour", address(this), Strings.toString(tokenId))));
        return uint8(id % colours.length);
    }

    function _generateColour(uint256 tokenId) internal view returns (string memory) {
        return colours[_generateColourId(tokenId)];
    }

    function _generateTokenName(uint256 tokenId) internal view virtual override returns (string memory) {
        return string.concat(_generateColour(tokenId), " Fish");
    }
}

//  ______
// < Fish >
//  ------
//         \   ^__^
//          \  (oo)\_______
//             (__)\       )\/\
//                 ||----w |
