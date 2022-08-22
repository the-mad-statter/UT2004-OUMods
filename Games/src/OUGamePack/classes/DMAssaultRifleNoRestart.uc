class DMAssaultRifleNoRestart extends xDeathMatch;

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

function RestartGame() // override this function to prevent the server from restarting
{
    ConsoleCommand("QUIT", true);  // And use this to quit server
}

defaultproperties
{
    GameName="Death Match - Assault Rifle, No Server Restart"
    Description="Death Match starting with Assault rifle, no server restart."
}
