pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

// Unique shipping token
contract Shipment {
    uint64 public value; // Number of vaccines
    address public owner;
    address public creator; // The original Producer

    constructor (uint64 _value, address _owner, address _creator) public {
        value = _value;
        owner = _owner;
        creator = _creator;
    }

    modifier requireOwner {
        require (msg.sender == owner);
        _;
    }

    function setOwner(address _owner) public requireOwner {
        owner = _owner;
    }
}

contract ShipmentCenter {
    mapping (address => Shipment[]) shipments;
    
    function getShipments() external view returns (Shipment[] memory) {
        return shipments[msg.sender];
    }

    // TODO: Verify address is Producer (0)
    function createShipment(uint64 _value) external {
        Shipment ship = new Shipment(_value, msg.sender, msg.sender);
        shipments[msg.sender].push(ship);
    }

    function deleteShipment(Shipment ship) internal returns (bool) {
        for (uint32 i = 0; i < shipments[msg.sender].length; ++i)
            if (shipments[msg.sender][i] == ship) {
                require (msg.sender == ship.owner());
                shipments[msg.sender][i] = shipments[msg.sender][shipments[msg.sender].length-1];
                shipments[msg.sender].pop();
                return true;
            }
        return false;
    }

    // TODO: Add verification
    function transferShipment(address shipment, address to) external {
        Shipment ship = Shipment(shipment);
        require (deleteShipment(ship));
        ship.setOwner(to);
        shipments[to].push(ship);
    }

    //TODO: Verify address is End User (2)
    function completeShipment(address shipment) external {
        Shipment ship = Shipment(shipment);
        deleteShipment(ship);
    }
}