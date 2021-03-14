pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

// Unique shipping token
contract Shipment {
    uint public id;
    bytes32 public description;
    uint64 public value; // Number of vaccines
    address public owner;
    address public creator; // The original Producer
    bool public active; // Whether the shipment is on the move (becomes false when it reaches final destination)

    constructor (uint _id, bytes32 _description, uint64 _value, address _owner, address _creator) public {
        id = _id;
        description = _description;
        value = _value;
        owner = _owner;
        creator = _creator;
    }
}

contract ShipmentCenter {
    mapping (address => Shipment[]) shipments;
    uint totalSupply;
    
    function getShipments() external view returns (Shipment[] memory) {
        return shipments[msg.sender];
    }

    // TODO: Verify address is Producer (0)
    function createShipment(bytes32 _description, uint64 _value) external {
        // totalSupply used as ID
        shipments[msg.sender].push(new Shipment(totalSupply, _description, _value, msg.sender, msg.sender));
        ++totalSupply;
    }

    function deleteShipment(address shipment) internal returns (bool) {
        for (uint32 i = 0; i < shipments[msg.sender].length; ++i)
            if (address(shipments[msg.sender][i]) == shipment) {
                shipments[msg.sender][i] = shipments[msg.sender][shipments[msg.sender].length-1];
                shipments[msg.sender].pop();
                return true;
            }
        return false;
    }

    // TODO: Add verification
    function transferShipment(address shipment, address to) external {
        require (deleteShipment(shipment));
        shipments[to].push(Shipment(shipment));
    }

    //TODO: Verify address is End User (2)
    function completeShipment(address shipment) external {
        deleteShipment(shipment);
    }
}