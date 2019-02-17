                                                                               
/*                                                                             
/*             SPSS DATA DEFINITION STATEMENTS FOR ICPSR 0080                  
/*           POLITICAL VIOLENCE IN THE UNITED STATES, 1819-1968                
/*                           MAY 1981 VERSION                                  
/*                                                                             
/*   The following SPSS setup sections appear in this file for the LRECL       
/*   version of this data collection.  These sections are listed below:        
/*                                                                             
/*   DATA LIST contains the SPSS statements which assign the variable names    
/*   and specify the beginning and ending column locations for each variable.  
/*                                                                             
/*   VARIABLE LABELS assigns variable labels for all variables in the data     
/*   file.                                                                     
/*                                                                             
/*   MISSING VALUES contains SPSS program statements which set the values      
/*   that are interpreted as missing by the SPSS system.  Please note that     
/*   the MISSING VALUES section has been commented out (i.e., '*').            
/*   To include this section in the final SPSS setup, remove the comment       
/*   indicators from the section.                                              
/*                                                                             
/*   VALUE LABELS:  assign descriptive labels to codes in the data file.       
/*   Not all variables necessarily have assigned value labels.                 
/*                                                                             
/*   Users may combine and modify these sections or parts of these sections    
/*   to suit their specific needs.  Users will also need to change the         
/*   file-specification in the DATA LIST statement to an appropriate filename  
/*   for their system.                                                         
/*                                                                             
*******************************************************************************
*                                                                              
                                                                               
                                                                               
* SPSS DATA LIST COMMAND.                                                      
                                                                               
FILE HANDLE DATA / NAME="file-specification" LRECL=58.                         
DATA LIST FILE=DATA /                                                          
   V1 1-5                   V2 6-10                  V3 11-12                  
   V4 13-14                 V5 15-16                 V6 17-18                  
   V7 19-22                 V8 23-25                 V9 26-27                  
   V10 28-28                V11 29-30                V12 31-31                 
   V13 32-32                V14 33-34                V15 35-35                 
   V16 36-37                V17 38-39                V18 40-40                 
   V19 41-41                V20 42-43                V21 44-45                 
   V22 46-46                V23 47-49                V24 50-50                 
   V25 51-52                V26 53-53                V27 54-54                 
   V28 55-55                V29 56-56                V30 57-58 (1).            
                                                                               
* SPSS VARIABLE LABELS COMMAND.                                                
                                                                               
VARIABLE LABELS                                                                
   V1 "ISSUE IDENTIFICATION NO."                                               
   V2 "EVENT IDENTIFICATION NO."                                               
   V3 "EVENT/ISSUE NO."                                                        
   V4 "NEWSPAPER IDENTIFICATION"                                               
   V5 "MONTH OF ISSUE"                                                         
   V6 "DAY OF ISSUE"                                                           
   V7 "YEAR OF ISSUE"                                                          
   V8 "PAGE OF CITATION"                                                       
   V9 "NATURE OF THE TARGET"                                                   
   V10 "PROPERTY AS TARGET"                                                    
   V11 "NUMBER OF ATTACKERS"                                                   
   V12 "INDIVIDUAL VIOLENCE"                                                   
   V13 "GROUP VIOLENCE"                                                        
   V14 "MOTIVATION FOR ATTACK"                                                 
   V15 "INJURY TO INDIVIDL TRGT"                                               
   V16 "INJURY TO GROUP TARGET"                                                
   V17 "NUMBER KILLED-TARGET"                                                  
   V18 "PROPERTY DAMAGE-TARGET"                                                
   V19 "INJURY TO INDVDL ATTACKR"                                              
   V20 "INJURY TO GROUP ATTACKER"                                              
   V21 "NUMBER KILLED-ATTACKER"                                                
   V22 "PROPERTY DAMAGE-ATTACKER"                                              
   V23 "TOTAL PAGES IN ISSUE"                                                  
   V24 "WEEKDAY OF ISSUE"                                                      
   V25 "CODER IDENTIFICATION NO."                                              
   V26 "EVENT OCCURENCE"                                                       
   V27 "TYPE OF GROUP AS TARGET"                                               
   V28 "TYPE INDVDL AS ATTACKER"                                               
   V29 "TYPE GROUP AS ATTACKER"                                                
   V30 "WEIGHT  VARIABLE".                                                     
                                                                               
* SPSS MISSING VALUES COMMAND.                                                 
                                                                               
* MISSING VALUES                                                               
   V1 (0099999)                        V2 (0099999)                            
   V3 (0000099)                        V4 (0000099)                            
   V5 (0000099)                        V6 (0000099)                            
   V7 (0009999)                        V8 (0000999)                            
   V9 (0000099 THRU HI, 0000098)       V10 (0000009 THRU HI, 0000008)          
   V11 (0000099 THRU HI, 0000098)      V12 (0000009 THRU HI, 0000008)          
   V13 (0000009 THRU HI, 0000008)      V14 (0000099 THRU HI, 0000098)          
   V15 (0000009 THRU HI, 0000008)      V16 (0000099 THRU HI, 0000098)          
   V17 (0000099 THRU HI, 0000098)      V18 (0000009 THRU HI, 0000008)          
   V19 (0000009 THRU HI, 0000008)      V20 (0000099 THRU HI, 0000098)          
   V21 (0000099 THRU HI, 0000098)      V22 (0000009 THRU HI, 0000008)          
   V23 (0000999)                       V24 (0000009)                           
   V25 (0000099)                       V26 (0000009 THRU HI, 0000008)          
   V27 (0000009 THRU HI, 0000008)      V28 (0000009 THRU HI, 0000008)          
   V29 (0000009 THRU HI, 0000008)      V30 (000009.).                          
