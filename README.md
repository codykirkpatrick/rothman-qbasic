# rothman-qbasic
# David Rothman's Computer Ranking System

## Authors
<ul>
  <li>By David Rothman (1935-2004)</li>
  <li>Last known update in 1990</li>
  <li>As part of the Foundation for the Analysis of Competitions and Tournaments (FACT)</li>
</ul>
Modified and shared here:
<ul>
  <li>By Cody Kirkpatrick</li>
  <li>Contact: codyk@talismanred.com</li>
  <li>Last update 08/2024</li>
</ul>

## What is contained here

Source code; demo files

## Explanation of Rothman's system

This is a QuickBasic version of David Rothman's sports ranking code.  Yes, QuickBasic!  The code
was originally developed in the late 80's, after all.

Simplified, Rothman's system works based on the following principles:
- Every game played is of equal weight/value
- Location is ignored, and date of the game is ingored
- What's left is what matters: the score margin and your opponent's strength
- A "diminishing returns" principle applies to the margin of victory, so that running up the score
does not gain you any favor

The system balances performance (wins and losses), scoring (margin of victory/loss), and strength 
of schedule (who you play & how you score against them).

## To run it... Step 1, you need the source code:

Get the file ROTHMAN.BAS, which works for me in QB 4.5.  So you will need either a retro rig 
(probably Windows 98 or earlier, but I've gotten this code to work on XP too), or run QB within DOSBox.
I've had success with all of those options, but I prefer watching it slooooooowwwwly run on 486 
and P1 machines, frankly.

There are also some notes inside ROTHMAN.BAS, if you want to edit the source code.  That's up to you.
One thing I ask: even thought it is commented out with REM statements, please leave David's original
contact information in the source code as it has existed for over 20 years, so that we can continue 
to honor his legacy.

Side note: "Back in the day," Rothman actually had the code split into two separate programs, one to create the
ratings and another to create the output list of ranked teams.  I suspect this was for efficiency, but I've
never completely figured it out.  A few years ago I decided to combine them 
into a single source code file, to make the overall process easier.  That's what ROTHMAN.BAS is.  I can
provide his original, separate files if you want them; I might add them to the repository at some point.

## Step 2, you need the data for your league:

The data for your league consists of four files:

<ol>
    <li>TEAM.DB - A list of team names, with one per line</li>
    <li>GUESS.DB - The first guesses of each team's rankings (can be an actual guess, or I tend to use
      50.000 for everyone, no matter how many games have been played</li>
    <li>SCORE.DB - Game scores, with one game per line.  Each line has four numbers, separated by spaces.</li>
      <ul>
        <li>Example line:  23 102 15 87</li>
        <li>That line means: team #23 in your TEAM.DB file has defeated team #15, by a basketball score of 102-87
        <li>It does not matter if the winner or loser is reported first</li>
        <li>The order is always team - score - team - score
        <li>The order is never team - team - score - score</li>
        <li>One game per line, always</li>
     </ul>
    <li>XDIV.DB - Three lines of header information, followed by the division or conference for each team in your league</li>
     <ul>
       <li>Line 1 example: 30 274 500</li>
       <li>Line 1 explanation: you have 30 teams, who have collectively played 274 games, and you wish to iterate no 
      more than 500 times</li>
       <li>Line 2: the text you want to appear as the TOP line in the output file</li>
       <li>Line 3: the text you want to appear as the THIRD line in the output file</li>
       <li>Remaining lines: the division or conference for each team in your league. Required even if they
       are all the same</li>
     </ul>
</ol>

## Step 3, your output file:

If all goes well, you will get a file called STANDING.DB that produces your Rothman Rankings.  Congratulations!
