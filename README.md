#Gentleman's Bet

##Description
Have you ever had a friendly wager go in your favor and then find that your opponent denies ever agreeing to the wager?  Well, Gentleman's Bet is here to help!  Now, when you enter into a wager, use Gentleman's bet to tell all your friends.  Just log on with your Twitter credentials and setup your bet.  Now, Gentleman's bet will monitor the terms and let all your friends know what's at stake and who has bragging rights at the end.


##Environment

Ruby version 2.0.0
Rails version 4.0.0


##Configuration

###Oauth:
token and secret for twitter must be added to the .env.development (or .env.local) file in the root directory.  Format is:
TWITTER_KEY={twitter app key}
TWITTER_SECRET={twitter app secret}

Note: both keys should be added without curly brackets.  No quotes are necessary around the keys.

###Whenever Scheduling:
Update the schedule in schedule.rb located in the config folder.  This will tell the app how often to send reminders to users participating in bets.

###Bitly


##Database Creation
Run rake db:create and db:migrate to setup database

Note: no seeding is needed

##Running Locally
start rails server (rails s)
Browse to localhost:3000

##Deployment Instructions
