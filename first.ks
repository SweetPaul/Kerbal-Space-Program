//first.ks

//didnt even make this loop myself....RIP but it's nice.
clearscreen.
PRINT "Counting down:".
FROM {local countdown is 3.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
    PRINT "..." + countdown.
    WAIT 1.
}



//Set Throttle equal to TWR at specified ratio per craft. 
//Idea here is to maximize Delta V for the craft. Getting it through the atmosphere quick but without blowing too much fuel against the dynamic pressure(air resistance). 
lock throttle to 1.0. 
//Rotation here of the craft when steering is "activated" is slightly reckless. Would prefer to have it wait till altitude reaches 100m before begining rotation and do it slowly.
lock steering to up + R(0,0,-180).

stage.
print "Launch!".

//A good idea I heard was using a variable called "runmode" to determine what part of the script to run when. instead of just flat out... at altitude do x,y and z.
//It lets the craft know, im in ground mode. now im in accent part one, then part two, etc... that way the script and logic can be broken up at the proper times
//This could also make troubleshooting easier as the craft can announce what "runmode" number it is on. 

until (ship:verticalspeed > 100 and altitude > 2000) { 
    If Stage:liquidfuel < 0.1 {
        Stage.
    }
    If Ship:altitude > 100 {
        lock steering to up + R(0,0,-90).
    }
}

print "Beginning gravity turn.".
//Blind "Gravity Turn". Would like to add logic that tells it to turn at a reasonable rate. Say, X distance off the center of the Prograde Vector (This is the ships true direction of velocity)
//This would reduce how much drag the ship takes on during accent inside atmosphere. Once in space, the ship can rotate as fast as it can for the most part. 
until apoapsis > 100200 {
    lock steering to up + R(0,-45,-90).
    If Stage:liquidfuel < 0.1 {
        Stage.
        Print "Stage seperated.".
    }
}
lock throttle to 0.
lock steering to prograde.
print "Waiting for circularization burn".

//Throttle here must be adjusted to keep craft from reaching apoapsis before burn is complete
//Possible use of Node function here to determine amount of time needed to reach required velocity for circularization
wait until eta:apoapsis < 30. 
until periapsis > 70000 {
        if eta:apoapsis <30 {
        lock throttle to 1.0.
        if Stage:liquidfuel < 0.1 {
            Stage.
            Print "Stage seperated.".
        }
    }
    
}
//Staging needs to be a seperate loop constantly checking fuel amount and staging when neccssary and then resuming without intrupting script 
//If possible would like it to check if the next stage has an engine or not to distinguish parachutes for landing sequence in atmosphere
lock throttle to 0.

//Second half of circularization burn, placing periapsis outside of the atmosphere

print "finished.".

wait until false.