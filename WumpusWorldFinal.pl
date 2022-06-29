%The location of the wumpus.
wumpus(room(3,2)).
%The location of the pit.
pit(room(4,2)).
%The location of the room to be checked for adjacents.
room((1,1)).
%indicator of the life status for the wumpus 0 is alive, 1 is dead.
wumpusisdead(0).
%The starting point of the player.
startingpoint((3,2)).
%The location of the gold in the map.
gold(room(5,7)).


%lets assume that we have a 8*8 matrix as a board for our game.
%So the player must be in coordinates of rooms bigger or equal to 1 and smaller or equal to 8. 
room(X,Y):-
    X @>= 1,
    X @=< 8,
    Y @>= 1,
    Y @=< 8.

%Lets create breeze so we can know the location of pits in our game.
breeze(room(X,Y)):- 
NewX1 is X - 1,
pit(room(NewX1,Y)).

breeze(room(X,Y)):- 
NewX2 is X + 1,
pit(room(NewX2,Y)).

breeze(room(X,Y)):- 
NewY1 is Y - 1,
pit(room(X,NewY1)).

breeze(room(X,Y)):- 
NewY2 is Y + 1,
pit(room(X,NewY2)).

%Lets create an indicator for the wumpus using the Stench.
stench(room(X, Y)):-  
NewX1 is X - 1,
wumpus(room(NewX1,Y)).

stench(room(X, Y)):-   
NewX2 is X + 1,
wumpus(room(NewX2,Y)).

stench(room(X, Y)):-  
NewY1 is Y - 1,
wumpus(room(X,NewY1)).

stench(room(X, Y)):-   
NewY2 is Y + 1,
wumpus(room(X,NewY2)).

%Lets see which rooms are Adjacent to the player.
adjacentto(room(X,Y)):- 
NewX1 is X - 1,
room((NewX1,Y)).

adjacentto(room(X,Y)):- 
NewX2 is X + 1,
room((NewX2,Y)).

adjacentto(room(X,Y)):- 
NewY1 is Y - 1,
room((X,NewY1)).

adjacentto(room(X,Y)):- 
NewY2 is Y + 1,
room((X,NewY2)).

%Lets check if the room is safe.
checkifsafe(room(X,Y)):-
room(X,Y),
not(pit(room(X,Y))), not(wumpus(room(X,Y))).

checkifsafe(room(X,Y)):-
room(X,Y),
not(pit(room(X,Y))), (wumpusdead(1)).

%Here we check if the adjacent rooms are safe or not.
checkroomontheleft():-
startingpoint((X,Y)),
NewX is X-1,
checkifsafe(room(NewX,Y)).

checkroomontheright():-
startingpoint((X,Y)),
NewX is X+1,
checkifsafe(room(NewX,Y)).

checkroomonsouth():-
startingpoint((X,Y)),
NewY is Y-1,
checkifsafe(room(X,NewY)).

checkroomonnorth():-
startingpoint((X,Y)),
NewY is Y+1,
checkifsafe(room(X,NewY)).

%We grab the gold if we are in the same room as the gold.
grabgold(room(X1,Y1)):-
gold(room(X,Y)),
X1 == X, Y1 == Y, write("Success").

%We shoot the wumpus if its in one of the adjacent rooms to the player.
shootwumpus(room(X1,Y1)):-
wumpus(room(X,Y)),
stench(room(X1, Y1)),
wumpusisdead(1).
write("Success").
