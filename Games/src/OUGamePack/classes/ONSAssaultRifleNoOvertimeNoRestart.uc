class ONSAssaultRifleNoOvertimeNoRestart extends ONSOnslaughtGame;

var int nTotSecPlayed; // private variable for keeping track of actual seconds actively played (better than Level.TimeSeconds which also counts during match reset)
var bool fixTime;      // private variable for keeping track of when to fix the timer

function PreBeginPlay()
{
    OvertimeCoreDrainPerSec = 1500;  // a much higher value not available through the configuration menu
                                     // call before game play starts as opposed to repeatedly in the timer function
                                     // 10,000 results in always destroying the red team core (1st team) but this may be due to the 1 minute game constraint used when testing
                                     // 3,000 can be inaccurate and takes about a second
                                     // 2,000 can be inaccurate and takes a couple seconds
                                     // 1,000 takes too long but does work
    nTotSecPlayed = 0;
    fixTime = false;

    Super.PreBeginPlay();
}

function AddDefaultInventory(pawn PlayerPawn)  // leave this function blank to assign no weapons at game start
{
    local xPawn x;        // local copy of player
    local Weapon tmpwep;  // local copy of weapon

    // use this code to give a specified weapon
    /*
    I think these are the names of the weapons that are under the inventory class:
        Redeemer: xweapons.redeemer
        Assault Rifle: xweapons.assaultrifle (works)
        Avril: onslaught.onsavril
        Bio Rifle: xweapons.biorifle
        Flak Cannon: xweapons.flakcannon
        Grenade Launcher: onslaught.onsgrenade
        Ion Painter: xweapons.painter
        Lightning Gun: xweapons.sniperrifle (works)
        Link Gun: xweapons.linkgun (works)
        Mine Layer: onslaught.onsminelayer
        Minigun: xweapons.minigun
        Rocket Launcher: xweapons.rocketlauncher
        Shield Gun: xweapons.shieldgun
        Shock Rifle: xweapons.shockrifle
        Sniper Rifle: utclassic.classicsniperrifle
    */

    x = xPawn(PlayerPawn);
    PlayerPawn.GiveWeapon("XWeapons.assaultrifle");
    // end use this code to give a specified weapon

    // use this code to change the amount of ammo for the assigned weapon
    tmpwep = Weapon(PlayerPawn.FindInventoryType(class'AssaultRifle')); // assign a weapon as indicated in the previous comment block
    //tmpwep.SuperMaxOutAmmo();                                         // to max the ammo out to 999 rounds
    tmpwep.FillToInitialAmmo();                                         // hopefully gives a reasonable amount of ammo
    // end use this code to change the amount of ammo for the assigned weapon
}

state MatchInProgress
{
	event Timer()
	{
        if (ResetCountDown == 0)
           nTotSecPlayed = nTotSecPlayed + 1;  // update total seconds played only when actually playing

        if (ResetCountDown == 2)
            fixTime = true;

        super.Timer();

        if (fixTime && (60 * TimeLimit > nTotSecPlayed))  // fix the time only when there actually is time left
        {
            RemainingTime = (60 * TimeLimit) - nTotSecPlayed;
            GameReplicationInfo.RemainingMinute = RemainingTime;
            fixTime = false;
        }
    }
}

function RestartGame() // override this function to prevent the server from restarting
{
    ConsoleCommand("QUIT", true);  // And use this to quit server
}

defaultproperties
{
    GameName="Onslaught - Assault Rifle, No Overtime, No Server Restart"
    Description="Onslaught starting with assault rifle, game over by total time played, and overtime core drain is essentially instantaneous."
}
