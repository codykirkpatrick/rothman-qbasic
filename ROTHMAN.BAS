REM CALCULATE COMPUTER RANKINGS WITH THE FORMULA OF
REM DAVID ROTHMAN (1936-2004)
REM
REM * Code updated by Cody Kirkpatrick, 2021 & 2022..
REM * Contact: ratings@talismanred.com
REM
REM * No changes to Rothman's formula, his method of
REM * finding convergence, or the output parameters,
REM * have been made.
REM
REM * Changes that have been made:
REM *
REM * 1. If using QBasic in DOSBox or on an older machine,
REM *    the number of teams times the
REM *    number of games per team must be less than
REM *    2^15 - 1 (or less than 32,767).  Originally, the
REM *    code had to be edited to specify the max number
REM *    of teams and games, which to me was unneeded.
REM *    Below, I read in the number of teams from the
REM *    usual place, XDIV.DB, use that for NTMAX, and
REM *    calculate a proper value for NGMAX.
REM *        I've used 32,000 instead of 32,767 to avoid
REM *    rounding issues.  If you want to override these
REM *    calculations, edit the code at line 60-69.
REM *        On a 64-bit system (e.g., using QB64), this
REM *    limitation does not exist.
REM * 2. The intermediate "guess" rating is saved to file
REM *    every few iterations.  I have it set at 12; you
REM *    can change this at lines 930-931.
REM * 3. The output file ITER.DB, with a summary of the
REM *    the program's output, is no longer saved.  Instead,
REM *    all this information simply goes to the screen.
REM * 4. The title lines on STANDING.DB (read in from XDIV)
REM *    are now automatically centered on the output.
REM *    Previously, the code or output file had to be
REM *    adjusted manually to achieve this.
REM * 5. Since David has passed away, I have moved his old
REM *    contact info to the comments (and replaced it with
REM *    mine), but I keep it in here to honor him.  Please
REM *    do replace mine with yours in your output, at lines
REM *    2003-2004.
REM
REM BEGIN REGULAR PART OF CODE
10 REM RANKDUB.BAS, DAVID ROTHMAN, 11/9/90
20 REM MAXIMUM LIKELIHOOD ESTIMATES OF LOGITS
40 DEFINT I-N, P, S, W
50 DEFDBL A-H, O, Q-R, T-V, X-Z
51 REM GO AHEAD AND OPEN XDIV.DB, READ NUMBER OF TEAMS
52 OPEN "I", #5, "XDIV.DB"
53 INPUT #5, NTEAM, NGAME, NIT, NA$, NB$
54 REM FIRST ENTRY IS NUMBER OF TEAMS--NO MORE THAN NTMAX
55 REM SECOND ENTRY IS NUMBER OF GAMES
56 REM THIRD ENTRY IS MAX NUMBER OF ITERATIONS SPECIFIED
57 PRINT USING "We will read in #### teams."; NTEAM
58 PRINT USING "We will read in ##### games."; NGAME
59 PRINT USING "We will iterate no more than ##### times."; NIT

60 REM SET MAXIMUM NUMBER OF TEAMS
61 NTMAX = NTEAM
62 REM SET MAXIMUM NUMBER OF GAMES
63 NGMAX = INT(32000 / NTMAX) - 1
64 IF NGMAX > 800 THEN NGMAX = 800
65 REM NGMAX = 41

66 PRINT USING "Max number of teams is set to ####."; NTMAX
67 PRINT USING "Max number of games per team is set to ####."; NGMAX

70 DIM N(NTMAX, NGMAX), AVE(NTMAX), XZ(NTMAX, 3), GR(2), IJ(2)
71 REM YY(2)
72 REM ^^ apparently YY is not used, so I commented it out
73 DIM WN(3, NTMAX), PF(NTMAX), PA(NTMAX), EN(NTMAX), IRAN(NTMAX)
74 DIM P$(33), DI$(NTMAX), RRE(NTMAX), TIEFOUND
80 OPEN "I", #4, "GUESS.DB"
85 OPEN "I", #3, "SCORE.DB"
90 OPEN "O", #6, "STANDING.DB"
110 REM Open "O", #8, "ITERATE.DB"
120 REM DLIM = .5D0
130 REM For I = 1 To 64
140 REM If 1D0 + DLIM = 1D0 GoTo 170
150 REM DLIM = DLIM / 2D0
160 REM Next I
170 REM DLIM = DLIM * 8D0

