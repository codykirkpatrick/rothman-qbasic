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
  <li>Last update 01/2024</li>
</ul>

## What is contained here

List of original code files; my updated file; demo files

## Explanation of Rothman's system

This is a QuickBasic version of David Rothman's sports ranking code.  Yes, QuickBasic!  The code
was originally written in the late 80's, after all.

(include here a description of how the system works)

## Step 1, you need the source code:

Get the file ROTHMAN.BAS, which works for me in QB 4.5.  So you will need either a retro rig 
(probably Windows 98 or earlier, but I've gotten this code to work on XP too), or run QB within DOSBox.
I've had success with both, but prefer watching it slooooooowwwwly run on 486 and P1 machines, frankly.

In this repository I also provide Rothman's original source code files -- "back in the day" he actually
had the code split into two separate programs.  I decided to combine them into one, to make the process
easier.  That's what ROTHMAN.BAS is.

There are also some notes inside ROTHMAN.BAS, if you want to edit the source code.  That's up to you.
One thing I ask: even thought it is commented out with REM statements, please leave David's original
contact information in the source code as it has existed for over 20 years, so that we can continue 
to honor his legacy.

## Step 2, you need the data for your league:

The data for your league consists of four files:

<ol>
    <li>TEAM.DB - A list of team names, with one per line</li>
    <li>GUESS.DB - The first guesses of each team's rankings (can be an actual guess, or I tend to use
      50.000 for everyone, no matter how many games have been played</li>
    <li>SCORE.DB - Game scores, with one game per line.  Each line has four numbers, separated by spaces.</li>
      <ul>
        <li>Example: Team #23 in your TEAM.DB file has defeated Team #15, by a basketball score of 102-87
        <li>That should appear in the score file as: 23 102 15 87</li>
        <li>It does not matter if the winner or loser is reported first</li>
        <li>But the order is team - score - team - score, never team - team - score - score</li>
     </ul>
    <li>XDIV.DB - Header information followed by the division or conference for each team in your league</li>
     <ul>
       <li>Line 1: if you have 30 teams, who have played 274 games, and wish to iterate no more than 500 times,
       then Line 1 of this file will be: 30 274 500</li>
       <li>Line 2: what will appear as the TOP line in the output file. Whatever you want it to be</li>
       <li>Line 3: what will appear as the THIRD line in the output file. Whatever you want it to be</li>
       <li>Remaining lines: the division or conference for each team in your league. Required even if they
       are all the same</li>
     </ul>
</ol>

## Step 3, your output file:

If all goes well, you will get a file called STANDING.DB that produces your Rothman Rankings.  Congratulations!
