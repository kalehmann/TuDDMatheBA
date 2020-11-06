#! /usr/bin/env bats

@test "potenz_a.f95" {
      run ./potenz_a <<EOF
30
EOF
      [[ "${#lines[@]}" -eq 31 ]]
      [[ "${lines[1]}" == *"2"* ]]
      [[ "${lines[30]}" == *"1073741824"* ]]
}

@test "potenz_b.f95 Erfolgsfall" {
      run ./potenz_a <<EOF
30
EOF
      [[ "${#lines[@]}" -eq 31 ]]
      [[ "${lines[1]}" == *"2"* ]]
      [[ "${lines[30]}" == *"1073741824"* ]]
}

@test "potenz_b.f95 Fehlerfall" {
      run ./potenz_b <<EOF
31
EOF
      [[ "${#lines[@]}" -eq 32 ]]
      [[ "${lines[1]}" == *"2"* ]]
      [[ "${lines[30]}" == *"1073741824"* ]]
      [[ "${lines[31]}" == *"Groessere Potenzen koennen mit dem Datentyp nicht mehr abgebildet werden"* ]]
}

@test "potenz_c.f95 Erfolgsfall" {
      run ./potenz_c <<EOF
30
EOF
      [[ "${#lines[@]}" -eq 31 ]]
      [[ "${lines[1]}" == *"2"* ]]
      [[ "${lines[30]}" == *"1073741824"* ]]
}

@test "potenz_c.f95 Fehlerfall" {
      run ./potenz_c <<EOF
31
EOF
      [[ "${#lines[@]}" -eq 32 ]]
      [[ "${lines[1]}" == *"2"* ]]
      [[ "${lines[30]}" == *"1073741824"* ]]
      [[ "${lines[31]}" == *"Groessere Potenzen koennen mit dem Datentyp nicht mehr abgebildet werden"* ]]
}

@test "potenz_d.f95 Erfolgsfall" {
      run ./potenz_d <<EOF
62
EOF
      [[ "${#lines[@]}" -eq 63 ]]
      [[ "${lines[1]}" == *"2"* ]]
      [[ "${lines[30]}" == *"1073741824"* ]]
      [[ "${lines[62]}" == *"4611686018427387904"* ]]
}

@test "potenz_d.f95 Fehlerfall" {
      run ./potenz_d <<EOF
63
EOF
      [[ "${#lines[@]}" -eq 64 ]]
      [[ "${lines[1]}" == *"2"* ]]
      [[ "${lines[30]}" == *"1073741824"* ]]
      [[ "${lines[62]}" == *"4611686018427387904"* ]]
      [[ "${lines[63]}" == *"Groessere Potenzen koennen mit dem Datentyp nicht mehr abgebildet werden"* ]]
}

@test "fakultaet.f95" {
      run ./fakultaet <<EOF
5
EOF
      [[ "${lines[1]}" == *"120"* ]]
}
