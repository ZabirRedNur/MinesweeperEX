# MinesweeperEX
A GUI game based on Minesweeper. Written in Matlab 2015a.

This was my first ever GUI game. I had learnt to program only a couple of months ago in my Matlab course at college (Engineering Major).

This was created for a course. The objective of the course was to create a Matlab program (no restriction on the type of program) that would demonstrate the student's understanding of the language. My program was so much more advanced than everyone else's, the TA (teaching assistant) thought that I'd copied it off the internet! Not surprising, since some students presented code that literally used just 2 to 3 functions to plot a graph (plot is a built-in function in Matlab). I did end up getting full credit though.

Since I had never created a game before, I decided to do a text based version first. I created the basic algorithm to create the minefield and place bombs, then used fprintf() heavily to create a text-based user interface. Once that was working properly, I moved on to create the GUI version. After creating the basic minesweeper game, I decided to make it a little different from vanilla, so I added an ability to detect a bomb at a random location on the minefield. After testing this for several runs, I realized that the game felt too "random" at times when you had a blind choice between two blocks. So I added an ability (that required charging up) to "diffuse" a bomb. You could then go into a 1-in-2 chance without risk, and the game felt a lot less random.

Developing the vanilla game took about 10-15 hours. Developing the powerups took another 30 or so hours. As an inexperienced programmer, I wrote the whole program in a single file, when it should have obviously been modular. Still, it worked so I was happy!
