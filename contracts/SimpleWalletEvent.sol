pragma solidity ^0.4.13;

contract owned {
    address owner;

    modifier onlyowner() {
        if (msg.sender == owner) {
            _;
        }
    }

    function owned() {
        owner = msg.sender;
    }
}

contract mortal is owned {
    function kill() {
        if (msg.sender == owner)
            selfdestruct(owner);
    }
}

contract SimpleWalletEvents is mortal {

    mapping(address => Permission) permittedAddresses;

    event someoneAddedToTheSendersList(address thePersonWhoAdded, address thePersonWhoIsAllowedNow, uint maxAmountAllowed);
    event someoneRemovedFromTheSendersList(address thePersonWhoRemoved, address thePersonWhoWasRemoved);
    event someoneSentFunds(address thePersonSent, address thePersonReceived, uint amountSent);

    struct Permission {
        bool isAllowed;
        uint maxTransferAmount;
    }

    function addAddressToSendersList(address permitted, uint maxTransferAmount) onlyowner {
        permittedAddresses[permitted] = Permission(true, maxTransferAmount);
        someoneAddedToTheSendersList(msg.sender, permitted, maxTransferAmount);
    }

    function sendFunds(address receiver, uint amountInWei) {
        if(permittedAddresses[msg.sender].isAllowed) {
            if(permittedAddresses[msg.sender].maxTransferAmount >= amountInWei) {
                bool isTheAmountReallySent = receiver.send(amountInWei);
                someoneSentFunds(msg.sender, receiver, amountInWei);
                if(!isTheAmountReallySent) {
                    revert();
                }
            } else {
                revert();
            }
        } else {
            revert();
        }
    }

    function removeAddressFromSendersList(address theAddress) {
        delete permittedAddresses[theAddress];
        someoneRemovedFromTheSendersList(msg.sender, theAddress);
    }


    function () payable {
    }

}
