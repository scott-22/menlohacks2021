pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

// Unique shipping token
contract Shipment {
    bytes32 public description;
    uint64 public value; // Number of vaccines
    address public owner;
    address public creator; // The original Producer
    bool public active; // Whether the shipment is on the move (becomes false when it reaches final destination)

    constructor (bytes32 _description, uint64 _value, address _owner, address _creator) public {
        description = _description;
        value = _value;
        owner = _owner;
        creator = _creator;
        active = true;
    }

    modifier requireOwner {
        require (msg.sender == owner);
        _;
    }

    function setOwner(address _owner) public requireOwner {
        owner = _owner;
    }

    function deactivate() public requireOwner {
        active = false;
    }
}

contract ShipmentCenter {
    mapping (address => Shipment[]) shipments;
    
    function getShipments() external view returns (Shipment[] memory) {
        return shipments[msg.sender];
    }

    // TODO: Verify address is Producer (0)
    function createShipment(bytes32 _description, uint64 _value) external {
        shipments[msg.sender].push(new Shipment(_description, _value, msg.sender, msg.sender));
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
        require (ship.active());
        require (deleteShipment(ship));
        ship.setOwner(to);
        shipments[to].push(ship);
    }

    //TODO: Verify address is End User (2)
    function completeShipment(address shipment) external {
        Shipment ship = Shipment(shipment);
        ship.deactivate();
        deleteShipment(ship);
    }
}