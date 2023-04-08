pragma solidity ^0.8.17;

// SPDX-License-Identifier: MIT

import "forge-std/Test.sol";
import "../src/game.sol";

contract gameTest is Test {
    Game public game;
    exampleSolver public solver;
    address player;
    uint duration = 1 days;

    function setUp() public {
        player = vm.addr(1);
        game = new Game{value : 1e18}(duration);
        deal(player,10e18);
        vm.prank(player, player);
        solver = new exampleSolver();
    }

    function testPlay() public {
        vm.startPrank(player, player);
        game.play{value: 1e18, gas: 2e7}(solver);
        vm.warp(block.timestamp + duration);
        game.withdraw();
        vm.stopPrank();
    }

}