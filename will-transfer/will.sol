//SPDX-License-Identifier:mit
pragma solidity ^0.8.0;

contract will {

    address owner;
    uint fortune;
    bool deceased;

  constructor()  payable {
     
    owner = msg.sender;
    fortune = msg.value;
    deceased = false;

  }

  modifier mustDeceased {

      require( deceased == true);
      _;

  }

   modifier OnlyOwner {

      require (msg.sender == owner);
      _;

    }


    address payable  [] familyWallets; // this array will store the addresses of all the people who are eligible to get the moeny from the owner.

    mapping (address => uint)  Inheritance; 

    // since we have created the mapping to actually point to a specific address now we have to create function to set inheritance to each adress 

    
    function setInheritance ( address payable wallet, uint amount ) public OnlyOwner {

    familyWallets.push(  wallet );
    Inheritance[wallet] = amount;

    } 

    // the below function will payout the selected amount to the beneficiaries.

    function payOut ( ) private mustDeceased {

    for ( uint i; i < familyWallets.length; i++ ) {

        familyWallets[i].transfer(Inheritance[familyWallets[i]]);

      }
    }

    // oracle switch simulation

    function isDeciesed () public payable OnlyOwner {

        deceased = true;

        payOut();

    }

  }
