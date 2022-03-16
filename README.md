# SUMMARY
This project is a final exercise from Logistics Analytics class. 

The problemis to predict the number of packages a logistics company will need to deliver each day, based on historical data. 
Then calculate how many aircrafts (between 2 types of different capacities) that needed to be allocated at each airport before each day. This will result in optimizing the net of fuel costs for the company.

## DETAILS
The goal is to maximize revenues net of fuel costs for your company during the final week of class. 
Each day, your customers drop off thousands of packages at each of your facilities in the 30 largest airports across the U.S. 
Currently, your company offers two levels of delivery service: Standard and Express. Your per package revenue is $10.50 for each Standard package successfully delivered and $24.50 for each Express package successfully delivered. No revenues are earned for packages that fail to get delivered on time.
The net profits for each day will be tabulated and displayed on the leaderboard available in the Rshiny interface.
In order to make on time deliveries, each aircraft must be allocated on the day before so they are fueled and ready to be sent out. The way the process currently works is that a flight planner manually decides the number of aircraft to allocate at each airport based on experience and gut intuition. You, however, have access to a dataset that will enable you to make more informed decisions.
Your company owns Boeing 747s and Airbus 300s. The specifications for each aircraft are listed below. Notice that Express packages must be carried on the faster B747s in order to arrive on time, therefore Express packages cannot be successfully delivered on A300s.
Note that the loaders will load all Express packages onto B747s first, then fill any remaining space on B747s with Standard packages. Then, A300s are loaded with remaining Standard packages. All aircraft allocated will be fueled and thus incur fuel costs regardless of whether they are fully loaded.