210 DF = NGAME - NTEAM + 1
211 IF DF < 2! THEN DF = 1!
212 NOUT = LOG(DF)
213 NOUT1 = NOUT - 1
220 NALEN = LEN(NA$)
221 NALEN = INT((36 - (NALEN / 2) - 1) * 10 + 5) / 10
222 IF NALEN > 0 THEN
223 FOR I = 1 TO NALEN
224 PRINT #6, " ";
225 NEXT I
226 END IF
227 PRINT #6, NA$
230 PRINT #6, "    BASED ON";
231 PRINT #6, USING " ####"; NGAME;
232 PRINT #6, " GAMES BETWEEN";
233 PRINT #6, USING " ###"; NTEAM;
234 PRINT #6, " TEAMS, AND NO OTHER INFORMATION"
240 REM Print #6, "                 "; NB$
241 NBLEN = LEN(NB$)
242 NBLEN = INT((36 - (NBLEN / 2) - 1) * 10 + 5) / 10
243 IF NBLEN > 0 THEN
244 FOR I = 1 TO NBLEN
245 PRINT #6, " ";
246 NEXT I
247 END IF
248 PRINT #6, NB$
250 PRINT #6, "      FOUNDATION FOR THE ANALYSIS OF ";
251 PRINT #6, "COMPETITIONS AND TOURNAMENTS"
260 PRINT #6, " "
261 PRINT #6, "  RANK   TEAM               DIVISION  LOGIT  ";

270 REM EACH TEAM MUST HAVE NO MORE THAN NGMAX GAMES
289 NSKED = NGMAX
290 FAC = 1.813799364234218# / 15#
295 NTM1 = NTEAM - 1
300 XZM = 0#
315 FOR I = 1 TO NTEAM
360 INPUT #4, XZ(I, 0)
370 REM FIRST GUESSES FOR LOGITS OF TEAMS (IN ORDER)
390 INPUT #5, DI$(I)
391 REM DIVISION NAME FOR TEAM
400 XZM = XZM + XZ(I, 0)
410 NEXT I
414 CLOSE #4
415 CLOSE #5
418 REM TEAM = NTEAM
420 XZM = XZM / NTEAM
422 FOR I = 1 TO NTEAM
440 FOR J = 1 TO 3
450 WN(J, I) = 0
460 NEXT J
465 EN(I) = 1E-35
470 PF(I) = 0
480 PA(I) = 0
523 XZ(I, 0) = EXP(FAC * (XZ(I, 0) - XZM))
524 AVE(I) = 0#
525 FOR J = 1 TO NSKED
526 N(I, J) = 0
527 NEXT J
528 NEXT I
530 FOR I = 1 TO NGAME
540 INPUT #3, I1, S1, I2, S2
541 REM PRINT USING "#### #### - ### ### - ### ###"; I; NGAME; I1; S1; I2; S2
550 REM FIRST ENTRY IS INDEX OF FIRST TEAM IN GAME
560 REM SECOND ENTRY IS SCORE OF FIRST TEAM IN GAME
570 REM THIRD ENTRY IS INDEX OF SECOND TEAM IN GAME
580 REM FOURTH ENTRY IS SCORE OF SECOND TEAM IN GAME
590 IF (S1 - S2 = 0) THEN TIEFOUND = 1
600 PF(I1) = PF(I1) + S1
610 PA(I1) = PA(I1) + S2
620 PF(I2) = PF(I2) + S2
630 PA(I2) = PA(I2) + S1
640 DEL = S2 - S1
650 REM GRADE THIS MARGIN
660 R = .25#
670 IF DEL < 0# THEN R = .5# ELSE IF DEL > 0# THEN R = 0#
690 GR(1) = R + .5# / (1# + EXP(FAC * DEL))
700 GR(2) = 1# - GR(1)
720 IJ(1) = I1
730 IJ(2) = I2
740 FOR K = 1 TO 2
750 IJK = IJ(K)
753 EN(IJK) = EN(IJK) + 1!
755 REM ACCUMULATE WINS, LOSSES, AND TIES
760 A = GR(K) - GR(3 - K)
770 J = 1
780 IF A = 0! THEN J = 3
790 IF A < 0! THEN J = 2
800 WN(J, IJK) = WN(J, IJK) + 1
810 REM ACCUMULATE GRADES
820 AVE(IJK) = AVE(IJK) + GR(K)
830 REM COMPOSE INCIDENCE MATRIX
840 FOR J = 1 TO NSKED
850 IF N(IJK, J) = 0 THEN GOTO 890
860 NEXT J
865 GOSUB 2050
870 REM Print #8, " TOO MANY GAMES AGAINST ", N$
871 PRINT " TOO MANY GAMES AGAINST ", N$
880 STOP
890 N(IJK, J) = IJ(3 - K)
900 NEXT K
910 NEXT I
915 CLOSE #3
916 IF (TIEFOUND = 1) THEN PRINT #6, "PCT.  RRE    PF   PA  W  L T"
917 REM If (TIEFOUND = 1) Then Print "PCT.  RRE    PF   PA  W  L T"
918 IF (TIEFOUND = 0) THEN PRINT #6, "PCT.  RRE    PF   PA  W  L"
919 REM If (TIEFOUND = 0) Then Print "PCT.  RRE    PF   PA  W  L"
920 PRINT #6, " "
921 PRINT " "

