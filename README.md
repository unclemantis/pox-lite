![Node.js CI](https://github.com/unclemantis/pox-lite/workflows/Node.js%20CI/badge.svg)

# PoX Lite

A PoX Lite Smart Contract in Clarity which simulates PoX.

## Running the code

```bash
npm i --force
 
npm test
```

## Challenge

**Challenge Type:** Solo/Team

**Expiration Date:** April 31, 2021

**Goal:** Create a PoX Lite Smart Contract

### Write a Smart Contract that has:

1. A fungible token
2. Can only be minted when other people send to the contract their Stacks (STX) tokens.

The way in which this happens is every Stacks block a fixed amount of the token would be minted, and the person who can receive that block's tokens must have sent STX to the contract and must be chosen at random based on how much they spent relative to everyone else in the same block.

For example, if Alice sends 3 STX, and Bob sends 2 STX to the contract, Alice has a 60% chance of winning that block's tokens and Bob has a 40% of winning that block's tokens.

3. In addition to sending the STX a person can write a short message (say 80 bytes of data) that is paired with their commitment. The act of putting your STX in is the act of writing a message, which must be stored in a data-map ordered by block height and submission order.

*Hint 1: The tokens don't need to be minted right away, they only need to be minted when Alice (if she is the winner) goes to withdrawal them.*

*Hint 2: There is at most one winner per block, and only that person may withdrawal.*

**Bonus:** Stacks are forwarded into a treasury that token holders have a right to withdraw from, but would have 401k-style early withdrawal penalty for withdrawing early, and subsequently leaving a larger pot for the remaining holders.
