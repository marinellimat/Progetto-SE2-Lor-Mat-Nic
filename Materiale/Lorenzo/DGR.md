###Legal constraint:
Having functioning cars we will probably have insurance. To avoid legal problems when registering the user acknowledges that to be covered by our insurance the driver must always be the same person whose account has been used to reserve the car. In case this is not true and for all the cases not covered by our insurance the User will take full responsibility of his actions.


Users who leave the car in an unsafe area will be charged, in addition to the normal ride fee and eventual increase, with the full price of transporting the car back to a safe area plus eventual fines the company incurs in.


###Domain Properties
1. GPS always gives the correct position
2. Each car has an always available GPS
3. Cars have a way to determine the number of passengers currently on board
4. Cars have a way to detect current battery level
5. The set of safe areas and charging stations is predefined
6. User with a valid driving license is always able to drive
7. User who reserves a car, is the driver (to ensure legally) or has full responsibility for what happens
8. Cars with locked door cannot be opened from the outside
9. Charging Station have a finite number of plugs
10. Charging Station can communicate to the system the number of available plugs
11. Cars left in unsafe areas will be brought back to safe areas (magically) 
12. Users with expiring payment informations will provide new valid payment info before expiration date.
13. Driver will behave correctly (illegal behaviour)
14. There is a human-managed system that dispatches employees to on-site recharges
15. There is a human-managed system that dispatches employees to malfunctioning cars
16. Cars have a way to detect whether they are functioning  correctly (mechanical/engine…)
17. There is a functioning payment system


###Goals:
1. Allows USER to register providing credentials and payment informations
2. Allows REGISTERED USER to modify its personal informations
3. Registered User must have valid credentials and payment info all the time.
4. Allows REGISTERED USER to see locations and battery levels of available CARs within a specific distance from a specified address
5. Allows REGISTERED USER to reserve an available CAR up to 1 hour in advance but charge him 1 eur if the CAR is not picked up
6. Allows CARs to be automatically locked when parked and the user gets out
7. Allows REGISTERED USER to cancel a RESERVATION before taking the car
8. Allows REGISTERED USER to unlock the RESERVED CAR when he is nearby
9. Allows REGISTERED USER to know the current FEE at any time through a screen in the CAR
10. Doesn’t allow USERs to RESERVE a CAR already RESERVED or in USE
11. Doesn’t allow USERs to reserve more than a car at a time.
12. Allows REGISTERED USER to enable money saving options for a ride
13. Allows EMPLOYEE to know the location of CARS that need to be recharged
14. CARs with battery below 30% or at more than 3km from a STATION need to be recharged on place
15. Malfunctioning cars need to be taken care of by an employee
16. Allow User to get in a reserved car once he’s near enough to it (enough???)
17. Users will be charged from the moment they start the engine until they leave the car
18. Only cars in safe Areas can be reserved
19. Policies about Fees need to be applied for the rides.
20. Users who leaves the cars in unsafe areas will be overcharged according to PEJ policy
21. Users with pending payments can’t reserve cars


###Requirements
1. System must have a registration mechanism
2. System must have a credentials validation mechanism
3. System must have a payment information validation mechanism
4. System must check the validity of credentials and payment info before accepting them
5. Registered User must be able to signal his gps coordinates
6. Registered User must be able to signal he wants the car he has reserved unlocked
7. When User requests for unlocking System must check he is within 50m from the car and in that case unlock it (is it 1 or 2 reqs???)
8. Registered User must be able to specify an address
9. Registered User must be able to select a distance range
10. System must be able to compute the distance between two locations
11. System must be able to compute the path between two locations
12. The Registered User is proposed only the cars in the range he specified from the location he specified
13. The Registered User can see the battery level of each car that is proposed to him
14. Only cars in safe areas, not in use, not malfunctioning, not to recharge on-site and not reserved are considered available.
15. Cars with less than XX% battery are considered to be recharged on-site
16. Cars at more than 3 km from any charging station are considered to be recharged on-site
17. Only available cars can be proposed to the user.
18. The registered user can select to reserve anyone of the cars proposed to him
19. The registered user can’t have more than one reservation pending
20. Reservations expire after one hour
21. When a reservation expires the user who had it is charged 1 EUR
22. A Reservation is LIFTED when the user starts the engine
23. A Ride ends when the user and all the passengers exit from the car
24. The basic cost of a Ride is calculated from the moment the engine starts to the moment the Ride ends.
25. When a Ride ends the car is locked.
26. The Fee for the ride must be computed in real time
27. The current Fee for the ride must be constantly displayed in the car
28. User can select Money Saving Option at any time during the ride
29. User must be able to enter the desired location while using MSO
30. When user selects MSO the system must compute the location of the available charging station (nearest to the user’s desired location)
31. Charging station are considered to be available if and only if there is at least one available plug
32. Computed the location of the charging station for MSO must compute the path between it and current location
33. The system must display the path for MSO in the car
34. The user will be assigned the corresponding discount if he plugs the car in the power grid within 5 minutes from the end of the ride.(to rewrite more like a req. less like a goal)
35. At the end of the ride system must check location and battery level of the car to compute applicability of discount policies.
36. During the ride the system must check the number of the passengers to compute applicability of discount policies.
37. LISTING DISCOUNT POLICIES?
38. If a user fits the requirements for more than one discount he will only be assigned the one most convenient for him (to specify case by case)
39. If a user fits the requirements for both a discount and a fine only the fine will be applied ???
40. Data about cars with less than XX% of battery and at more than 3 km from any charging station must be available to the service of “on-site recharge”
41. Data about cars that identify a malfunctioning must be available to the service that takes care of it
42. The cost of the transport service for a car left in unsafe area is fully charged on the user who left it there
43. System must be aware of the payment status of each ride at least until they are paid
44. Users with pending payments can’t reserve a cas