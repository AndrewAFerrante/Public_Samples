libname mylib "C:\Users\Owner\Documents\2Data";   /* Create library. */

proc import datafile=mylib.bls;   
  dbms=xlsx                                      
  out=bls                                        /* Name of SAS table. */
  replace;                                                  
  sheet=sheet1;                                  /* This is the name of the excel sheet you want to import. */
run;

libname xlclass clear;
