async function initweb3() {
    if (window.ethereum) {
        try {
            await window.ethereum.request({
                method: "eth_requestAccounts"
            });
            return new Web3(window.ethereum);
        }
        catch(err) {
            console.log(err);
            alert("Denied");
        }
    }
    else if (window.web3) {
        return new Web3(window.web3.currentProvider);
    }
    else {
        return new Web3(new Web3.providers.HttpProvider('http://localhost:7545'));
    }
}