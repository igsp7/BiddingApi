# BiddingApi

A sample Phoenix REST API that consists of several endpoints to manage an Auction. <br />
It includes endpoints for creating listings, auctions and placing bids. <br />
A user first creates a listing. Using the listing then an auction can be created. After an auction is created, bids can be placed for the given auction.<br />
Bids can only be placed for auction that are ongoing. Every new bid has to be higher than the current highest bid. If a bid exceeds the buy_now_ammount of the auction then the bid wins and the auction is closed.<br />

The environment consists of:
  * Phoenix REST API
  * PostgreSQL Database
  
To start the application:
  * Use docker-compose: `docker-compose up`


The API endpoints are all included in a Postman collection. Import `BiddingApi.postman_collection.json` to Postman to view the available endpoints.

The following database schema is used in the database:
<img width="802" alt="image" src="https://user-images.githubusercontent.com/37276315/176467567-2967648f-bcde-4f45-9e4f-155ea5708d17.png">
