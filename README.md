# ExplorerScript-Menu-Reimplementations
Contains the necessary Special Processes and Script files for various ExplorerScript reimplementations of hardcoded menus and such. 

# Current Menus Reimplemented
## The Recycle Shop
Features:
- Unlimited custom recycle trades
- Unlimited offer trades 
- Bulk Prize Ticket Trading* (As of now, you can only trade storage items for prize tickets. I could fix this if it's a dealbreaker)
- Individual scripts for Prize Ticket scenarios!
- Infrastructure for custom prize ticket types
(Link to a more complete guide will be here when I have time to write one)
Basically just add the script files, import the special processes, reassign them if needed, and configure ``coro EVENT_S30_06`` like so:
![image](https://github.com/user-attachments/assets/aad1246a-a643-46ef-a1cd-d2d3aba4c900)
From there, poking around in S30CYCLE.ssb and looking for the ``TODO`` comments should be enough to go off of. At least until I write a formal guide.
