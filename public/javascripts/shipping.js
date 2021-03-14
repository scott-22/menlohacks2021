async function shippingCenter(web3) {
    let abi = await (await fetch('/api/shippingcenter/abi')).json();
    let shippingaddress = (await (await fetch('/api/shippingcenter/address')).json()).address;
    return new web3.eth.Contract(abi, shippingaddress);
}

async function getShipments(shippingContract) {
    let shipments = await shippingContract.methods.getShipments().call({from: address, gas: 600000});
    let shipmentContract = new web3.eth.Contract(await (await fetch('/api/shipment/abi')).json());
    console.log(shipments);
    shipmentArr = []
    for (let shipment of shipments) {
        shipmentObj = {}
        shipmentContract.options.address = shipment;
        shipmentObj.self = shipment;
        shipmentObj.value = await shipmentContract.methods.value().call();
        shipmentObj.owner = await shipmentContract.methods.owner().call();
        shipmentObj.creator = await shipmentContract.methods.creator().call();
        console.log(shipmentObj);
        shipmentArr.push(shipmentObj);
    }
    console.log(shipmentArr)
    return shipmentArr;
}

async function updateTable(shippingContract) {
    getShipments(shippingContract)
        .then(shipments => {
            if (shipments.length > 0) {
                let table = document.getElementById("shipments");
                table.getElementsByTagName("tbody")[0].innerHTML = '';
                for (let shipment of shipments) {
                    let r = table.insertRow();
                    let td = r.insertCell();
                    td.appendChild(document.createTextNode(shipment.description));
                    
                    td = r.insertCell();
                    td.appendChild(document.createTextNode(shipment.value));
        
                    td = r.insertCell();
                    td.style.fontSize = "8px";
                    td.appendChild(document.createTextNode(shipment.self));
                }
            }
        });
}

async function updateUsers() {
    let allusers = await (await fetch('/api/users')).json();
    if (allusers.length > 0) {
        let table = document.getElementById("users");
        table.getElementsByTagName("tbody")[0].innerHTML = '';
        for (let user of allusers) {
            let r = table.insertRow();
            let td = r.insertCell();
            td.appendChild(document.createTextNode(user.username));
            
            td = r.insertCell();
            let s;
            if (user.usertype === 0) s = "Producer";
            else if (user.usertype === 1) s = "Shipping";
            else s = "End User";
            td.appendChild(document.createTextNode(s));

            td = r.insertCell();
            td.style.fontSize = "8px";
            td.appendChild(document.createTextNode(user.id));
        }
    }
}
