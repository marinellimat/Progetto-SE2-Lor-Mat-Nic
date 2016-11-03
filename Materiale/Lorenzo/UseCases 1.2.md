####Register:
Participating Actors:
* User
* Validation System

Entry Condition:
* A user notifies he wants to register to the system

Flow of Events:
* A User selects Registration.
* The system asks him to insert payment informations and credentials.
* The User inserts required data
* The system checks validity of the data through the given Validation System
* The system generates an account for the User, associates given informations to the account, generates a password  and gives it back to the User.

Exit Condition:
* This use case terminates when registration is successfully completed and the generated password is given back to the User.

Exceptions:
* If the payment information or the credentials are not validated the registration can’t proceed, the User is notified the informations he provided aren’t valid and is asked to provide them again.

Special Requirements:
* Once the User has given his informations the System must reply within XX hours/minutes
* Privacy

####Login:
Participating Actors
* User

Entry Condition
* User selects the Login functionality

Flow of Events
* The System requests the User to input his login informations. 
* User inputs his login informations.
* The System then executes a check and if the given informations are valid then the
* User is authenticated.

Exit Conditions
* User is authenticated

Exceptions
* If the data provided by the user are not valid he is asked to input them again.

Special Requirements
* Security

####Reserve Car:
Participating Actors:
* User
* Car
* Payment Manager

Entry Condition:
* A Registered User selects the option to Reserve a Car.

Flow of Events:
* The system checks the user doesn’t have pending payments
* The system asks the user to select an address or to provide his gps location and to select a distance range.
* The user inputs the required data.
* The system computes the list of all the available cars within the range from the given location and shows it to the user.
* The user is shown for each car the distance from the user given location, the level of battery and whether or not it is charging.
* The user selects a car
* The selected car is marked as reserved and a 1 hour timer is set.
* The system then awaits for the user to select the unlock option.
* When the user selects the unlock option the system asks for his gps data.
* The system computes the distance between user gps data and the reserved car gps data.
* If this distance is below XX meters the system sends an unlock command to the car.

Exit Condition
* The user starts the engine of the car.

Exceptions
* If after 1hr the user hasn’t already started the car the reservation is canceled and a 1eur payment is sent via the Payment Manager.
* If there are no available cars no car will be shown to the user.
* If the user selects the cancel reservation option the reservation is canceled.
* When the user requires to unlock the car if his distance from the car is over XX meters the car will not unlock and the user will be notified he is too distant from the car.

Special Requirements

####Send Payment
Participating Actors
* Payment Manager

Entry Condition
* System communicates its intention to charge a client

Flow of Events
* System communicates to the Payment Manager the account to charge and the amount.
* The account is set having pending payments.
* The Payment Manager sends to the payment service a charge for the given amount and the user’s payment informations.
* When the payment service signals the Payment Manager that the payment has been accomplished the Payment Manager sets the user as not having pending payments.

Exit Condition
* The user is set to not having pending payments

Exceptions

Special Requirements