925 REM ACCELERATED ONE-AT-A-TIME CONVERGENCE OF ESTIMATES
930 FOR II = 1 TO NIT
    ISA = 1
    REM The line below flags when to print the status of the
    REM current iteration to the screen.  If you would like to
    REM see output more often, change the value from 12.
    IF (II \ 12) * 12 = II THEN ISA = 0
931 FOR NNN = -3 TO 2
932 NN = NNN
933 IF NN < 0 THEN NN = 0
936 NN1 = NN + 1
937 IF NNN < 0 THEN NN1 = 0
940 MARK = 0
950 FOR I = 1 TO NTEAM
955 XZ(I, NN1) = XZ(I, NN)
960 IF N(I, 1) = 0 THEN GOTO 1070
965 MM = NN
966 IF N(I, 1) < I THEN MM = NN1
970 F = 1# / (XZ(I, NN) + XZ(N(I, 1), MM))
980 FOR J = 2 TO NSKED
990 IF N(I, J) = 0 THEN GOTO 1020
995 MM = NN
996 IF N(I, J) < I THEN MM = NN1
1000 F = F + 1# / (XZ(I, NN) + XZ(N(I, J), MM))
1010 NEXT J
1020 XX = AVE(I) / F
1030 XU = XX - XZ(I, NN)
1040 IF XU = 0# THEN GOTO 1070
1050 REM If Abs(XU) > DLIM * XX Then MARK = MARK + 1
1051 IF ABS(XU) > 0 THEN MARK = MARK + 1
1060 XZ(I, NN1) = XX
1070 NEXT I
1074 IF MARK = 0 THEN GOTO 1110
1076 NEXT NNN
    Q1 = 0#
    Q2 = 0#
    FOR I = 1 TO NTEAM
        XZ(I, 0) = LOG(XZ(I, 2) / XZ(I, 1))
        XZ(I, 1) = LOG(XZ(I, 3) / XZ(I, 2))
        Q1 = Q1 + XZ(I, 0) * XZ(I, 1)
        Q2 = Q2 + XZ(I, 0) * XZ(I, 0)
    NEXT I
    RA = Q1 / Q2
    RAL = 1# - .1# / MARK
    IF RA > RAL THEN RA = RAL
    Q = 1# / (1# - RA)
    IF ISA = 0 THEN PRINT "  Iter.    Q4           Total Shift"
    PRINT USING " #####  ###.#####  ##.##################"; II; Q4; ABS(XU)
    REM EVERY FEW ITERATIONS, WRITE OUT THE CURRENT RATING TO FILE
    REM HOW OFTEN? CHECK LINES 930-931
1080 IF ISA = 0 THEN OPEN "O", #9, "NEWGUESS.DB"
    FOR I = 1 TO NTEAM
        Q3 = Q
        IF ABS(XZ(I, 0)) <= ABS(XZ(I, 1)) THEN GOTO 1090
        Q4 = XZ(I, 0) / (XZ(I, 0) - XZ(I, 1))
        IF Q4 > Q3 THEN GOTO 1090
        IF Q4 < 1# THEN Q4 = 1#
        Q3 = Q4
1090 R = LOG(XZ(I, 2)) + XZ(I, 1) * Q3
        IF ISA = 0 THEN PRINT #9, R / FAC + XZM
        XZ(I, 0) = EXP(R)
    NEXT I
    IF ISA > 0 THEN GOTO 1099
    CLOSE #9
    REM PRINT "#9 CLOSED"
    PRINT "THIS ITERATION WRITTEN TO NEWGUESS.DB"
