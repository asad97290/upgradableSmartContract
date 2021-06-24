// scripts/upgrade_box.js
const { ethers, upgrades } = require("hardhat");

async function main() {
  const BoxV2 = await ethers.getContractFactory("BoxV2");
  console.log("Upgrading Box...");
  const box = await upgrades.upgradeProxy("0x20dD68FAb90D1BEd7bA4Ca6Ec3e6C711B207eEbC", BoxV2);
  console.log("Box upgraded");
}

main();