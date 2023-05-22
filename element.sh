#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
elif [[ $1 =~ ^[0-9]+$ ]]
 then
 TEST=$($PSQL "select atomic_number from elements where atomic_number = $1")
 if [[ -z $TEST ]]
then
echo "I could not find that element in the database."
else
 echo $($PSQL "select atomic_number, name, symbol, atomic_mass, type, melting_point_celsius, boiling_point_celsius from elements full join properties using(atomic_number) right join types using(type_id) where atomic_number = $1") | while read NUMBER BAR NAME BAR SYMBOL BAR MASS BAR TYPE BAR MELTING BAR BOILING
 do
   echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
 done
 fi
elif [[ $1 =~ ^[A-Za-z]{1,2}$ ]]
then
  TEST=$($PSQL "select symbol from elements where symbol = '$1'")
  if [[ -z $TEST ]]
  then
    echo "I could not find that element in the database."
  else
  echo $($PSQL "select atomic_number, name, symbol, atomic_mass, type, melting_point_celsius, boiling_point_celsius from elements full join properties using(atomic_number) right join types using(type_id) where symbol = '$1'") | while read NUMBER BAR NAME BAR SYMBOL BAR MASS BAR TYPE BAR MELTING BAR BOILING
  do
    echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  done
  fi
elif [[ $1 =~ [a-z]{3,} ]]
then
  TEST=$($PSQL "select name from elements where name = '$1'")
  if [[ -z $TEST ]]
  then
    echo "I could not find that element in the database."
  else
    echo $($PSQL "select atomic_number, name, symbol, atomic_mass, type, melting_point_celsius, boiling_point_celsius from elements full join properties using(atomic_number) right join types using(type_id) where name = '$1'") | while read NUMBER BAR NAME BAR SYMBOL BAR MASS BAR TYPE BAR MELTING BAR BOILING
    do
      echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done 
  fi 
fi
