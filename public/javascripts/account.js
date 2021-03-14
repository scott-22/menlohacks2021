async function requireaccount(address, reverse) {
    let response = await fetch(`/api/getuser?address=${address}`);
    if (!reverse) {
        if (response.status != 200) window.location.replace("/users/signup");
        else {
            response = await response.json();
            console.log(response);
            return response
        }
    }
    else if (response.status == 200) window.location.replace("/users");
}