1099 NEXT II
NN1 = 0
1100 II = NIT
1108 REM NO NEED TO PRINT THE NUMBER OF ITERATIONS TO A FILE
1109 REM SO LET'S PRINT THIS TO THE SCREEN INSTEAD.
1110 REM Print #8, Using " ####"; II;
1111 REM Print #8, " ITERATIONS.  CRITERION UNMET FOR";
1112 REM Print #8, Using " ###"; MARK;
1113 REM Print #8, " TEAMS."
1115 REM Close #8
1116 PRINT USING " ####"; II;
1117 PRINT " ITERATIONS.  CRITERION UNMET FOR";
1118 PRINT USING " ###"; MARK;
1119 PRINT " TEAMS."

1120 REM COMPUTE AVERAGE GRADE (PCT.)
1130 FOR I = 1 TO NTEAM
1190 AVE(I) = AVE(I) / EN(I)
1200 NEXT I

1210 REM GET RRE
1220 FOR I = 1 TO NTEAM
1230 RRE(I) = 0!
1240 FOR J = 1 TO NTEAM
1250 RRE(I) = RRE(I) + 1! / (XZ(I, 0) + XZ(J, 0))
1260 NEXT J
1270 RRE(I) = (RRE(I) * XZ(I, 0) - .5) / NTM1
1280 NEXT I
1290 FOR I = 1 TO NTEAM
1300 IRAN(I) = I
1310 XZ(I, 0) = LOG(XZ(I, 0)) / FAC + XZM
1320 REM RRE(I) = 0.123
1325 REM print i, xz(i,0), NTM1
1330 NEXT I

1340 IF NOUT = 0 THEN GOTO 1386
1350 FOR I = 1 TO NOUT
1360 EL(I) = 1!
1370 NEXT I

1380 REM LN(DF) LEAST LIKELY RESULTS (APPROX. THEORY)
1385 REM EXACT LOG LIKELIHOOD OF SAMPLE
1386 REM ABC = 0.
1390 OPEN "I", #3, "SCORE.DB"
1400 FOR I = 1 TO NGAME
1410 INPUT #3, I1, S1, I2, S2
1420 DEL = S2 - S1
1430 R = .25
1440 IF DEL < 0! THEN R = .5 ELSE IF DEL > 0! THEN R = 0!
1450 GR(1) = R + .5 / (1! + EXP(FAC * DEL))
1460 GR(2) = 1! - GR(1)
1470 Z = EXP(FAC * (XZ(I1, 0) - XZ(I2, 0)))
1480 Z1 = Z / (1! + Z)
1483 ZC = 1! - Z1
1485 REM ABC = ABC + GR(1) * Log(Z1) + GR(2) * Log(ZC)
1490 X = (Z1 / GR(1)) ^ GR(1) * (ZC / GR(2)) ^ GR(2)
1500 IF NOUT = 0 OR X > EL(NOUT) THEN GOTO 1700
1510 EL(NOUT) = X
1520 ID(1, NOUT) = I1
1530 ID(2, NOUT) = I2
1540 S(1, NOUT) = S1
1550 S(2, NOUT) = S2
1555 IF NOUT1 < 1 THEN GOTO 1700
1560 FOR J = NOUT1 TO 1 STEP -1
1570 IF EL(J) < EL(J + 1) THEN GOTO 1700
1580 T = EL(J)
1590 EL(J) = EL(J + 1)
1600 EL(J + 1) = T
1610 FOR K = 1 TO 2
1620 II = ID(K, J)
1630 ID(K, J) = ID(K, J + 1)
1640 ID(K, J + 1) = II
1650 II = S(K, J)
1660 S(K, J) = S(K, J + 1)
1670 S(K, J + 1) = II
1680 NEXT K
1690 NEXT J
1700 NEXT I
1705 CLOSE #3

1710 REM PERCOLATOR SORT OF LOGITS
1720 LLA = 1
1730 FOR L = LLA TO NTM1
1740 IF XZ(IRAN(L), 0) >= XZ(IRAN(L + 1), 0) THEN GOTO 1810
1750 IT = IRAN(L)
1760 IRAN(L) = IRAN(L + 1)
1770 IRAN(L + 1) = IT
1780 IF L = 1 THEN GOTO 1810
1790 LLA = L - 1
1800 GOTO 1730
1810 NEXT L

1811 PRINT " "
1812 PRINT "Quick look at the top 15 teams..."
1813 PRINT " "

