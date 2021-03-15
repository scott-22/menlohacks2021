# VacTrac
*Third Place*  
Submission to MLH's MenloHacks 2021

## Inspiration
The most pressing global issue currently is the Covid-19 pandemic. As vaccines have been developed, challenges still remain in the distribution process so that we may get vaccinated and resume our normal lives. Inspired by the rise of blockchain and cryptocurrencies, we created a web app that deals with vaccine transactions from production to shipping, and finally distribution to the public.

## What it does
The web app tracks vaccine shipments as they travel along its route, and is able to provide information on all shipments at all times, so we can always track when the next shipment is due. Furthermore, due to the autonomous nature of Blockchain, no single organization is able to manipulate vaccine data for political or economic gain.

Institutions can register as one of three types: "Producer" (vaccine manufacturers), "Shipping" (transporters), and "End User" (hospitals, etc). Producers are the only group that can create a new shipment of vaccines, and End Users are the only group that can complete a shipment (use it). Shippers can do neither, as they must receive a shipment and pass it along.

## How we built it
The app is semi-decentralized, storing information both in MongoDB and on the Ethereum Blockchain through its Smart Contracts. Each shipment of vaccines is tracked with a unique and verifiable token. One contract (the "Shipment Center") serves as the point of interaction between the user and the tokens. When one institution hands off a shipment to another, ownership of this token is transferred.

**Backend**: node.js, express.js, Solidity, Truffle, MongoDB

**Frontend**: Pug, HTML/CSS, JS

## Challenges and Accomplishments
This was our first time working with the Ethereum tech stack (and Blockchain in general!), so navigating the languages required (especially Solidity for Smart Contracts) was very frustrating.

## What we learned
We've learned about how Blockchain has the potential to benefit the world, and how we can implement it ourselves! We also brushed up on our programming skills.

## What's next for VacTrac
In the future, we'd like to implement some of the features we weren't able to finish due to time constraints, like linking up the tokens to their descriptions (right now all shipments just say "undefined"). We'd also like to try to scale it up onto a testnet!
