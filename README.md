# ExplorerScript-Menu-Reimplementations
Contains the necessary Special Processes and Script files for various ExplorerScript reimplementations of hardcoded menus and such. 

# Current Menus Reimplemented
## The Recycle Shop
### Features
- Unlimited custom recycle trade slots!
- Unlimited offer trade slots!
- Bulk Prize Ticket Trading*
- Individual scripts for Prize Ticket scenarios!
- Infrastructure for custom prize ticket types

### Restrictions
- As of now, you can only trade storage items for prize tickets. I could fix this if it's a dealbreaker
- At maximum, only 3 item TYPES can be exchanged for one copy of a 4th item with my current structure. The Link Box Offer from the base game is present in my rendition, and it is hardcoded to ask for 3 rawst berries in addition to the items specified.
- The recycle trades will not display on the top screen! Wynaut tells you what they are after you select them instead!
- You cannot redeem an entire bulk trade of prize tickets, you MUST accept them (this is fine I think, as you have a chance to get a bonus prize ticket that scales with the number of tickets you acquire)
### Installation

(Link to a more complete guide will be here when I have time to write one)
Simply add the script files, export/import the objects/actors/etc from the real script, then import the special processes, reassign them if needed, and configure ``coro EVENT_S30_06`` in ``unionall.ssb`` like so:
```js
coro EVENT_S30_06 {
    $LOTTERY_RESULT = 0;
    §return_to_shop;
    supervision_ExecuteActingSub(LEVEL_P01P04A, 'S30CYCLE', 0);
    if ($LOTTERY_RESULT == 0) {
        screen2_FadeIn(1,30);
        JumpCommon(CORO_END_TALK);
    }
    switch($LOTTERY_RESULT) { // Do Prize Ticket Redemption!
        case < 8: // Loss
            supervision_ExecuteActingSub(LEVEL_P01P04A, 'S30ALOSS', 0);
            break;
        case < 16: // Win
            supervision_ExecuteActingSub(LEVEL_P01P04A, 'S30A0WIN', 0);
            break;
        case < 24: // Big Loss
            supervision_ExecuteActingSub(LEVEL_P01P04A, 'S30BLOSS', 0);
            break;
        default: // Big Win
            supervision_ExecuteActingSub(LEVEL_P01P04A, 'S30BGWIN', 0);
            break;
    }
    jump @return_to_shop;   
    supervision_ExecuteActingSub(LEVEL_P01P04A, 'S30A0601', 0);
    CallCommon(CORO_EVENT_END_FREE);
    end;
}
```
From there, poking around in S30CYCLE.ssb and looking for the ``TODO`` comments should be enough to go off of. At least until I write a formal guide.

## The Personality Quiz (Formerly QuizMenuTool)
### Features
- Unlimited Starter Slots!
- More Natures! (capped at 51 instead of the previous 16)
- Unlimited customizable quiz questions!
- Customizable Aura Bow Segment!
- Infrastructure for complex blacklisting of certain starters!
- Infrastructure for Hero/Partner Sprites mid-quiz!
### Restrictions
- When selecting a hero or partner, it will not display the portrait of the mon as you scroll through the options as it does in base-game!
- Starter selection within the winning nature is random. If you blacklist all available starters, or a blacklisted starter is consecutively selected 100+ times, it will choose bulbasaur as a failsafe (with some funni dialogue). While statistically improbable, it's something to keep in mind.
- The Script Size Limit is lurking nearby. If you get weird behavior, you may have made a script too memory-intensive to run safely. Let me know if this happens to you!
### Installation
(Link to a more complete guide will be here when I have time to write one)
Simply install the Skypatch, install the SPs, add the script files, export/import the objects from the real quiz into each of them, import the special processes, reassign IDs as needed, and configure ``coro EVENT_M00A_01`` in ``unionall.ssb`` like so:
```js
coro EVENT_M00A_01 {
    bgm_Stop();
    if (debug) {
        supervision_ExecuteActingSub(LEVEL_S02P01A, 'M00A01A', 0);
    } else {
        supervision_ExecuteActingSub(LEVEL_S02P01A, 'QMT001', 0);
        supervision_ExecuteActingSub(LEVEL_S02P01A, 'QMT002', 0);
        supervision_ExecuteActingSub(LEVEL_S02P01A, 'QMT003', 0);
        supervision_ExecuteActingSub(LEVEL_S02P01A, 'QMT004', 0);
    }
    $SCENARIO_MAIN = scn[2, 0];
    JumpCommon(CORO_EVENT_DIVIDE);
}
```
