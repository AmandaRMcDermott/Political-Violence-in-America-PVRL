                                                                               
/*                                                                             
/*             SPSS DATA DEFINITION STATEMENTS FOR ICPSR 5206                  
/*                  POLITICAL EVENTS PROJECT, 1948-1965                        
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
                                                                               
FILE HANDLE DATA / NAME="file-specification" LRECL=38.                         
DATA LIST FILE=DATA /                                                          
   V1 1-4                   V2 5-7                   V3 8-9                    
   V4 10-11                 V5 12-13                 V6 14-15                  
   V7 16-16                 V8 17-17                 V9 18-19                  
   V10 20-21                V11 22-23                V12 24-25                 
   V13 26-27                V14 28-28                V15 29-29                 
   V16 30-30                V17 31-31                V18 32-32                 
   V19 33-33                V20 34-34                V21 35-38.                
                                                                               
* SPSS VARIABLE LABELS COMMAND.                                                
                                                                               
VARIABLE LABELS                                                                
   V1 "STUDY NUMBER (7517)"                                                    
   V2 "COUNTRY CODE"                                                           
   V3 "YEAR OF EVENT"                                                          
   V4 "MONTH OF EVENT"                                                         
   V5 "DAY OF EVENT"                                                           
   V6 "TYPE OF EVENT"                                                          
   V7 "PRESENCE OF VIOLENCE"                                                   
   V8 "LOCATION OF EVENT"                                                      
   V9 "DURATION OF EVENT"                                                      
   V10 "NUMBER INVOLVED"                                                       
   V11 "NUMBER KILLED"                                                         
   V12 "NUMBER INJURED"                                                        
   V13 "NUMBER ARRESTED"                                                       
   V14 "PROPERTY DAMAGE"                                                       
   V15 "NATURE OF TENSION"                                                     
   V16 "OUTCOME CODE"                                                          
   V17 "F,F,AND N SCALE"                                                       
   V18 "SIGNIFICANT PERSON?"                                                   
   V19 "SOURCE CODE"                                                           
   V20 "GUTTMAN SCALE SCORES"                                                  
   V21 "SERIAL NUMBER OF EVENT".                                               
                                                                               
* SPSS VALUE LABELS COMMAND.                                                   
                                                                               
VALUE LABELS                                                                   
   V2                                                                          
   002 "UNITED STATES"                                                         
   020 "CANADA"                                                                
   040 "CUBA"                                                                  
   041 "HAITI"                                                                 
   042 "DOMINICAN REPUBLIC"                                                    
   070 "MEXICO"                                                                
   090 "GUATEMALA"                                                             
   091 "HONDURAS"                                                              
   092 "EL SALVADOR"                                                           
   093 "NICARAGUA"                                                             
   094 "COSTA RICA"                                                            
   095 "PANAMA"                                                                
   100 "COLOMBIA"                                                              
   101 "VENEZUELA"                                                             
   130 "ECUADOR"                                                               
   135 "PERU"                                                                  
   140 "BRAZIL"                                                                
   145 "BOLIVIA"                                                               
   150 "PARAGUAY"                                                              
   155 "CHILE"                                                                 
   160 "ARGENTINA"                                                             
   165 "URUGUAY"                                                               
   200 "UNITED KINGDOM"                                                        
   205 "IRELAND"                                                               
   210 "NETHERLANDS"                                                           
   211 "BELGIUM"                                                               
   212 "LUXEMBOURG"                                                            
   220 "FRANCE"                                                                
   225 "SWITZERLAND"                                                           
   230 "SPAIN"                                                                 
   235 "PORTUGAL"                                                              
   255 "WEST GERMANY"                                                          
   265 "EAST GERMANY"                                                          
   290 "POLAND"                                                                
   305 "AUSTRIA"                                                               
   310 "HUNGARY"                                                               
   315 "CZECHOSLOVAKIA"                                                        
   325 "ITALY"                                                                 
   339 "ALBANIA"                                                               
   345 "YUGOSLAVIA"                                                            
   350 "GREECE"                                                                
   352 "CYPRUS"                                                                
   355 "BULGARIA"                                                              
   360 "RUMANIA"                                                               
   365 "U"                                                                     
   375 "FINLAND"                                                               
   380 "SWEDEN"                                                                
   385 "NORWAY"                                                                
   390 "DENMARK"                                                               
   395 "ICELAND"                                                               
   450 "LIBERIA"                                                               
   452 "GHANA"                                                                 
   530 "ETHIOPIA"                                                              
   560 "UNION OF SOUTH AFRICA"                                                 
   600 "MOROCCO"                                                               
   616 "TUNISIA"                                                               
   620 "LIBYA"                                                                 
   625 "SUDAN"                                                                 
   630 "IRAN"                                                                  
   640 "TURKEY"                                                                
   645 "IRAQ"                                                                  
   651 "EGYPT"                                                                 
   652 "SYRIA"                                                                 
   660 "LEBANON"                                                               
   663 "JORDAN"                                                                
   666 "ISRAEL"                                                                
   670 "SAUDI ARABIA"                                                          
   700 "AFGHANISTAN"                                                           
   710 "CHINA (MAINLAND)"                                                      
   713 "CHINA (TAIWAN)"                                                        
   732 "SOUTH KOREA"                                                           
   740 "JAPAN"                                                                 
   750 "INDIA"                                                                 
   770 "PAKISTAN"                                                              
   775 "BURMA"                                                                 
   780 "CEYLON"                                                                
   800 "THAILAND"                                                              
   811 "CAMBODIA"                                                              
   812 "LAOS"                                                                  
   820 "MALAYA"                                                                
   840 "PHILIPPINES"                                                           
   850 "INDONESIA"                                                             
   900 "AUSTRALIA"                                                             
   920 "NEW ZEALAND" /                                                         
   V3                                                                          
   48 "1948"                                                                   
   49 "1949"                                                                   
   50 "1950"                                                                   
   51 "1951"                                                                   
   52 "1952"                                                                   
   53 "1953"                                                                   
   54 "1954"                                                                   
   55 "1955"                                                                   
   56 "1956"                                                                   
   57 "1957"                                                                   
   58 "1958"                                                                   
   59 "1959"                                                                   
   60 "1960"                                                                   
   61 "1961"                                                                   
   62 "1962"                                                                   
   63 "1963"                                                                   
   64 "1964"                                                                   
   65 "1965" /                                                                 
   V4                                                                          
   01 "JANUARY"                                                                
   02 "FEBRUARY"                                                               
   03 "MARCH"                                                                  
   04 "APRIL"                                                                  
   05 "MAY"                                                                    
   06 "JUNE"                                                                   
   07 "JULY"                                                                   
   08 "AUGUST"                                                                 
   09 "SEPTEMBER"                                                              
   10 "OCTOBER"                                                                
   11 "NOVEMBER"                                                               
   12 "DECEMBER"                                                               
   99 "<NA>" /                                                                 
   V5                                                                          
   01 "FIRST OF MONTH OR FIRST EVENT OF YEAR IF MONTH NA"                      
   31 "31ST OF MONTH OR LAST EVENT OF YEAR IF MONTH NA"                        
   00 "<NA>" /                                                                 
   V6                                                                          
   01 "ELECTIONS  (THIS CATEGORY ENCOMPASSES ALL NATIONAL"                     
   02 "DISSOLUTION OF LEGISLATURE  (THIS CATEGORY ENCOM-"                      
   03 "RESIGNATIONS OF POLITICALLY SIGNIFICANT PERSONS"                        
   04 "DISMISSAL OF POLITICALLY SIGNIFICANT PERSONS  (ALL"                     
   05 "FALL OF CABINET  (WHEN THE ENTIRE CABINET RESIGNS OR"                   
   06 "SIGNIFICANT CHANGE OF LAWS  (SIGNIFICANT CHANGES OF"                    
   07 "PLEBISCITE  (A PLEBISCITE IS A SPECIAL VOTE OR"                         
   08 "APPOINTMENT OF POLITICALLY SIGNIFICANT PERSONS  (ALL"                   
   09 "ORGANIZATION OF NEW GOVERNMENT  (THIS CATEGORY IS"                      
   10 "RESHUFFLE OF GOVERNMENT  (THIS EVENT IS DEFINED AS"                     
   11 "SEVERE TROUBLE WITHIN A NON-GOVERNMENTAL ORGANIZA-"                     
   12 "ORGANIZATION OF OPPOSITION PARTY  (WHEN AN OPPOSI-"                     
   13 "GOVERNMENTAL ACTION AGAINST SPECIFIC GROUPS  (THIS"                     
   14 "STRIKES  (STRIKES ARE DEFINED AS THE COLLECTIVE"                        
   15 "DEMONSTRATIONS  (THIS CATEGORY INCLUDES AN ORGANIZED"                   
   16 "BOYCOTTS  (BOYCOTTS ARE DEFINED AS THE DENIAL OF"                       
   17 "ARRESTS  (ARRESTS ARE DEFINED AS THE GOVERNMENTAL"                      
   18 "SUICIDES  (THIS CATEGORY INCLUDES ONLY POLITICALLY"                     
   19 "MARTIAL LAW  (THIS CATEGORY ENCOMPASSES THE SUSPEN-"                    
   21 "EXECUTIONS  (ALL POLITICALLY MOTIVATED KILLINGS OF"                     
   22 "ASSASSINATIONS  (ASSASSINATION IS DEFINED AS THE"                       
   23 "TERRORISM  (TERRORISM CONSISTS OF ORGANIZED VIOLENT"                    
   24 "SABOTAGE  (SABOTAGE IS ALSO ORGANIZED, VIOLENT AND"                     
   25 "GUERRILLA WARFARE  (THIS CATEGORY INCLUDES ARMED"                       
   26 "CIVIL WAR  (THIS CATEGORY INVOLVES AN ALL-OUT WAR"                      
   27 "COUP DETAT  (A COUP DETAT IS DEFINED AS AN ILLEGAL"                     
   28 "REVOLT  (A REVOLT IS AN ARMED ATTEMPT ON THE PART OF"                   
   29 "EXILE  (POLITICALLY MOTIVATED VOLUNTARY OR INVOLUN-" /                  
   V7                                                                          
   0 "NO VIOLENCE REPORTED"                                                    
   1 "VIOLENCE REPORTED"                                                       
   9 "<INAP" /                                                                 
   V8                                                                          
   0 "NO DATA"                                                                 
   1 "CAPITAL CITY"                                                            
   2 "URBAN BUT NOT CAPITAL CITY"                                              
   3 "RURAL (PROVINCES OR STATES)"                                             
   4 "WHOLE COUNTRY OR MAJOR SEGMENT"                                          
   5 "OUTSIDE COUNTRY"                                                         
   7 "<INAP" /                                                                 
   V9                                                                          
   10 "0 TO 1/2 DAY"                                                           
   20 "1/2 DAY TO ONE DAY"                                                     
   30 "1 DAY TO TWO DAYS"                                                      
   40 "2 DAYS TO ONE WEEK"                                                     
   41 "SHORT (A WEEK OR LESS FOR ALL EVENTS EXCEPT CIVIL"                      
   50 "1 WEEK TO TWO WEEKS"                                                    
   60 "2 WEEKS TO ONE MONTH"                                                   
   70 "1 MONTH TO 6 MONTHS"                                                    
   71 "LONG (OVER A WEEK FOR ALL EVENTS EXCEPT CIVIL WARS"                     
   80 "6 MONTHS TO 1 YEAR"                                                     
   90 "1 YEAR PLUS"                                                            
   98 "NOT ENOUGH DATA FOR RATING"                                             
   99 "<INAP" /                                                                
   V10                                                                         
   10 "1"                                                                      
   11 "INDIVIDUAL"                                                             
   20 "2-10"                                                                   
   30 "11-50"                                                                  
   31 "FEW (BETWEEN 2-50 PERSONS ON RESIGNATIONS, DISMIS-"                     
   40 "51-100"                                                                 
   50 "101-500"                                                                
   60 "501-1,000"                                                              
   70 "1,001-10,000"                                                           
   71 "MASS (OVER 50 PERSONS ON RESIGNATIONS, DISMISSALS,"                     
   80 "10,001-100,000"                                                         
   90 "OVER 100,000"                                                           
   98 "NOT ENOUGH DATA FOR RATING"                                             
   99 "<INAP" /                                                                
   V11                                                                         
   00 "ZERO"                                                                   
   10 "1"                                                                      
   11 "(INDIVIDUAL)"                                                           
   20 "2-10"                                                                   
   30 "11-50"                                                                  
   31 "FEW (2-50 PERSONS)"                                                     
   40 "51-100"                                                                 
   50 "101-500"                                                                
   60 "501-1,000"                                                              
   70 "1,001-10,000"                                                           
   71 "MASS (OVER 50 PERSONS)"                                                 
   80 "10,001-100,000"                                                         
   98 "NOT ENOUGH DATA FOR RATING"                                             
   99 "<INAP" /                                                                
   V12                                                                         
   00 "ZERO"                                                                   
   10 "1"                                                                      
   11 "(INDIVIDUAL)"                                                           
   20 "2-10"                                                                   
   30 "11-50"                                                                  
   40 "51-100"                                                                 
   41 "FEW (2-100 PERSONS)"                                                    
   50 "101-500"                                                                
   60 "501-1,000"                                                              
   70 "1,001-10,000"                                                           
   71 "MASS (OVER 100 PERSONS)"                                                
   80 "10,001-100,000"                                                         
   90 "OVER 100,000"                                                           
   98 "NOT ENOUGH DATA FOR RATING"                                             
   99 "<INAP" /                                                                
   V13                                                                         
   00 "ZERO"                                                                   
   10 "1"                                                                      
   11 "(INDIVIDUAL)"                                                           
   20 "2-10"                                                                   
   30 "11-25"                                                                  
   40 "26-50"                                                                  
   41 "FEW (2-100 PERSONS)"                                                    
   50 "51-100"                                                                 
   60 "101-1,000"                                                              
   70 "1,001-10,000"                                                           
   71 "MASS (OVER 100 PERSONS)"                                                
   80 "10,001-100,000"                                                         
   90 "OVER 100,000"                                                           
   98 "NOT ENOUGH DATA FOR RATING"                                             
   99 "<INAP" /                                                                
   V14                                                                         
   0 "ZERO"                                                                    
   1 "LITTLE ($30,000 OR LESS)"                                                
   2 "MUCH (OVER $30,000)"                                                     
   9 "<INAP" /                                                                 
   V15                                                                         
   1 "POLITICAL (INCLUDES ANYTHING NOT COVERED BY OTHER"                       
   2 "RELIGIOUS"                                                               
   3 "ECONOMIC"                                                                
   4 "ETHNIC"                                                                  
   5 "EDUCATIONAL" /                                                           
   V16                                                                         
   0 "NO DATA OR INDETERMINATE"                                                
   1 "SUCCESSFUL"                                                              
   2 "UNSUCCESSFUL"                                                            
   9 "<INAP" /                                                                 
   V17                                                                         
   0 "POINT 0"                                                                 
   1 "POINT 1"                                                                 
   2 "POINT 2"                                                                 
   3 "POINT 3"                                                                 
   4 "POINT 4"                                                                 
   5 "POINT 5"                                                                 
   6 "POINT 6" /                                                               
   V18                                                                         
   0 "SIGNIFICANT PERSON"                                                      
   1 "INSIGNIFICANT PERSON"                                                    
   9 "<INAP" /                                                                 
   V19                                                                         
   0 "DEADLINE DATA ON WORLD AFFAIRS"                                          
   1 "DEADLINE DATA ON WORLD AFFAIRS SUPPLEMENTED BY ADDI-" /                  
   V20                                                                         
   1 "POINT 1"                                                                 
   2 "POINT 2"                                                                 
   3 "POINT 3"                                                                 
   4 "POINT 4"                                                                 
   9 "(INAP" /.                                                                
                                                                               
* SPSS MISSING VALUES COMMAND.                                                 
                                                                               
* MISSING VALUES                                                               
   V4 (0000099 THRU HI)                V5 (0000000)                            
   V7 (0000009 THRU HI)                V8 (0000007 THRU HI)                    
   V9 (0000098 THRU HI)                V10 (0000098 THRU HI)                   
   V11 (0000098 THRU HI)               V12 (0000098 THRU HI)                   
   V13 (0000098 THRU HI)               V14 (0000009 THRU HI)                   
   V16 (0000009 THRU HI)               V18 (0000009 THRU HI)                   
   V20 (0000009 THRU HI)                .                                      
