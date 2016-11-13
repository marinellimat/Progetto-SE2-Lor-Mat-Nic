open util/boolean

sig Position {}
sig Credential {}
sig Payment_Info {}
sig LicensePlate {}
sig Plug {}

one sig SafeArea { 
	position: some Position
}

sig ChargingStation {
	position: one Position,
	plugs: some Plug,
}

sig PowerUser {		
	credential: Credential,
	payment_info: Payment_Info,
	position: one Position,
	pendingPayment: one Bool,
}

abstract sig CarState {}
one sig AVAILABLE extends CarState {}
one sig RESERVED extends CarState {}
one sig IN_USE extends CarState {}
one sig UNAVAILABLE extends CarState {}

sig Car {
	batteryLevel: Int,
	peopleInside: Int,
	motorIgnited: Bool,
	malfunctioning: Bool,
	license: one LicensePlate,
	position: one Position,
	locked: one Bool,
	charging: lone Plug, 
	state: one CarState 
}
{	
	batteryLevel >= 0
	batteryLevel <= 100
	peopleInside >= 0
	peopleInside <=5
}


sig Reservation {
	user: one PowerUser,
	selectedCar: one Car,
	invoice: lone Invoice,
	expired: one Bool,
	cancelled: one Bool, 
}
{	
	expired = True implies (no r: Ride | r.user = user and r.selectedCar = selectedCar)
	cancelled = True implies (no r: Ride | r.user = user and r.selectedCar = selectedCar)
	expired = True <=> invoice != none
	invoice != none implies invoice.user = user
}


sig Invoice{
	user: one PowerUser,
	discount: lone Int,
	fine: lone Int,
	paid: one Bool,
}

sig Ride {
	user: one PowerUser,
	selectedCar: one Car,
	invoice: lone Invoice,
	completed: Bool, 
	sharedRide: Bool,
}
{	
	sharedRide = True <=> selectedCar.peopleInside >= 3
	completed = False implies invoice.discount = none
	completed = False implies invoice.fine = none
	completed = True <=> invoice != none
	invoice != none implies invoice.user = user
}

// USER FACTS 
fact userFacts {
	all u1, u2: PowerUser | u1 != u2 <=> u1.credential != u2.credential
	all u1, u2: PowerUser | u1 != u2 <=> u1.payment_info != u2.payment_info
	PowerUser.payment_info=Payment_Info
	PowerUser.credential = Credential
}

// USER WITH PAYMENT PENDING 
fact PaymentPendingUser {
	all u: PowerUser | u.pendingPayment = True <=> one i: Invoice | i.user = u && i.paid = False
	all u: PowerUser | u.pendingPayment = True implies (no r: Reservation | r.user = u && r.expired = False && r.cancelled = False)
}

// INVOICES
fact ValidInvoices {
	no disjoint r1, r2: Ride | r1.invoice = r2.invoice
	no disjoint r1, r2: Reservation | r1.invoice = r2.invoice
	all i: Invoice | i != none implies one r: Reservation | r.invoice = i or one rr: Ride | rr.invoice = i 
 
}

// CAR 
fact carLicenseUnique {
	all c1, c2: Car | (c1 != c2) => c1.license != c2.license
	#LicensePlate = #Car.license 
}

fact carPositionUnique {
	all c1, c2: Car | (c1 != c2) => c1.position != c2.position
	}

fact carLockedWhenNoOneInside {
	all c: Car | c.peopleInside = 0 implies c.locked = True
}

fact motorIgnitedOnlyWithPeopleInside {
	all c: Car | c.motorIgnited = True implies c.peopleInside > 0
}

fact motorIgnitedImpliesRide {
	all c: Car | c.motorIgnited = True implies (one r: Ride | r.selectedCar = c)
	all c: Car | c.motorIgnited = True implies c.state = IN_USE
}

// CAR STATES 

fact carAvailableState {
	all c: Car | c.state = AVAILABLE implies c.batteryLevel >= 20
	all c: Car | c.state = AVAILABLE implies c.motorIgnited = False
	all c: Car | c.state = AVAILABLE implies c.peopleInside = 0
	all c: Car | c.state = AVAILABLE implies (one s: SafeArea | c.position in s.position) or (one ch: ChargingStation | c.position = ch.position)
}

