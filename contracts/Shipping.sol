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

    function setOwner(address from, address to) public {
        require (owner == from);
        owner = to;
    }
}

contract ShipmentCenter {
    mapping (address => address[]) shipments;
    
    function getShipments() public view returns (address[] memory) {
        return shipments[msg.sender];
    }

    function get(address x) public view returns (address[] memory) {
        return shipments[x];
    }

    // TODO: Verify address is Producer (0)
    function createShipment(uint64 _value) public {
        Shipment ship = new Shipment(_value, msg.sender, msg.sender);
        shipments[msg.sender].push(address(ship));
    }

    function deleteShipment(Shipment ship) internal returns (bool) {
        for (uint32 i = 0; i < shipments[msg.sender].length; ++i)
            if (shipments[msg.sender][i] == address(ship)) {
                require (msg.sender == ship.owner());
                shipments[msg.sender][i] = shipments[msg.sender][shipments[msg.sender].length-1];
                shipments[msg.sender].pop();
                return true;
            }
        return false;
    }

    // TODO: Add verification
    function transferShipment(address shipment, address to) public {
        Shipment ship = Shipment(shipment);
        require (deleteShipment(ship));
        ship.setOwner(msg.sender, to);
        shipments[to].push(shipment);
    }

    //TODO: Verify address is End User (2)
    function completeShipment(address shipment) public {
        Shipment ship = Shipment(shipment);
        deleteShipment(ship);
    }
}