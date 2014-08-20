;; 1. Based on:
;; 2. Description: 2 compartment oral simulation
;; x1. Author: Devin
;; 3. Label:
;; NOTES: 
;; ENDNOTES
$PROBLEM    single id simulation
$INPUT      ID TIME DV MDV AMT DOSE
$DATA       ../data/simulation_dat.csv IGNORE=@
$SUBROUTINE ADVAN4 TRANS4
$PK  
CL=THETA(1) ;clearance
V2=THETA(2)             ;central volume
Q=THETA(3)              ;intercompartmental clearance
V3=THETA(4)            ;peripheral volume
KA=THETA(5)            ;absorption rate constant
S2=V2

;-------------------PREDICTION----------------
$ERROR 
REP = IREP
IPRED=F
IRES = DV-IPRED
W = THETA(6)
IWRES = IRES/W
Y = IPRED*(1 + ERR(1)*W)
;-------------------INITIAL ESTIMATES---------
$THETA  (0,10) ; TH_CL
$THETA  (0,50) ; TH_V2
$THETA  (0,6) ; TH_Q
$THETA  (0,100) ; TH_V3
$THETA  (0,1) ; TH_KA
$THETA  (0,0.15) ; residual CV
$OMEGA  1.000000  FIX
$SIMULATION (1234567) ONLYSIM
$TABLE      ID TIME DV MDV AMT DOSE PRED NOAPPEND ONEHEADER NOPRINT
            FILE=singleid_sim.dat