1815 FOR M = 1 TO NTEAM STEP 33
1816 OPEN "I", #2, "TEAM.DB"
1817 FOR K = 1 TO NTEAM
1818 INPUT #2, N$
1819 REM Print N$
1820 MP = M + 32
1821 IF NTEAM < MP THEN MP = NTEAM
1822 FOR L = M TO MP
1823 I = IRAN(L)
1824 IF K = I THEN GOTO 1827
1825 NEXT L
1826 GOTO 1828
1827 P$(L + 1 - M) = N$
1828 NEXT K
1829 CLOSE #2
1831 MP = M + 32
1832 IF NTEAM < MP THEN MP = NTEAM
1836 FOR L = M TO MP
1837 I = IRAN(L)
1840 PRINT #6, USING "  ### \                    \"; L; P$(L + 1 - M);
1843 PRINT #6, USING " \    \#####.##  .###"; DI$(I); XZ(I, 0); AVE(I);
1847 PRINT #6, USING "  .### #### ####"; RRE(I); PF(I); PA(I);
1848 IF (TIEFOUND = 1) THEN PRINT #6, USING " ## ## #"; WN(1, I); WN(2, I); WN(3, I)
1849 IF (TIEFOUND = 0) THEN PRINT #6, USING " ## ##"; WN(1, I); WN(2, I)
1850 REM PCT. DENOTES AVERAGE GRADED MARGIN
1860 REM RRE DENOTES ROUND ROBIN EQUIVALENT OF PCT.
1870 REM PF DENOTES TOTAL POINTS SCORED FOR TEAM
1880 REM PA DENOTES TOTAL POINTS SCORED AGAINST TEAM
1882 IF L <= 15 THEN
1883 PRINT USING "  ### \                    \"; L; P$(L + 1 - M);
1884 PRINT USING " \    \#####.##  .###"; DI$(I); XZ(I, 0); AVE(I);
1885 PRINT USING "  .### #### ####"; RRE(I); PF(I); PA(I);
1886 IF (TIEFOUND = 1) THEN PRINT USING " ## ## #"; WN(1, I); WN(2, I); WN(3, I)
1887 IF (TIEFOUND = 0) THEN PRINT USING " ## ##"; WN(1, I); WN(2, I)
1888 END IF
1890 NEXT L
1895 NEXT M

1899 IF NOUT = 0 THEN GOTO 1990
1900 PRINT #6, " "
1904 REM CK HAS COMMENTED OUT THE NATURAL LOG PART OF THE LEAST
1905 REM LIKELY HEADER -- I DID NOT FIND IT TOO USEFUL
1906 REM PRINT #6, USING "  LN(####"; NGAME;
1907 REM PRINT #6, "-";
1908 REM PRINT #6, USING "###+1) "; NTEAM;
1910 REM PRINT #6, "LEAST LIKELY RESULTS OF TOURNAMENT (APPROX. THEORY)"
1911 PRINT #6, "                 LEAST LIKELY RESULTS OF TOURNAMENT"
1920 PRINT #6, " "
1930 FOR L = 1 TO NOUT
1960 PRINT #6, USING "   #"; L;
1962 FOR K = 1 TO 2
1964 IJK = ID(K, L)
1966 GOSUB 2050
1970 PRINT #6, USING " \               \"; N$;
1971 PRINT #6, USING " \     \ ###"; DI$(IJK); S(K, L);
1975 NEXT K
1977 PRINT #6, USING " #.###"; EL(L)
1980 NEXT L
1990 PRINT #6, " "
1991 REM Print #6, "   DAVID ROTHMAN, EXECUTIVE DIRECTOR, FACT,";
1992 REM Print #6, " 14125 DOTY AVENUE, #23,"
1993 REM Print #6, "   HAWTHORNE, CA 90250-8042, (310)676-4032, drothman1@juno.com"
2000 PRINT #6, " "
2001 PRINT #6, "     FOUNDATION FOR THE ANALYSIS OF COMPETITIONS AND TOURNAMENTS (FACT)"
2002 PRINT #6, "                     DAVID ROTHMAN (1935-2004), FOUNDER"
2003 PRINT #6, "               FACT standings calculated by Cody Kirkpatrick"
2004 PRINT #6, "                          talismanred.com/ratings"
2030 CLOSE #6

2040 END
2045 REM FIND IJK-TH TEAM NAME
2050 OPEN "I", #2, "TEAM.DB"
2060 FOR KK = 1 TO IJK
2070 INPUT #2, N$
2080 NEXT KK
2090 CLOSE #2
2100 RETURN