fact carReservedState {
	all c: Car | c.state = RESERVED implies one r: Reservation | r.selectedCar = c && r.expired = False && r.cancelled = False
	all c: Car | c.state = RESERVED implies no r: Ride | r.selectedCar = c 
	all c: Car | c.state = RESERVED implies c.malfunctioning = False
	all c: Car | c.state = RESERVED implies c.motorIgnited = False
	all c: Car | c.state = RESERVED implies c.batteryLevel >= 20
	all c: Car | c.state = RESERVED implies (one s: SafeArea | c.position in s.position) or (one ch: ChargingStation | c.position = ch.position)
}

fact carInUseState {
	all c: Car | c.state = IN_USE <=> one r: Ride | r.selectedCar = c
	all c: Car | c.state = IN_USE implies one r: Reservation | r.selectedCar = c && r.expired = False && r.cancelled = False
	all c: Car | c.state = IN_USE implies one r: Ride | r.selectedCar = c
	all c: Car | c.state = IN_USE implies c.peopleInside > 0
}

fact carUnavailable {
	all c: Car | c.state = UNAVAILABLE implies no r: Reservation | r.selectedCar = c
	all c: Car | c.state = UNAVAILABLE implies c.locked = True
	all c: Car | c.state = UNAVAILABLE <=> c.malfunctioning = True
	all c: Car | c.state = UNAVAILABLE <=> c.batteryLevel <= 20 && c.motorIgnited = False && c.peopleInside = 0
	all c: Car | c.state = UNAVAILABLE <=> c.batteryLevel = 0
}

// RESERVATION

fact oneReservationPerUser{
	no disjoint r1, r2: Reservation | r1.user = r2.user
}
fact oneReservationPerCar {
	no disjoint r1, r2: Reservation | r1.selectedCar = r2.selectedCar
}

// RIDE 
fact NoRideWithoutActiveReservation {
	all r: Ride, c: Car | r.selectedCar = c implies one rr: Reservation | rr.user = r.user and rr.selectedCar = r.selectedCar and rr.expired = False && rr.cancelled = False
}

fact onlyOneReservationPerCar {
	 no disjoint r1, r2: Reservation | r1.selectedCar = r2.selectedCar 
}

// 	ChargingStation
fact ChargingStationAreSafeArea {
	all ch: ChargingStation | ch.position in SafeArea.position 
}

fact carsCannotBePluggedInTheSamePlug {
	no disjoint c1, c2: Car | c1.charging = c2.charging
}

fact ChargingStationUniquePosition {
	no disjoint c1, c2: ChargingStation | c1.position = c2.position 
}

fact noChargingVehicle {
	all c: Car | c.motorIgnited = True implies c.charging = none
	all c: Car | c.locked = False implies c.charging = none
	all c: Car | c.peopleInside > 0 implies c.charging = none
	
}

fact plugBelongsToAChargingStation {
	all p: Plug | p != none implies (one c: ChargingStation | p in c.plugs) 
	no disjoint c1, c2: ChargingStation | c1.plugs & c2.plugs != none

}

fact carsChargingSamePositionOfChargingStation{
	all c: Car | c.charging != none implies (one cs: ChargingStation | c.position = cs.position)
}

fact carsChargingAssignedToAPlug{
	all c: Car | c.charging != none implies (one cs: ChargingStation | c.charging in cs.plugs)
}

// discount 

fact reservationInvoiceHaveNoDiscount {
	all r: Reservation | r.invoice.fine = none and r.invoice.discount = none
}

fact NoDiscountIfFine {
	all r: Ride | r.invoice.fine != none implies r.invoice.discount = none
}


fact discount {
	all r: Ride | r.completed = True && r.selectedCar.state = IN_USE && r.sharedRide = True implies r.invoice.discount = 10
	all r: Ride | r.completed = True && r.selectedCar.state = IN_USE && r.selectedCar.batteryLevel > 50 implies r.invoice.discount = 20
	all r: Ride | r.completed = True && r.selectedCar.state = IN_USE && r.selectedCar.charging != none implies r.invoice.discount = 30
}

fact fines {
	all r: Ride | r.completed = True && r.selectedCar.state = IN_USE && r.selectedCar.batteryLevel <= 20 implies r.invoice.fine = 20
}

// ASSERT 

pred show () {
	some c:Car | c.state = IN_USE
}

run show for 2 but 8 Int
