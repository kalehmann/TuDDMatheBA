#! /usr/bin/env bats

@test "bauzins.f95" {
      run ./bauzins <<EOF
100
0
10
EOF
      [[ "$status" -eq 0 ]]
      [[ "${#lines[@]}" -eq 4 ]]
      [[ "${lines[3]}" == *"Laufzeit:    10.0000000      Zinssumme:    0.00000000"* ]]
}

@test "zahlenraten.f95 Erfolg" {
      run ./zahlenraten <<EOF
100
200
>
>
>
<
=
n
EOF
      [[ "$status" -eq 0 ]]
      [[ "${#lines[@]}" -eq 26 ]]
}


@test "zahlenraten.f95 Logikfehler" {
      run ./zahlenraten <<EOF
1
5
>
>
>
EOF
      [[ "$status" -eq 1 ]]
      [[ "${#lines[@]}" -eq 22 ]]
      [[ "${lines[20]}" == *"Logikfehler !"* ]]
}

@test "zahlenraten.f95 Anzahl Versuche" {
      run ./zahlenraten <<EOF
1
7
>
>
=
n
EOF
      [[ "$status" -eq 0 ]]
      [[ "${#lines[@]}" -eq 22 ]]
      [[ "${lines[20]}" == *"Ich habe folgende Zahl an Versuchen benoetigt:            3"* ]]
}


@test "zahlenraten.f95 Anzahl Wiederholung" {
      run ./zahlenraten <<EOF
1
4
<
=
y
1
5
>
>
=
n
EOF
      [[ "$status" -eq 0 ]]
}

@test "zyklus.f95" {
      run ./zyklus <<EOF
5
3
8
1
7
9
EOF
      [[ "${#lines[@]}" -eq 9 ]]      
      [[ "${lines[8]}" == *"Maximum:            9  Minimum:            1  Summe:           28  Durchschnitt:            5"* ]]
}
