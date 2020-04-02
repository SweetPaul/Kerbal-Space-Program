//first.ks

clearscreen.
PRINT "Counting down:".
FROM {local countdown is 3.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
    PRINT "..." + countdown.
    WAIT 1.
}
lock throttle to 1.0.
lock steering to up + R(0,0,90).
stage.
print "Launch!".

wait until altitude > 10000.
lock steering to up + R(0,0,90) + R(0,-60,0).
print "Beginning gravity turn.".

wait until stage:liquidfuel = 0.
stage.
print "Stage 1 separated.".
wait 1.
Stage.

wait until apoapsis > 100200.
lock throttle to 0.
lock steering to prograde.
print "Waiting for circularization burn".

wait until eta:apoapsis < 15.
print "Burn.".
lock throttle to 0.5.

wait until periapsis > 99500.
lock throttle to 0.

print "finished.".
