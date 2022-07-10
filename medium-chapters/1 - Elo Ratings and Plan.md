# Chapter 1

## Elo Ratings
The Elo rating system is used in various competitions, most prominently in chess. When two players play each other, the difference in their ratings can be used to determine the relative probability of each player winning. The ratings are calibrated along a logistic curve, such that even ratings imply an even match, a difference of 100 points implies a 64% chance of winning, and a difference of 200 implies a 74% chance of winning:

| Player A Rating      | Player B Rating | Player A Win Probability| Player B Win Probability
| ----------- | ----------- | ----------- |  ----------- | 
| 500      | 500       | 50%       |  50%       |
| 600   | 500        | 64%       | 36%       |
| 600   | 400        | 75%       | 25%       |

The logistic function that produces these probabilities has a few fixed constants that will be tuned via simulation later in this project.

Jeff Sackmann created an Elo rating system for professional tennis players. Check out his work here! https://tennisabstract.com/reports/atp_elo_ratings.html

## Project Framework
The project will be hosted on the following AWS infrastructure:
- React hosted on S3
- DynamoDB
- API Gateway
- AWS Lambda

Terraform will be used to manage this infrastructure and Github Actions likely used for deployments.